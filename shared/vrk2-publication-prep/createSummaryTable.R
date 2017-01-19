map <- read.table("motifTF.tsv", sep="\t", as.is=TRUE, header=TRUE)
tbl <- read.table("fimoResults.tsv", sep="\t", as.is=TRUE, header=TRUE, comment="")
tbl <- tbl[, -1]
colnames(tbl)[1] <- "motif"
tfs <- lapply(unique(map$motif), function(x) paste(sort(subset(map, motif==x)$tf), collapse=", "))
tbl.tfs <- data.frame(motif=unique(map$motif), TFs="", stringsAsFactors=FALSE)
for(i in 1:9)
   tbl.tfs[i, "TFs"] <- tfs[[i]]

tbl.new <- merge(tbl, tbl.tfs, by.x="motif", by.y="motif", all.x=TRUE)
tbl.new.sorted <- tbl.new[order(tbl.new$p.value, decreasing=FALSE),]
write.table(tbl.new.sorted, file="tbl.fimoTF", quote=FALSE, row.names=FALSE, sep="\t")
