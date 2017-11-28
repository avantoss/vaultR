ensure_environment_variables_are_set <- function() {
  if (is.null(Sys.getenv("VAULT_CACERT") %|||% getOption("vault.cacert"))) {
    stop("Please set VAULT_CACERT env var or vault.cacert global option.")
  }
  if (is.null(Sys.getenv("VAULT_ADDR") %|||% getOption("vault.addr"))) {
    stop("Please set VAULT_ADDR env var or vault.addr global option.")
  }
}

already_authenticated <- function() {
  isTRUE(.vault_env$connected) || !grepl("connection refused", system2("vault", "status", stdout = TRUE))
}

mark_as_already_authenticated <- function() {
  .vault_env$connected <- TRUE
}

isSingleString <- function(input) {
    is.character(input) & length(input) == 1
}

`%||%` <- function(x, y) if (is.null(x)) y else x
`%|||%` <- function(x, y) if (is.null(x) || !nzchar(x)) y else x
