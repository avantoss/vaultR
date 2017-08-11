context("vault.read")

test_that("it can read a simple key", {
  with_mock(vault.auth = function(...) { TRUE },
            system2 = function(cmd, args, ...) {
              if (identical(args[1], "read") && identical(args[3], "potato")) '{"data":{"value":"tasty"}}'
              else stop("unexpected arg")
            }, {
    expect_equal(vault.read("potato"), "tasty")
    expect_error(vault.read("apple"), "unexpected arg")
  })
})

test_that("it errors if you pass a mode that is not 'text'", {
  expect_error(vault.read("potato", NULL))

})

test_that("it errors if you pass a key that is not a string", {
  expect_error(vault.read(NULL))
  expect_error(vault.read(5))
  expect_error(vault.read(new.env()))
  expect_error(vault.read(identity))
  expect_error(vault.read(TRUE))
})

test_that("if JSON is invalid, it errors", {
  with_mock(vault.auth = function(...) { TRUE },
            system2 = function(cmd, args, ...) {
              if (identical(args[1], "read") && identical(args[3], "potato")) '[{"data":{"value":"tasty"}}'
            }, {
    expect_error(vault.read("potato"), "parse error: premature EOF")
  })
})
