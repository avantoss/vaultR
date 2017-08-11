context("vault.auth")

test_that("it can authenticate in a simple example", {
  with_mock(ensure_environment_variables_are_set = function(...) { },
            already_authenticated = function(...) { FALSE },
            system2 = function(cmd, args, ...) {
              if (identical(args[1], "auth")) 0
              else stop("unexpected arg")
            },
            readline = function(...) { "user" },
            mark_as_already_authenticated = function(...) { TRUE }, {
    expect_true(vault.auth())
  })
})
