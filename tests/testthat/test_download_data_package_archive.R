context("Download data package archive")

testthat::test_that("download_data_package_archive() downloads and returns valid zip", {
  testthat::skip_on_cran()
  pkg <- get_test_package()
  dest <- file.path(tempdir(), paste0(pkg, ".zip"))
  on.exit({
    if (file.exists(dest)) {
      file.remove(dest)
    }
  }, add = TRUE)

  with_mock_write_disk({
    vcr::use_cassette("download_data_package_archive", {
      res <- download_data_package_archive(
        packageId = pkg,
        path = tempdir(),
        env = "staging"
      )
    })
  })

  expect_equal(res, dest)
  expect_true(file.exists(res))
  expect_true(file.info(res)$size > 0)

  # Check that the archive is a valid zip containing files
  files_in_zip <- utils::unzip(res, list = TRUE)
  expect_true(nrow(files_in_zip) > 0)
  expect_true(any(grepl("\\.xml$", files_in_zip$Name)))
})

testthat::test_that("download_data_package_archive() prevents overwrite by default", {
  testthat::skip_on_cran()
  pkg <- get_test_package()
  dest <- file.path(tempdir(), paste0(pkg, ".zip"))
  on.exit({
    if (file.exists(dest)) {
      file.remove(dest)
    }
  }, add = TRUE)

  # Create a dummy file at destination
  writeLines("dummy content", dest)
  expect_true(file.exists(dest))

  expect_error(
    download_data_package_archive(
      packageId = pkg,
      path = tempdir(),
      overwrite = FALSE,
      env = "staging"
    ),
    regexp = "already exists. Set 'overwrite = TRUE' to replace it."
  )
})

testthat::test_that("download_data_package_archive() overwrites existing file when overwrite = TRUE", {
  testthat::skip_on_cran()
  pkg <- get_test_package()
  dest <- file.path(tempdir(), paste0(pkg, ".zip"))
  on.exit({
    if (file.exists(dest)) {
      file.remove(dest)
    }
  }, add = TRUE)

  # Create a dummy file at destination
  writeLines("dummy content", dest)
  dummy_size <- file.info(dest)$size

  with_mock_write_disk({
    vcr::use_cassette("download_data_package_archive", {
      res <- download_data_package_archive(
        packageId = pkg,
        path = tempdir(),
        overwrite = TRUE,
        env = "staging"
      )
    })
  })

  expect_equal(res, dest)
  expect_true(file.exists(res))
  expect_true(file.info(res)$size > dummy_size)

  files_in_zip <- utils::unzip(res, list = TRUE)
  expect_true(nrow(files_in_zip) > 0)
})

testthat::test_that("download_data_package_archive() validates directory path", {
  testthat::skip_on_cran()
  pkg <- get_test_package()
  non_existent_dir <- file.path(tempdir(), "non_existent_dir_ediutils_test")

  expect_error(
    download_data_package_archive(
      packageId = pkg,
      path = non_existent_dir,
      env = "staging"
    ),
    regexp = "Directory '.*' does not exist."
  )
})
