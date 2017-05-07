basedir <- getwd()
if (!file_test("-d", "_site")) {
  dir.create("_site")
  dir.create("_site/images")
}
to_do <- list.files(
  path = basedir,
  pattern = "*.Rmd",
  recursive = TRUE,
  full.names = TRUE
)
for (filename in to_do) {
  setwd(dirname(filename))
  rmarkdown::render(basename(filename))
  file.copy(
    from = gsub("\\.Rmd", "\\.html", basename(filename)),
    to = paste0(basedir, "/_site"),
    overwrite = TRUE
  )
  file.copy(
    from = list.files(paste0(dirname(filename), "/images"), full.names = TRUE),
    to = paste0(basedir, "/_site/images"),
    overwrite = TRUE
  )
}
setwd(basedir)
