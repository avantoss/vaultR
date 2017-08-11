.vault_env <- new.env()


#' @export
vault.read <- function(key, mode = "text") {
  stopifnot(identical(mode, "text"), isSingleString(key))
  vault.auth()
  secret_output <- system2("vault", c("read", "-format=json", key), stdout = TRUE)
  value <- jsonlite::fromJSON(secret_output)$data$value
  value

}

#' @export
vault.write <- function(object, key, mode = "text"){
  stopifnot(identical(mode, "text"), isSingleString(object), isSingleString(key))
  vault.auth()
  input <-  gsub('"', '\\"', object, fixed = TRUE)
  status <- system2("vault", c("write", key, paste0('value="', object, '"')))
  !as.logical(status)
}

#' @export
vault.auth <- function(username) {
  ensure_environment_variables_are_set()
  if (already_authenticated()) return ()
  if (missing(username)) { username <- readline(prompt = "Username:") }
  success <- system2("vault", c("auth", "-method=ldap", paste0("username=", username)))
  success <- !as.logical(status)
  if (success) {
    mark_as_already_authenticated()
    TRUE
  } else {
    FALSE
  }
}
