#' This class represents an SQL list.
#'
#' @import R6
#' @include BiodbSqlExpr.R
BiodbSqlList <- R6::R6Class("BiodbSqlList",
inherit=BiodbSqlExpr,

public=list(

#' @description
#' Initializer.
#' @param values The values of the list.
#' @return Nothing.
initialize=function(values) {
    private$values <- values

    return(invisible(NULL))
},

#' @description
#' Converts into a string.
#' @return A string containing the SQL expression.
toString=function() {

    # Quote strings
    if (is.character(private$values)) {
        fct <- function(v) paste0('"', v, '"')
        s <- vapply(private$values, fct, FUN.VALUE='')
    }

    # Collapse and convert to string
    s <- paste0('(', paste(s, collapse=', '), ')')

    return(s)
}
),

private=list(
    values=NULL
))
