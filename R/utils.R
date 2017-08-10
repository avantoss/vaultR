ensure_environment_variables_are_set <- function() {
  Sys.getenv("VAULT_CACERT") %||% getOption("vault.cacert")
  Sys.getenv("VAULT_ADDR") %||% getOption("vault.addr")
}

verify_authentication <- function()
  if (isTRUE(.vault_env$connected) || !grepl("connection refused", system2("vault", "status", stdout = TRUE))) {
    return(TRUE)
}

`%||%` <- function(x, y) if (is.null(x)) y else x
