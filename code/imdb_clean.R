library(data.table)
library(rjson)
library(magrittr)
ratings = fread("data/ratings.tsv")
episodes = fread("data/episodes.tsv")
#akas = fread("data/akas.tsv")
crew = fread("data/crew.tsv")
namebasics = fread("data/namebasics.tsv")
#akasen = akas[language=="en"]

#akasenstar = akasen[grepl("[Ss]tar", akasen$title)]

title_tconsts = c(TNG = "tt0092455", DS9 = "tt0106145", ENT = "tt0244365", VOY = "tt0112178")
swap_titletconsts = setNames(names(title_tconsts), title_tconsts)

epst = episodes[parentTconst %in% title_tconsts]
rm(episodes)
epst[,show := swap_titletconsts[parentTconst]]
epst = merge(epst, ratings, by = "tconst")

crewst = crew[tconst %in% epst$tconst]
crewst = merge(crewst, namebasics[,.(nconst, primaryName)], by.x="directors", by.y = "nconst", all.x=T,all.Y=F)
crewst[directors == "nm0092853,nm0934664", primaryName := "Cliff Bole,Terry Windell"]
crewst[directors == "nm0484464,nm0562251", primaryName := "Les Landau,Russ Mayberry"]
crewst[directors == "nm0515237,nm0892144", primaryName := "David Livingston,Michael Vejar"]

epst = merge(epst, crewst[,.(tconst, director = primaryName)], by = "tconst")
epst$seasonNumber %<>% as.numeric()
epst$episodeNumber %<>% as.numeric()
rm(crew)
rm(namebasics)
rm(ratings)
gc()
keycols = c("show","seasonNumber", "episodeNumber")
setkeyv(epst, keycols)
saveRDS(epst, "data/from_imdb.rds")


epst = readRDS("data/from_imdb.rds")
scripts = fromJSON(file = "data/all_series_lines.json")
scripts$TAS = NULL
scripts$TOS = NULL

cast_cbind = function(orig, new, showname){
  orig = as.data.frame(orig)
  for(v in names(new)){
    orig[orig$show==showname, v] = new[[v]]
    orig[[v]][is.na(orig[[v]])] = 0
  }
  as.data.table(orig)
}


maincast = list()
maincast$TNG = c("PICARD", "RIKER", "LAFORGE", "WORF", "CRUSHER", "TROI", "DATA", "WESLEY")
maincast$DS9 = c("SISKO", "ODO", "DAX", "JAKE", "O'BRIEN", "QUARK", "BASHIR", "KIRA", "WORF")
maincast$ENT = c("ARCHER", "T'POL", "PHLOX", "REED", "TRAVIS", "HOSHI", "TUCKER")
maincast$VOY = c("JANEWAY", "CHAKOTAY", "TUVOK", "PARIS", "EMH", "TORRES", "KIM", "NEELIX", "KES", "SEVEN")

scripts2 = list()
scripts2$TNG = sapply(scripts$TNG, function(z) sapply(z,length))
scripts2$TNG = sapply(scripts2$TNG, function(z) (100*z/sum(z))[maincast$TNG]) %>% t %>% as.data.table
#scripts2$TNG = sapply(scripts2$TNG, function(z) z[maincast$TNG]) %>% t %>% apply(1, function(z) 100*z/sum(z)) %>% t %>% as.data.table()
names(scripts2$TNG) = paste0("cast_", maincast$TNG)
epst %<>% cast_cbind(new = scripts2$TNG, showname="TNG")

scripts2$DS9 = sapply(scripts$DS9, function(z) sapply(z,length))
#scripts2$DS9 = sapply(scripts2$DS9, function(z) z[maincast$DS9]) %>% t
scripts2$DS9 = sapply(scripts2$DS9, function(z) (100*z/sum(z))[maincast$DS9]) %>% t %>% as.data.table
scripts2$DS9[is.na(scripts2$DS9)] = 0
#scripts2$DS9 %<>% apply(1, function(z) z/sum(z)) %>% t %>% as.data.table()
names(scripts2$DS9) = paste0("cast_", maincast$DS9)
epst %<>% cast_cbind(new = scripts2$DS9, showname="DS9")

scripts2$ENT = sapply(scripts$ENT, function(z) sapply(z,length))
scripts2$ENT = sapply(scripts2$ENT, function(z) (100*z/sum(z))[maincast$ENT]) %>% t %>% as.data.table
#scripts2$ENT = sapply(scripts2$ENT, function(z) z[maincast$ENT]) %>% t
scripts2$ENT[is.na(scripts2$ENT)] = 0
#scripts2$ENT %<>% apply(1, function(z) 100*z/sum(z)) %>% t %>% as.data.table()
names(scripts2$ENT) = paste0("cast_", maincast$ENT)
epst %<>% cast_cbind(new = scripts2$ENT, showname="ENT")

scripts2$VOY = fread("data/voy_scripts.csv")
scripts2$VOY$V1 = NULL
scripts2$VOY$V13 = NULL
scripts2$VOY$V12 = NULL
names(scripts2$VOY) = paste0("cast_", maincast$VOY)
scripts2$VOY %<>% apply(1, function(z) z/sum(z)) %>% t %>% as.data.frame
epst %<>% cast_cbind(new = scripts2$VOY, showname="VOY")

epst$tconst = NULL
epst$parentTconst = NULL
epst$imdb = epst$averageRating
epst$averageRating = NULL
epst$numVotes = NULL

names(epst)[names(epst)=="cast_O'BRIEN"] = "cast_OBRIEN"

saveRDS(epst, "data/from_imdb_so.rds")











