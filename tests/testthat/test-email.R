test_that("E-Mail info check works", {

  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()

  x <- get_email_info("john@doe.com")

  expect_equal(class(x), "list")
  expect_equal(x$email, "john@doe.com")
})
