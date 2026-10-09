context("Create data package archive")

testthat::test_that("create_data_package_archive() is defunct", {
  testthat::expect_error(
    create_data_package_archive("edi.1923.1"),
    class = "defunctError"
  )
  testthat::expect_error(
    create_data_package_archive("edi.1923.1"),
    regexp = "'create_data_package_archive()' is defunct. Use 'download_data_package_archive()' instead.",
    fixed = TRUE
  )
})
