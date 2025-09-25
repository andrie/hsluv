test_cases <-
  readRDS(system.file("test_cases.rds", package = "hsluv")) |>
  tibble::as_tibble()

tc_get <- function(
  what,
  n = get("n", parent.frame()),
  test_cases = get("test_cases", parent.frame())
) {
  test_cases[[what]][[n]]
}

test_that("rgb -> hex -> rgb round-trip works", {
  rgb <- tc_get("rgb", 10)
  hex <- tc_get("hex", 10)
  hex2 <- cpp_rgb_to_hex(rgb)
  rgb2 <- cpp_hex_to_rgb(hex2)
  hex3 <- cpp_rgb_to_hex(rgb2)
  expect_equal(rgb, rgb2)
  expect_equal(hex, hex2 |> tolower())
  expect_equal(hex, hex3 |> tolower())
})

test_that("hsluv to hex", {
  expect_equal(hsluv_to_hex(c(0, 0, 0)), "#000000")
  expect_equal(hsluv_to_hex(c(0, 0, 100)), "#ffffff")
  expect_equal(hsluv_to_hex(c(100, 10, 10)), "#1b1c19")
  expect_equal(hsluv_to_hex(c(10, 75, 65)), "#ec7d82")
})


test_that("hex to hsluv", {
  expect_equal(hex_to_hsluv("#000000"), c(0, 0, 0))
  expect_equal(hex_to_hsluv("#ffffff"), c(0, 0, 100))
  expect_equal(hex_to_hsluv("#ec7d82") |> round(1), c(10.0, 74.7, 65.1))
  expect_equal(hex_to_hsluv("#1b1c19") |> round(1), c(100.6, 12.3, 10.1))
})


# test_that("hsluv to rgb", {
#   expect_equal(hsluv_to_rgb(c(0, 0, 0)), c(0, 0, 0))
# })

test_that("random checks against test suite in cpp", {
  test_one_cpp <- function(n) {
    hex <- tc_get("hex", n)
    all.equal(
      hex_to_hsluv(hex),
      tc_get("hsluv", n)
    )
  }

  test_one_cpp(1) |> expect_true()
  seq_len(nrow(test_cases)) |>
    sample(size = 1000, replace = FALSE) |>
    vapply(test_one_cpp, logical(1)) |>
    all() |>
    expect_true()
})
