#' Convert hex to HSLuv
#'
#' @param hex Hex color string
#' @export
#' @return Numeric vector of length 3 with HSLuv values (Hue (0-360), Saturation (0-100) and Lightness (0-100))
hex_to_hsluv <- function(hex) {
  hex |> cpp_hex_to_rgb() |> cpp_rgb_to_hsluv()
}


#' Convert hex to HSLuv
#'
#' @param hsl Numeric vector of length 3 with HSLuv values (Hue (0-360), Saturation (0-100) and Lightness (0-100))
#' @return Hex color string
hsluv_to_hex <- function(hsl) {
  hsl |> cpp_hsluv_to_rgb() |> cpp_rgb_to_hex() |> tolower()
}
