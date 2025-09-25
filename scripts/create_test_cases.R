# Read the test cases from the JavaScript test suite
test_cases <- jsonlite::fromJSON(system.file(
  "snapshot-rev4.json",
  package = "hsluv"
))

# #' Read snapshot of hsluv values for testing.
# #'
# #' Original file from the JavaScript implementation at https://github.com/hsluv/hsluv/blob/main/snapshots/snapshot-rev4.json
# #' @keywords internal
# .read_hsluv_snapshot <- function() {
#   snapshot_file <- system.file("snapshot-rev4.json", package = "hsluv")
#   jsonlite::fromJSON(snapshot_file)
# }

# Convert to tidy data and save as RDS
tibble::tibble(
  hex = names(test_cases),
  data = unname(test_cases)
) |>
  tidyr::hoist(
    data,
    lch = "lch",
    luv = "luv",
    rgb = "rgb",
    xyz = "xyz",
    hpluv = "hpluv",
    hsluv = "hsluv"
  ) |>
  saveRDS(file.path("inst", "test_cases.rds"))
