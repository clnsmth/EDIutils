#' Run code with write_disk support under vcr replay
#'
#' vcr does not invoke httr's write_disk callback when replaying cassettes.
#' This helper wraps api_get during tests to ensure replayed response content
#' is written to the requested disk path.
#'
#' @param code Code block to execute with mocked api_get
#' @noRd
with_mock_write_disk <- function(code) {
  orig_api_get <- EDIutils:::api_get
  mock_api_get <- function(url, ...) {
    resp <- orig_api_get(url, ...)
    args <- list(...)
    for (arg in args) {
      if (inherits(arg, "request") && !is.null(arg$output$path)) {
        if (is.raw(resp$content) && length(resp$content) > 0) {
          writeBin(resp$content, arg$output$path)
        }
        break
      }
    }
    return(resp)
  }
  testthat::with_mocked_bindings(
    api_get = mock_api_get,
    .package = "EDIutils",
    code = code
  )
}
