library(RPostgreSQL)
library(TReNA)
library(gplots)
library (RColorBrewer)

source("../trenadb-utils.R")

db.trena <- dbConnect(PostgreSQL(), user="trena", password="trena", dbname="trena", host="whovian")
db.gtf <- dbConnect(PostgreSQL(), user= "trena", password="trena", dbname="gtf", host="whovian")
tbl.trem2 <- dbGetQuery(db.gtf, "select * from hg38human where gene_name='TREM2' and moleculetype='gene'")
db.hint <- dbConnect(PostgreSQL(), user="trena", password="trena", dbname="hint", host="whovian")
db.wellington <- dbConnect(PostgreSQL(), user="trena", password="trena", dbname="wellington", host="whovian")
tbl.genesmotifs <- dbGetQuery(db.trena, "select * from tfmotifs")

tbl.trem2

target.gene <- "TREM2"
shoulder <- 1000
chrom <- tbl.trem2$chrom
start <- tbl.trem2$start
end <- tbl.trem2$end
strand <- tbl.trem2$strand
tss <- tbl.trem2$start
if(tbl.trem2$strand == '-')
   tss <- tbl.trem2$end
start <- tss - shoulder
end   <- tss + shoulder

tbl.h <- createHintTable(chrom, start, end)
motifs <- unique(tbl.h$motif.h)
candidate.tfs <- sort(unique(subset(tbl.genesmotifs, motif %in% tbl.h$motif)$gene))
tbl.h
