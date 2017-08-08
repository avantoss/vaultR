#' @export
pending <- function(a) {
  a + 1
}

#' @export
vault.read <- function(key, mode = "text") {
  system2("vault", c("read", key))
}

