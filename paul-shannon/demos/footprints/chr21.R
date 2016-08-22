library(RPostgreSQL)
library(igvR)
printf <- function(...) print(noquote(sprintf(...)))
db.hint <- dbConnect(PostgreSQL(), user= "trena", password="trena", dbname="hintTest2", host="whovian")
regions <- dbGetQuery(db.hint, "select count(*) from regions")[1,1]
hits <-  dbGetQuery(db.hint, "select count(*) from hits")[1,1]
printf("hint regions: %d  hits: %d  density: %2.3f",  regions, hits, hits/regions)


regions <- dbGetQuery(db.wellington, "select count(*) from regions")[1,1]
hits <-  dbGetQuery(db.wellington, "select count(*) from hits")[1,1]
printf("wellington regions: %d  hits: %d  density: %2.3f",  regions, hits, hits/regions)

APP.tss <- 25880550
loc.chrom <- "chr21"
loc.start <- APP.tss - 3000
loc.stop  <- APP.tss + 1000

query <- paste("select * from regions r",
              "inner join hits h",
              "on r.loc = h.loc",
              sprintf("where r.chrom = '%s'", loc.chrom),
              sprintf("and r.start > %d and r.stop < %d", loc.start, loc.stop))

tbl.hint <- dbGetQuery(db.hint, query)
dim(tbl.hint)

tbl.welt <- dbGetQuery(db.wellington, query)
dim(tbl.welt)

columns.of.interest <- c("chrom", "start", "stop", "name", "strand", "sample_id", "score1")
print(tbl.hint[, columns.of.interest])
print(tbl.welt[, columns.of.interest])
