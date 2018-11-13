library(magrittr)
library(tidyverse)

# Where the files are
from <- "/data/basespace/Projects/MorganLardelli_mRNASeq_Oct2018/Samples"
to <- "/data/20181113_MorganLardelli_mRNASeq/0_rawData/fastq"
dirs <- list.files(from)
wSpace <- grepl(" ", dirs) #Whitespace in the path. Grrr!

# Copy where there's no whitespace in the path
file.path(from, dirs[!wSpace], "Files") %>%
	sapply(list.files, pattern = "fastq.gz", full.names = TRUE, simplify = FALSE) %>%
	lapply(function(x){
		d <- unique(dirname(x)) 
		fl <- basename(x)
		smp <- unique(basename(dirname(d)))
		smp <- str_replace(smp, " ", "_") 
		smp <- str_replace_all(smp, "[\\(\\)]", "")
		smp <- paste0(smp, "_R1.fq.gz")
		system2("cat", paste(paste(x, collapse = " "), ">", file.path(to, smp)))
	})

# Copy where there's whitespace in the path
file.path(from, dirs[wSpace], "Files") %>%
	sapply(list.files, full.name = TRUE, simplify = FALSE) %>%
	lapply(function(x){
		outPath <- file.path(to, basename(x))
		file.copy(x, outPath, overwrite = TRUE)
		smp <- unique(basename(dirname(dirname(x))))
		smp <- str_replace(smp, " ", "_")
		smp <- str_replace_all(smp, "[\\(\\)]", "")
		smp <- paste0(smp, "_R1.fq.gz")
		system2("cat",
						paste(paste(outPath, collapse = " "), ">", file.path(to, smp)))
		rmFiles <- list.files(to, pattern = "00[1-4]", full.names = TRUE)
		file.remove(rmFiles)
	})
