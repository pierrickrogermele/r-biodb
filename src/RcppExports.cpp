// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// closeMatchPpm
Rcpp::List closeMatchPpm(Rcpp::NumericVector x, Rcpp::NumericVector y, Rcpp::IntegerVector xidx, Rcpp::IntegerVector yidx, int xolength, double dppm, double dmz);
RcppExport SEXP _biodb_closeMatchPpm(SEXP xSEXP, SEXP ySEXP, SEXP xidxSEXP, SEXP yidxSEXP, SEXP xolengthSEXP, SEXP dppmSEXP, SEXP dmzSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type y(ySEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type xidx(xidxSEXP);
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type yidx(yidxSEXP);
    Rcpp::traits::input_parameter< int >::type xolength(xolengthSEXP);
    Rcpp::traits::input_parameter< double >::type dppm(dppmSEXP);
    Rcpp::traits::input_parameter< double >::type dmz(dmzSEXP);
    rcpp_result_gen = Rcpp::wrap(closeMatchPpm(x, y, xidx, yidx, xolength, dppm, dmz));
    return rcpp_result_gen;
END_RCPP
}

RcppExport SEXP run_testthat_tests(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_biodb_closeMatchPpm", (DL_FUNC) &_biodb_closeMatchPpm, 7},
    {"run_testthat_tests", (DL_FUNC) &run_testthat_tests, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_biodb(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
