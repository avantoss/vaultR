.vault_env <- new.env()


#' @export
vault.read <- function(key, mode = "text") {
  vault.auth()
  browser()
  secret_output <- system2("vault", c("read", "-format=json", key), stdout = TRUE)
  value <- jsonlite::fromJSON(secret_output)$data$value
  value

}

#' @export
vault.write <- function(object, key, mode = "text"){
  vault.auth()

}

#' @export
vault.auth <- function(username) {
  ensure_environment_variables_are_set()
  if(verify_authentication() %>% isTRUE(.)) return ()
  if (missing(username)) { username <- readline(prompt = "Username:") }
  system2("vault", c("auth", "-method=ldap", paste0("username=", username)))
  .vault_env$connected <- TRUE
}
