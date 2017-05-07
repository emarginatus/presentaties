basedir <- getwd()
if (!file_test("-d", "_site")) {
  dir.create("_site")
}
file.copy("wercker.yml", "_site")
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
}
setwd(basedir)
