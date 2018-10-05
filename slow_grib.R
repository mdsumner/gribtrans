files <- raadtools::amps_d2files()
dir.create("gribfiles")
file.copy(files$fullname[c(1, nrow(files))], "gribfiles/")


outfile <- sprintf("%s.tif", tempfile())

gfiles <- list.files("gribfiles", full.names = TRUE, pattern = "grb$")

for (i in seq_along(gfiles)) {
  unlink(outfile)
print(system.time(system(sprintf("gdal_translate %s %s %s", gfiles[i], outfile, paste("-b", 200:220, collapse = " ")))))
}




## Blows out for the second file at -b 1:22 bands or more
# 0...10...20...30...40...50...60...70...80...90...100 - done.
#    user  system elapsed
#   1.108   0.461   1.564
# Input file size is 834, 786
# 0...10...20...30...40...50...60...70...80...90...100 - done.
# user  system elapsed
# 202.281   2.333 204.424
