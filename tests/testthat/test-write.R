context("vault.write")

test_that("it can write a simple key", {
  env <- new.env()
  with_mock(vault.auth = function(...) { TRUE },
            system2 = function(cmd, args, ...) {
              if (identical(args[1], "write")) { env[[args[2]]] <- args[[3]] }
              else if (identical(args[1], "read")) { paste0('{"data":{"value":"', env$foo, '"}}') }
              else stop("unexpected arg")
            }, {
    vault.write("tasty", "potato")
    expect_equal(env$potato, 'value="tasty"')
    expect_equal(vault.read("potato"), "")
  })
})

test_that("it errors if you pass a mode that is not 'text'", {
  expect_error(vault.write("tasty", "potato", NULL))

})

test_that("it errors if you pass an object or a key that is not a string", {
  expect_error(vault.write(NULL, "potato"))
  expect_error(vault.write("tasty", NULL))

})

test_that("function return TRUE when write was successful", {
  with_mock(vault.auth = function(...) { TRUE },
            system2 = function(...) { 0 },
   {
    expect_equal(vault.write("tasty", "potato"), TRUE)
  })
})
