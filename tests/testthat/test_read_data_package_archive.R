context("Read data package archive")

testthat::test_that("read_data_package_archive() is defunct", {
  testthat::expect_error(
    read_data_package_archive(
      packageId = "edi.1923.1",
      path = tempdir()
    ),
    class = "defunctError"
  )
  testthat::expect_error(
    read_data_package_archive(
      packageId = "edi.1923.1",
      path = tempdir()
    ),
    regexp = "'read_data_package_archive()' is defunct. Use 'download_data_package_archive()' instead.",
    fixed = TRUE
  )
})

testthat::test_that("read_data_package_archive() is defunct even with transaction", {
  testthat::expect_error(
    read_data_package_archive(
      packageId = "edi.1923.1",
      transaction = "archive_edi.1923.1_16396683904724129",
      path = tempdir()
    ),
    class = "defunctError"
  )
  testthat::expect_error(
    read_data_package_archive(
      packageId = "edi.1923.1",
      transaction = "archive_edi.1923.1_16396683904724129",
      path = tempdir()
    ),
    regexp = "'read_data_package_archive()' is defunct. Use 'download_data_package_archive()' instead.",
    fixed = TRUE
  )
})
