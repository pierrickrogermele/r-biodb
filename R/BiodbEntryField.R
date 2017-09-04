# vi: fdm=marker

# Constants {{{1
################################################################

# Cardinalities
BIODB.CARD.ONE <- '1'
BIODB.CARD.MANY <- '*'
FIELD.CARDINALITIES <- c(BIODB.CARD.ONE, BIODB.CARD.MANY)

FIELD.CLASSES <- c('character', 'integer', 'double', 'logical', 'object', 'data.frame')

# Class declaration {{{1
################################################################

#' A class for describing an entry field.
#'
#' This class is used by \code{\link{BiodbEntryFields}} for storing field characteristics, and returning them through the \code{get()} method. The constructor is not meant to be used, but for development purposes the constructor's parameters are nevertheless described in the Fields section.
#'
#' @field db.id             Set to \code{TRUE} if the field is a database ID.
#' @field name              The name of the field.
#' @field alias             A character vector containing zero or more aliases for the field.
#' @field class             The class of the field. One of: 'character', 'integer', 'double', 'logical', 'object', 'data.frame'.
#' @field card              The cardinality of the field: either '1' or '*'.
#' @field allow.duplicates  If set to \code{TRUE}, the field allows duplicated values.
#' @field description       The description of the field.
#'
#' @seealso \code{\link{BiodbEntryFields}}.
#'
#' @examples
#' # Get the class of the InChI field.
#' mybiodb <- biodb::Biodb()
#' inchi.field.class <- mybiodb$getEntryFields()$get('inchi')$getClass()
#'
#' # Test the cardinality of a field
#' card.one <- mybiodb$getEntryFields()$get('name')$hasCardOne()
#' card.many <- mybiodb$getEntryFields()$get('name')$hasCardMany()
#'
#' # Get the description of a field
#' desc <- mybiodb$getEntryFields()$get('inchi')$getDescription()
#'
#' @import methods
#' @include biodb-common.R
#' @include ChildObject.R
#' @export BiodbEntryField
#' @exportClass BiodbEntryField
BiodbEntryField <- methods::setRefClass("BiodbEntryField", contains = "ChildObject", fields = list( .name = 'character', .class = 'character', .cardinality = 'character', .allow.duplicates = 'logical', .db.id = 'logical', .description = 'character', .alias = 'character'))

# Constructor {{{1
################################################################

BiodbEntryField$methods( initialize = function(name, alias = NA_character_, class = 'character', card = BIODB.CARD.ONE, allow.duplicates = FALSE, db.id = FALSE, description = NA_character_, ...) {

	callSuper(...)

	# Set name
	if ( is.null(name) || is.na(name) || nchar(name) == '')
		.self$message('error', "You cannot set an empty name for a field. Name was empty (either NULL or NA or empty string).")
	.name <<- tolower(name)

	# Set class
	if ( ! class %in% FIELD.CLASSES)
		.self$message('error', paste("Unknown class \"", class, "\" for field \"", name, "\".", sep = ''))
	.class <<- class

	# Set cardinality
	if ( ! card %in% FIELD.CARDINALITIES)
		.self$message('error', paste("Unknown cardinality \"", card, "\" for field \"", name, "\".", sep = ''))
	.cardinality <<- card

	# Set description
	if (is.null(description) || is.na(description))
		.self$message('caution', paste("Missing description for entry field \"", name, "\".", sep = ''))
	.description <<- description

	# Set alias
	if (length(alias) > 1 && any(is.na(alias)))
		.self$message('error', paste("One of the aliases of entry field \"", name, "\" is NA.", sep = ''))
	.alias <<- alias

	# Set other fields
	.allow.duplicates <<- allow.duplicates
	.db.id <<- db.id
})

# Get name {{{1
################################################################

BiodbEntryField$methods( getName = function() {
	":\n\n Get field's name."

	return(.self$.name)
})

# Get description {{{1
################################################################

BiodbEntryField$methods( getDescription = function() {
	":\n\n Get field's description."

	return(.self$.description)
})

# Has aliases {{{1
################################################################

BiodbEntryField$methods( hasAliases = function() {
	":\n\n Returns TRUE if this entry field defines aliases."

	return( ! any(is.na(.self$.alias)))
})

# Get aliases {{{1
################################################################

BiodbEntryField$methods( getAliases = function() {
	":\n\n Returns the list of aliases if some are defined, otherwise returns NULL."

	aliases <- NULL

	if (.self$hasAliases())
		aliases <- .self$.alias
	
	return(aliases)
})

# Has card one {{{1
################################################################

BiodbEntryField$methods( hasCardOne = function() {
	":\n\n Returns \\code{TRUE} if the cardinality of this field is one."

	return(.self$.cardinality == BIODB.CARD.MANY)
})

# Has card many {{{1
################################################################

BiodbEntryField$methods( hasCardMany = function() {
	":\n\n Returns \\code{TRUE} if the cardinality of this field is many."

	return(.self$.cardinality == BIODB.CARD.MANY)
})

# Allows duplicates {{{1
################################################################

BiodbEntryField$methods( allowsDuplicates = function() {
	":\n\n Returns \\code{TRUE} if this field allows duplicated values."

	return(.self$.allow.duplicates)
})

# Get class {{{1
################################################################

BiodbEntryField$methods( getClass = function() {
	":\n\n Returns the type (i.e.: class) of this field."

	return(.self$.class)
})

# Is object {{{1
################################################################

BiodbEntryField$methods( isObject = function() {
	":\n\n Returns \\code{TRUE} if field's type is a class."

	return(.self$.class == 'object')
})

# Is data frame {{{1
################################################################

BiodbEntryField$methods( isDataFrame = function() {
	":\n\n Returns \\code{TRUE} if field's type is data frame."

	return(.self$.class == 'data.frame')
})

# Is vector {{{1
################################################################

BiodbEntryField$methods( isVector = function() {
	":\n\nReturns \\code{TRUE} if the field's type is vector (i.e.: character, integer, double or logical)."
	return(.self$.class %in% c('character', 'integer', 'double', 'logical'))
})

# DEPRECATED METHODS {{{1
################################################################

# Get cardinality {{{2
################################################################

BiodbEntryField$methods( getCardinality = function() {
	.self$.deprecated.method('hasCardOne() or hasCardMany()')
	return(.self$.cardinality)
})