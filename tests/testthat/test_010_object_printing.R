# vi: fdm=marker

source('common.R', local=TRUE)
biodb <- biodb::createBiodbTestInstance()

# Set context
biodb::setTestContext(biodb, "Test object printing.")

# Test BiodbCache show {{{1
################################################################

test.BiodbCache.show <- function(biodb) {
	expect_output(biodb$getCache()$show(), regexp = '^Biodb cache .* instance\\..*$')
}

# Test BiodbConfig show {{{1
################################################################

test.BiodbConfig.show <- function(biodb) {
	expect_output(biodb$getConfig()$show(), regexp = '^Biodb config.* instance\\..*Values:.*$')
}

# Test Biodb show {{{1
################################################################

test.Biodb.show <- function(biodb) {
	expect_output(biodb$show(), regexp = '^Biodb instance, version [0-9]*\\.[0-9]*\\.[0-9]*\\..*$')
}

# Test BiodbFactory show {{{1
################################################################

test.BiodbFactory.show <- function(biodb) {
	expect_output(biodb$getFactory()$show(), regexp = '^Biodb factory instance\\.$')
}

# Test BiodbEntry show {{{1
################################################################

test.BiodbEntry.show <- function(biodb) {

	# Create database and connector
	id <- 'C1'
	db.df <- rbind(data.frame(), list(accession = id, ms.mode = 'POS', peak.mztheo = 112.07569, peak.comp = 'P9Z6W410 O', peak.attr = '[(M+H)-(H2O)-(NH3)]+', formula = "J114L6M62O2", molecular.mass = 146.10553, name = 'Blablaine'), stringsAsFactors = FALSE)
	conn <- biodb$getFactory()$createConn('mass.csv.file')
	conn$setDb(db.df)

	# Get entry
	entry <- conn$getEntry(id)
	testthat::expect_output(entry$show(), regexp = '^Biodb .* entry instance .*\\.$')

	# Destroy connector
	biodb$getFactory()$deleteConn(conn$getId())
}

# Test BiodbConn show {{{1
################################################################

test.BiodbConn.show <- function(biodb) {

	# Get connection
	conn <- biodb$getFactory()$getConn('chebi')

	# Test printing
	expect_output(conn$show(), regexp = '^Biodb .* connector instance, using URL .*\\.$')
}

# Test BiodbDbsInfo show {{{1
################################################################

test.BiodbDbsInfo.show <- function(biodb) {
	expect_output(biodb$getDbsInfo()$show(), regexp = '^Biodb databases information instance\\.\nThe following databases are defined:.*$')
}

# Test BiodbEntryFields show {{{1
################################################################

test.BiodbEntryFields.show <- function(biodb) {
	expect_output(biodb$getEntryFields()$show(), regexp = '^Biodb entry fields information instance\\.$')
}

# Main {{{1
################################################################

biodb::testThat("Biodb show method returns correct information.", test.Biodb.show, biodb = biodb)
biodb::testThat("BiodbCache show method returns correct information.", test.BiodbCache.show, biodb = biodb)
biodb::testThat("BiodbConfig show method returns correct information.", test.BiodbConfig.show, biodb = biodb)
biodb::testThat("BiodbFactory show method returns correct information.", test.BiodbFactory.show, biodb = biodb)
biodb::testThat("BiodbEntry show method returns correct information.", test.BiodbEntry.show, biodb = biodb)
biodb::testThat("BiodbConn show method returns correct information.", test.BiodbConn.show, biodb = biodb)
biodb::testThat("BiodbDbsInfo show method returns correct information.", test.BiodbDbsInfo.show, biodb = biodb)
biodb::testThat("BiodbEntryFields show method returns correct information.", test.BiodbEntryFields.show, biodb = biodb)

# Terminate Biodb
biodb$terminate()