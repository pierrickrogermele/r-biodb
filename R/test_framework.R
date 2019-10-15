# vi: fdm=marker ts=4 et cc=80 tw=80

# BiodbTestMsgAck observer class {{{1
################################################################################

#' A class for acknowledging messages during tests.
#'
#' This observer is used to call a testthat::expect_*() method each time a
#' message is received. This is used when running tests on Travis-CI, so Travis
#' does not stop tests because no change is detected in output.
#'
#' @import methods
#' @include BiodbObserver.R
#' @export BiodbTestMsgAck
#' @exportClass BiodbTestMsgAck
BiodbTestMsgAck <- methods::setRefClass('BiodbTestMsgAck',
    contains = 'BiodbObserver',
    fields = list(
        .last.index = 'numeric'
        ),

    methods=list(

# Initialize {{{2
################################################################

initialize=function(...) {

    callSuper(...)

    .last.index <<- 0
},

# Msg {{{2
################################################################

msg=function(type='info', msg, class=NA_character_, method=NA_character_,
             lvl=1) {
    # Overrides super class' method.

    testthat::expect_is(msg, 'character')

    invisible(NULL)
},

# Progress {{{2
################################################################

progress=function(type='info', msg, index, first, total=NA_character_,
                    lvl=1L, laptime=10L) {
    # Overrides super class' method.

    .self$checkMessageType(type)
    testthat::expect_is(msg, 'character')
    testthat::expect_length(msg, 1)
    testthat::expect_true(msg != '')

    if (first)
        .self$.last.index[msg] <- index - 1

    testthat::expect_true(msg %in% names(.self$.last.index))
    testthat::expect_true(index > .self$.last.index[[msg]],
                        paste0("Index ", index, " is not greater than last ",
                               "index ", .self$.last.index[msg], ' for progress ',
                               'message "', msg, '", with total ', total, '.'))
    if ( ! is.na(total))
        testthat::expect_true(index <= total,
                             paste0("Index ", index, ' is greater than total ',
                                    total, ' for progress message "', msg,
                                    '".'))

    .self$.last.index[msg] <- index

    invisible(NULL)
}

))


# BiodbTestMsgRec observer class {{{1
################################################################################

#' A class for recording messages during tests.
#'
#' The main purpose of this class is to give access to last sent messages of the
#' different types: "error", "warning", "caution", "info" and "debug".
#'
#' @import methods
#' @include BiodbObserver.R
#' @export BiodbTestMsgRec
#' @exportClass BiodbTestMsgRec
BiodbTestMsgRec <- methods::setRefClass("BiodbTestMsgRec",
    contains = "BiodbObserver",
    fields = list(
                  .msgs='character',
                  .msgs.by.type='list'
                  ),
    methods=list(

# Initialize {{{2
################################################################################

initialize=function(...) {
    .msgs <<- character()
    .msgs.by.type <<- list()
},

# Msg {{{2
################################################################################

msg=function(type='info', msg, class=NA_character_, method=NA_character_,
             lvl=1) {
    # Overrides super class' method.

    .msgs <<- c(.self$.msgs, msg)
    .self$.msgs.by.type[[type]] <- c(.self$.msgs.by.type[[type]], msg)

    invisible(NULL)
},

# hasMsgs {{{2
################################################################################

hasMsgs=function(type=NULL) {
    ":\n\nChecks if at least one message has been received.
    \ntype: A vector of message types on which to restrict the test.
    \nReturned value: TRUE if at least one message has been received, FALSE
    otherwise.
    "

    f <- FALSE

    if (is.null(type))
        f = (length(.self$.msg) > 0)
    else if (any(type %in% names(.self$.msgs.by.type))) {
        for (t in type)
            if (t %in% names(.self$.msgs.by.type)
                && length(.self$.msgs.by.type[[type]]) > 0) {
                f <- TRUE
                break
            }
    }

    return(f)
},

# getLastMsg {{{2
################################################################################

getLastMsg = function() {
    ":\n\nGet the last message received.
    \nReturned value: The last message received as a character value.
    "

    m <- NA_character_

    i <- length(.self$.msgs)
    if (i > 0)
        m <- .self$.msgs[[i]]

    return(m)
},

# getLastMsgByType {{{2
################################################################################

getLastMsgByType = function(type) {
    ":\n\nGet the last message of a certain type.
    \ntype: The type of the message.
    \nReturned value: The last message.
    "

    m <- NULL

    if (type %in% names(.self$.msgs.by.type)) {
        m <- .self$.msgs.by.type[[type]]
        m <- m[[length(m)]]
    }

    return(m)
},

# getMsgsByType {{{2
################################################################################

getMsgsByType = function(type) {
    ":\n\nGet all messages of a certain type.
    \ntype: The type of the messages to retrieve.
    \nReturned value: A character vector containing all messages received for
    this type.
    "

    msgs <- character()

    if ( ! is.null(type) && type %in% names(.self$.msgs.by.type))
        msgs <- .self$.msgs.by.type[[type]]

    return(msgs)
},

# clearMessages {{{2
################################################################################

clearMessages = function() {
    ":\n\nErase all lists of messages.
    \nReturned value: None.
    "

    .msgs <<- character()
    .msgs.by.type <<- list()

    invisible(NULL)
}

))

# Set test context {{{1
################################################################################

#' Set a test context.
#'
#' Define a context for tests using testthat framework.
#' In addition to calling `testthat::context()`, the function will call
#' `biodb::Biodb::info()` to signal the context to observers. This will allow
#' to print the test context also into the test log file, if logger is used
#' for tests.
#'
#' @param biodb A valid Biodb instance.
#' @param text The text to print as test context.
#' @return No value returned.
#'
#' @examples
#' # Define a context before running tests:
#' \dontrun{
#' setTestContext(biodb, "Test my database connector.")
#' }
#'
#' @export
setTestContext <- function(biodb, text) {

    # Set testthat context
    testthat::context(text)

    # Print banner in log file
    biodb$info("")
    biodb$info(paste(rep('*', 80), collapse=''))
    biodb$info(paste("Test context", text, sep = " - "))
    biodb$info(paste(rep('*', 80), collapse=''))
    biodb$info("")
    
    invisible(NULL)
}

# Test that {{{1
################################################################

#' Run a test.
#'
#' Run a test function, using testthat framework.
#' In addition to calling `testthat::test_that()`, the function will call
#' `biodb::Biodb::info()` to signal the test function call to observers.
#' This will allow to print the call to the test function also into the test log
#' file, if logger is used for tests.
#'
#' @param msg The test message.
#' @param fct The function to test.
#' @param biodb A valid Biodb instance to be passed to the test function.
#' @param obs An instance of BiodbTestMsgRec observer to be passed to test function.
#' @param conn A connector instance to be passed to the test function.
#' @return No value returned.
#'
#' @examples
#' #
#' \dontrun{
#' biodb::testThat("My test works", my_test_function, biodb=mybiodb)
#' }
#'
#' @export
testThat  <- function(msg, fct, biodb=NULL, obs=NULL, conn=NULL) {

    # Get biodb instance
    if ( ! is.null(biodb) && ! methods::is(biodb, 'Biodb'))
        stop("`biodb` parameter must be a rightful biodb::Biodb instance.")
    if ( ! is.null(conn) && ! methods::is(conn, 'BiodbConn'))
        stop("`conn` parameter must be a rightful biodb::BiodbConn instance.")
    bdb <- if (is.null(conn)) biodb else conn$getBiodb()
    if (is.null(bdb))
        stop("You must at least set one of `biodb` or `conn` parameter when",
             " calling testThat().")

    # Get function name
    if (methods::is(fct, 'function'))
        fname <- deparse(substitute(fct))
    else
        fname <- fct

    # Get list of test functions to run
    if (bdb$getConfig()$isDefined('test.functions')) {
        functions <- strsplit(bdb$getConfig()$get('test.functions'), ',')[[1]]
        runFct <- fname %in% functions
    }
    else
        runFct <- TRUE

    if (runFct) {

        # Send message to logger
        bdb$info('')
        bdb$info(paste('Running test function ', fname, ' ("', msg, '").'))
        bdb$info(paste(rep('-', 80), collapse=''))
        bdb$info('')

        # Call test function
        if ( ! is.null(biodb) && ! is.null(obs))
            testthat::test_that(msg, do.call(fct, list(biodb = biodb, obs = obs)))
        else if ( ! is.null(biodb))
            testthat::test_that(msg, do.call(fct, list(biodb)))
        else if ( ! is.null(conn) && ! is.null(obs))
            testthat::test_that(msg, do.call(fct, list(conn = conn, obs = obs)))
        else if ( ! is.null(conn))
            testthat::test_that(msg, do.call(fct, list(conn)))
        else
            stop(paste0('Do not know how to call test function "', fname, '".'))
    }

    invisible(NULL)
}

# Create Biodb test instance {{{1
################################################################

#' Creating a Biodb instance for tests.
#'
#' Creates a Biodb instance with options specially adapted for tests.
#' You can request the logging of all messages into a log file.
#' It is also possible to ask for the creation of a BiodbTestMsgAck observer,
#' which will receive all messages and emit a testthat test for each message.
#' This will allow the testthat output to not stall a long time while, for
#' example, downloading or extracting a database.
#' Do not forget to call `terminate()` on your instance at the end of your
#' tests.
#'
#' @param log The name of the log file to create. If set to NULL, no log file
#' will be created.
#' @param ack If set to TRUE, an instance of BiodbTestMsgAck will be attached to
#' the Biodb instance.
#' @return The created Biodb instance.
#'
#' @examples
#' # Instantiate a Biodb instance for testing
#' biodb <- biodb::createBiodbTestInstance(log="mylogfile.log")
#'
#' # Terminate the instance
#' biodb$terminate()
#'
#' @export
createBiodbTestInstance <- function(log=NULL, ack=FALSE) {

    # Create instance
    biodb <- Biodb$new()

    # Add logger
    if ( ! is.null(log) && is.character(log) && length(log) == 1
        && nchar(log) > 0) {
        logger <- BiodbLogger(file=log)
        logger$setLevel('caution', 2L)
        logger$setLevel('debug', 2L)
        logger$setLevel('info', 2L)
        logger$setLevel('error', 2L)
        logger$setLevel('warning', 2L)
        biodb$addObservers(logger)
    }

    # Add acknowledger
    if (ack) {
        ack <- BiodbTestMsgAck()
        biodb$addObservers(ack)
    }

    return(biodb)
}

# Add message recorder observer {{{1
################################################################################

#' Add a message recorder to a Biodb instance.
#'
#' Creates a BiodbTestMsgRec observer instance and add it to a Biodb instance.
#' Sometimes it is required to test if a message has been emitted.
#' This function adds a BiodbTestMsgRec observer to a Biodb instance. This class
#' is target adapted to message testing, since you are then able to retrieve, for
#' example, the last message emitted.
#'
#' @param biodb A valid Biodb instance.
#' @return The created BiodbTestMsgRec observer instance.
#'
#' @examples
#' # Instantiate a Biodb instance for testing
#' biodb <- biodb::createBiodbTestInstance(log="mylogfile.log")
#'
#' # Get a message recorder observer
#' obs <- biodb::addMsgRecObs(biodb)
#'
#' # Create a connector
#' conn <- biodb$getFactory()$createConn('mass.csv.file')
#'
#' # Delete the connector
#' biodb$getFactory()$deleteConn(conn)
#'
#' # Get last message
#' obs$getLastMsg()
#'
#' # Terminate the instance
#' biodb$terminate()
#'
#' @export
addMsgRecObs <- function(biodb) {

    # Create observer
    obs <- BiodbTestMsgRec()

    # Set observer
    biodb$addObservers(obs)

    return(obs)
}

# List reference entries {{{1
################################################################

listTestRefEntries <- function(db) {

	# List json files
	files <- Sys.glob(file.path(getwd(), 'res', paste('entry', db, '*.json', sep = '-')))
	if (length(files) == 0)
		stop(paste0("No JSON reference files for database ", db, "."))

	# Extract ids
	ids <- sub(paste('^.*/entry', db, '(.+)\\.json$', sep = '-'), '\\1', files, perl = TRUE)

	# Replace encoded special characters
	ids = gsub('%3a', ':', ids)

	return(ids)
}

# Load ref entry {{{1
################################################################

loadTestRefEntry <- function(db, id) {

	# Replace forbidden characters
	id = gsub(':', '%3a', id)

	# Entry file
	file <- file.path(getwd(), 'res', paste('entry-', db, '-', id, '.json', sep = ''))
	expect_true(file.exists(file), info = paste0('Cannot find file "', file, '" for ', db, ' reference entry', id, '.'))

	# Load JSON
	json <- jsonlite::fromJSON(file)

	# Set NA values
	for (n in names(json))
		if (length(json[[n]]) == 1) {
			if (json[[n]] == 'NA_character_')
				json[[n]] <- NA_character_
		}

	return(json)
}

# Load reference entries {{{1
################################################################

loadTestRefEntries <- function(db) {

	entries.desc <- NULL

	# List JSON files
	entry.json.files <- Sys.glob(file.path(getwd(), 'res', paste('entry', db, '*.json', sep = '-')))

	# Loop on all JSON files
	for (f in entry.json.files) {

		# Load entry from JSON
		entry <- jsonlite::read_json(f)

		# Replace NULL values by NA
		entry <- lapply(entry, function(x) if (is.null(x)) NA else x)

		# Convert to data frame
		entry.df <- as.data.frame(entry, stringsAsFactors = FALSE)

		# Append entry to main data frame
		entries.desc <- plyr::rbind.fill(entries.desc, entry.df)
	}

	return(entries.desc)
}

# Get test output directory {{{1
################################################################################

#' Get the test output directory.
#'
#' Returns the path to the test output directory.
#'
#' @return The path to the test output directory, as a character value.
#'
#' @examples
#' # Get the test output directory:
#' biodb::getTestOutputDir()
#'
#' @export
getTestOutputDir <- function() {
    return(file.path(getwd(), 'output'))
}