#' @export
pending <- function(a) {
  a + 1
}

#' @export
vault.read <- function(key, mode = "text") {
  secret_output <- system2("vault", c("read", "-format=json", key), stdout = TRUE)
  value <- jsonlite::fromJSON(secret_output)$data$value
  value

}

#' @export
vault.write <- function(object, key, mode = "text"){


}
