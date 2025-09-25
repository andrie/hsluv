complementary_hue <- function(h) {
  (h + 180) %% 360
}

hex_to_complementary <- function(hex) {
  hsluv <- hex_to_hsluv(hex)
  hsluv_to_hex(c(
    complementary_hue(hsluv[1]),
    hsluv[2],
    hsluv[3]
  ))
}

complementary_hex <- function(hex) {
  hsluv <- hex_to_hsluv(hex)
  h <- hsluv[1]
  s <- hsluv[2]
  l <- hsluv[3]
  hsluv_to_hex(c(complementary_hue(h), s, l))
}

hex_to_shades <- function(hex, n = 10, vary = c("l", "s")) {
  vary <- match.arg(vary)
  hsluv <- hex_to_hsluv(hex)
  h <- hsluv[1]
  s <- hsluv[2]
  l <- hsluv[3]
  if (vary == "s") {
    vapply(
      seq(0, 100, length.out = n),
      function(s) hsluv_to_hex(c(h, s, l)),
      character(1)
    )
  } else {
    vapply(
      seq(0, 100, length.out = n),
      function(l) hsluv_to_hex(c(h, s, l)),
      character(1)
    )
  }
}
