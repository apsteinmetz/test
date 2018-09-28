#https://gist.github.com/eliocamp/18a03cc3c891d5f1e3c3e347192263c6
library(data.table)
library(ggplot2)

#devtools::install_github("geneticsMiNIng/metR")
devtools::install_github("eliocamp/metR")
library(metR)

out.file <- "~/Downloads/erebus_atm_2001_dem_v5.tif"
if (!file.exists(out.file)) {
  # data => https://www.pgc.umn.edu/data/elevation/
  # ~ 90Mb   
  download.file("http://data.pgc.umn.edu/elev/dem/atm/2001/erebus_atm_2001_dem_v5.tif",
                out.file)
}

#erebus <- tiff::readTIFF(out.file)
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 33550 (0x830e) encountered
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 33922 (0x8482) encountered
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 34735 (0x87af) encountered
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 34736 (0x87b0) encountered
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 34737 (0x87b1) encountered
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 42112 (0xa480) encountered
#> Warning in tiff::readTIFF(out.file): TIFFReadDirectory: Unknown field with
#> tag 42113 (0xa481) encountered

erebus<-readRDS(file = "erebus.rds")

erebus[erebus == -9999] <- NA
dimnames(erebus) <- list(x = seq_len(5004), y = seq_len(4504))
erebus <- setDT(data.table::melt(erebus))
erebus <- erebus[!is.na(value)]

bin_width <- 15
data<-erebus[y %between% c(1500, 2500) & x %between% c(2000, 3500)]
gg<-ggplot(data, aes(x, y))
gg<- gg+geom_relief(aes(z = value), alpha = 1)

#gg<-gg + geom_contour2(aes(z = value, size = ..level..),
#                       binwidth = bin_width, 
#                       color = "black")
## gg<-gg + geom_contour(aes(z = value),color="grey")

gg<-gg +  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_size(range = c(0.1, 0.2), guide = "none") +
  coord_equal() +
  theme_void() 
gg
