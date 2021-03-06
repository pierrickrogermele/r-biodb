#' Extension C++ code class
#'
#' @description
#' A class for generating C++ example files (code & test).
#'
#' @details
#' This class generates examples of an R function written in C++ using Rcpp, of
#' a pure C++ function used to speed up computing, and of C++ code for testing
#' the pure C++ function.
#' As for the R function written with Rcpp, it is tested inside standard
#' testthat R code. 
#'
#' @examples
#' # Generate C++ files
#' pkgFolder <- file.path(tempfile(), 'biodbFoo')
#' dir.create(pkgFolder, recursive=TRUE)
#' biodb::ExtCpp$new(path=pkgFolder)$generate()
#'
#' @import R6
#' @include ExtGenerator.R
#' @export
ExtCpp <- R6::R6Class('ExtCpp',

inherit=ExtGenerator,

public=list(

#' @description
#' Initializer.
#' @param ... See the constructor of ExtGenerator for the parameters.
#' @return Nothing.
initialize=function(...) {
    super$initialize(...)
    chk::chk_dir(private$path)

    return(invisible(NULL))
}
),

private=list(
doGenerate=function(overwrite=FALSE, fail=TRUE) {
    
    # Copy all C++ files
    templates <- system.file('templates', package='biodb')
    for (f in Sys.glob(paste0(templates, '/*.cpp')))
        private$createGenerator(ExtFileGenerator, template=basename(f),
                                folder='src', filename=basename(f)
                                )$generate(overwrite=overwrite, fail=fail)
    
    # Add R file that declares run_testthat_tests()
    private$createGenerator(ExtFileGenerator,
                            template='catch-routine-registration.R',
                            folder='R', filename='catch-routine-registration.R'
                            )$generate(overwrite=overwrite, fail=fail)
    
    # Add R file that runs C++ tests from testthat
    testthatFolder <- c('tests', 'testthat')
    private$createGenerator(ExtFileGenerator, template='test-cpp.R',
                            folder=testthatFolder,
                            filename='test-cpp.R'
                            )$generate(overwrite=overwrite, fail=fail)
}
))
