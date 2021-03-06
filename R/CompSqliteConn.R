#' Class for handling a Compound database in SQLite format.
#'
#' This is the connector class for a Compound database.
#'
#' @seealso Super class \code{\link{SqliteConn}}.
#'
#' @examples
#' # Create an instance with default settings:
#' mybiodb <- biodb::newInst()
#'
#' # Get a connector:
#' chebi_file <- system.file("extdata", "chebi_extract.sqlite", package="biodb")
#' conn <- mybiodb$getFactory()$createConn('comp.sqlite', url=chebi_file)
#'
#' # Get an entry
#' e <- conn$getEntry('1018')
#'
#' # Terminate instance.
#' mybiodb$terminate()
#'
#' @import R6
#' @include SqliteConn.R
#' @export
CompSqliteConn <- R6::R6Class('CompSqliteConn',
inherit=SqliteConn,


public=list(


),

private=list(
doSearchForEntries=function(fields=NULL, max.results=0) {
    # Overrides super class' method.

    ids <- character()
    private$initDb()

    if ( ! is.null(private$db)) {

        query <- BiodbSqlQuery$new()
        query$setTable('entries')
        query$setDistinct(TRUE)
        query$setWhere(BiodbSqlLogicalOp$new(op='and'))

        # Search by name
        if ('name' %in% names(fields)) {
            query$addJoin(table1='name', field1='accession',
                table2='entries', field2='accession')
            expr <- BiodbSqlBinaryOp$new(lexpr=BiodbSqlField$new(table='name',
                field='name'), op='=',
                rexpr=BiodbSqlValue$new(fields$name))
            query$getWhere()$addExpr(expr)
        }
        
        # Search by mass
        ef <- self$getBiodb()$getEntryFields()
        for (field in names(fields)) {
            
            # This is a mass field
            if (ef$get(field)$getType() == 'mass') {
                param <- fields[[field]]
                
                # Compute range
                if ('min' %in% names(param)) {
                    private$checkMassField(mass=param$min, mass.field=field)
                    rng <- list(a=param$min, b=param$max)
                }
                else {
                    private$checkMassField(mass=param$value, mass.field=field)
                    if ('delta' %in% names(param))
                        rng <- convertTolToRange(param$value, param$delta,
                            'delta')
                    else
                        rng <- convertTolToRange(param$value, param$ppm, 'ppm')
                }
                
                # Complete query
                expr <- BiodbSqlBinaryOp$new(
                    lexpr=BiodbSqlField$new(table="entries", field=field),
                    op='>=', rexpr=BiodbSqlValue$new(rng$a))
                query$getWhere()$addExpr(expr)
                expr <- BiodbSqlBinaryOp$new(
                    lexpr=BiodbSqlField$new(table="entries", field=field),
                    op='<=', rexpr=BiodbSqlValue$new(rng$b))
                query$getWhere()$addExpr(expr)
            }
        }
        
        # Cut
        if (max.results > 0)
            query$setLimit(max.results)
        
        # Run query
        query$addField(table="entries", field='accession')
        x <- self$getQuery(query)
        ids <- x[[1]]
    }
    
    return(ids)
}
))
