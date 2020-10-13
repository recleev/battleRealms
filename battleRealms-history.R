# Detach and Remove {battleRealmss} Before Rebuilding --------------------

rm(list = ls())
detach("package:battleRealms", unload = TRUE)
remove.packages("battleRealms")

# Ensure Correct Attachments in DESCRIPTION -------------------------------

attachment::att_to_description()

# Write Manuals -----------------------------------------------------------

roxygen2::roxygenise()

# Build and Install Package -----------------------------------------------

devtools::build(vignettes = FALSE, manual = FALSE)

devtools::install(
  reload = TRUE, build = FALSE,
  upgrade = "never"
)

# Build README.md ---------------------------------------------------------

devtools::build_readme()

# Build and Deploy battleRealms Website ---------------------------------

pkgdown::build_site(
  pkg = ".",
  preview = TRUE,
  devel = FALSE,
  # So that references and vignettes are not rewritten every time
  lazy = TRUE
)

# Check and Release -------------------------------------------------------

# devtools::check(document = FALSE)
