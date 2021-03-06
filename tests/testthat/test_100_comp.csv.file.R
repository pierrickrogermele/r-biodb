CHEBI_FILE <- system.file("extdata", "chebi_extract.tsv", package="biodb")
CHEBI_FILE_UNKNOWN_COL <- system.file("extdata",
                                      "chebi_extract_with_unknown_column.tsv",
                                      package="biodb")

test.comp.csv.file.dynamic.field.set <- function(biodb) {

    # Create connector
    conn <- biodb$getFactory()$createConn('comp.csv.file',
                                          url=CHEBI_FILE_UNKNOWN_COL)
    
    msg <- "^.*Column \"elecCharge\" does not match any biodb field\\.$"
    testthat::expect_warning(x <- conn$getEntry('1932')$getFieldsAsDataframe(),
                             msg, perl=TRUE)
    testthat::expect_false('charge' %in% colnames(x))
    conn$setField('charge', 'elecCharge')
    
    # We must first remove the entry from all caches
    conn$deleteAllEntriesFromPersistentCache()

    x <- conn$getEntry('1932')$getFieldsAsDataframe()
    testthat::expect_true('charge' %in% colnames(x))
    
    # Delete connector
    biodb$getFactory()$deleteConn(conn)
}

test_unmapped_col <- function(biodb) {

    # Create connector
    conn <- biodb$getFactory()$createConn('comp.csv.file',
                                          url=CHEBI_FILE_UNKNOWN_COL)
    
    msg <- "^.*Column \"elecCharge\" does not match any biodb field\\.$"
    testthat::expect_warning(conn$getEntryIds(), msg, perl=TRUE)
    testthat::expect_length(conn$getUnassociatedColumns(), 1)
    testthat::expect_true(length(conn$getFieldsAndColumnsAssociation()) > 0)
    msg <- paste0("^.*The following fields have been defined:.*",
                  "Unassociated columns: elecCharge\\..*$")
    testthat::expect_output(conn$print(), msg)

    # Re-create connector
    biodb$getFactory()$deleteConn(conn)
    conn <- biodb$getFactory()$createConn('comp.csv.file',
                                          url=CHEBI_FILE_UNKNOWN_COL)
    
    conn$setIgnoreUnassignedColumns(TRUE)
    conn$getEntryIds()

    # Re-create connector
    biodb$getFactory()$deleteConn(conn)
    conn <- biodb$getFactory()$createConn('comp.csv.file',
                                          url=CHEBI_FILE_UNKNOWN_COL)

    # Define missing column
    conn$setField('charge', 'elecCharge')
    testthat::expect_length(conn$getUnassociatedColumns(), 0)

    # No warning should be issued
    conn$getEntryIds()
    
    # Delete connector
    biodb$getFactory()$deleteConn(conn)
}

# Set context
biodb::testContext("CompCsvFile generic tests")

# Instantiate Biodb
biodb <- biodb::createBiodbTestInstance()

# TODO How to test this connector with both chebi and uniprot extracts?
# All entry-*.json are named after the connector name.
# Make runGenericTests() a class in which we can set the files pattern to match.
# Then listTestRefEntries() uses this pattern.

# Create connector
conn <- biodb$getFactory()$createConn('comp.csv.file', url=CHEBI_FILE)

# Run generic tests
biodb::runGenericTests(conn)

# Run specific tests
biodb::testContext("CompCsvFile specific tests")
biodb::testThat('We receive a warning for unmapped columns.',
                test_unmapped_col, biodb=biodb)
biodb::testThat('We can define a new field even after loading an entry.',
                test.comp.csv.file.dynamic.field.set, biodb=biodb)

# Terminate Biodb
biodb$terminate()
