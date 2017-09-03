library(plyr)
library(RMySQL)

mydb = dbConnect(MySQL(), host = "104.198.210.36", user = "root", password = "tacozombies54992", db = "analytics")
rs <- dbSendQuery(mydb, "select status_id, feed_likes, love, wow, haha, sad, angry, post_source_type, from_name from FEED_DATA")
ReactionsData <- fetch(rs, -1)
rs <- dbSendQuery(mydb, "select * from CONTENT_TRACK")
ContentTrackData <- fetch(rs, -1)
rs <- dbSendQuery(mydb, "select * from EDITORIAL_AUTHOR")
EditorialData <- fetch(rs, -1)
dbClearResult(rs)
dbDisconnect(mydb)


Data <- read.csv("Facebook Insights WAM.csv", header = TRUE, stringsAsFactors = FALSE)
LinkData <- read.csv("LinkData.csv", header = TRUE, stringsAsFactors = FALSE)
VideoData <- read.csv("VideoData.csv", header = TRUE, stringsAsFactors = FALSE)
PhotoData <- read.csv("PhotoData.csv", header = TRUE, stringsAsFactors = FALSE)

DataBH <- read.csv("Facebook Insights BH.csv", header = TRUE, stringsAsFactors = FALSE)
LinkDataBH <- read.csv("LinkDataBH.csv", header = TRUE, stringsAsFactors = FALSE)
VideoDataBH <- read.csv("VideoDataBH.csv", header = TRUE, stringsAsFactors = FALSE)
PhotoDataBH <- read.csv("PhotoDataBH.csv", header = TRUE, stringsAsFactors = FALSE)

DataFC <- read.csv("Facebook Insights FC.csv", header = TRUE, stringsAsFactors = FALSE)
LinkDataFC <- read.csv("LinkDataFC.csv", header = TRUE, stringsAsFactors = FALSE)
VideoDataFC <- read.csv("VideoDataFC.csv", header = TRUE, stringsAsFactors = FALSE)
PhotoDataFC <- read.csv("PhotoDataFC.csv", header = TRUE, stringsAsFactors = FALSE)


Data <- merge(Data, ReactionsData, by = "status_id", all.x = TRUE)
Data <- Data[!duplicated(Data),]
Data$created_time <- as.POSIXct(strptime(Data$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")
Data$date = strptime(Data$date, "%d/%m/%Y")
Data$date <- as.Date(Data$date)
# Data[Data$sharetext == "",]$sharetext <- "No Share Text"
Data[Data$sharetext == "",]$sharetext <- as.character(Data[Data$sharetext == "",]$status_id)
Data[Data$headline == "",]$headline <- as.character(Data[Data$headline == "",]$status_id)
Encoding(Data$sharetext) <- "latin1"
Encoding(Data$headline) <- "latin1"
Data$total_interactions <- Data$total_comments+Data$total_likes + Data$total_shares
Data$interaction_rate <- (Data$total_comments+Data$total_likes + Data$total_shares)/Data$post_reach
Data$ctr <- Data$link_clicks/Data$post_reach
Data$views_rate <- Data$post_video_views/Data$post_reach
Data$viral_fan_rate <- Data$post_reach_viral_unique/Data$post_reach_fan_unique
Data$share_rate <- Data$total_shares/(Data$total_comments + Data$total_likes + Data$total_shares)
Data$total_reactions <- (Data$feed_likes + Data$love + Data$wow + Data$haha + Data$sad + Data$angry)
Data$feed_likes_rate <- round(Data$feed_likes/Data$total_reactions, 4)
Data$love_rate <- round(Data$love/Data$total_reactions, 4)
Data$wow_rate <- round(Data$wow/Data$total_reactions, 4)
Data$haha_rate <- round(Data$haha/Data$total_reactions, 4)
Data$sad_rate <- round(Data$sad/Data$total_reactions, 4)
Data$angry_rate <- round(Data$angry/Data$total_reactions, 4)
Data$viral_rate <- (Data$post_reach_viral_unique/(Data$post_reach_fan_unique + Data$post_reach_viral_unique))
Data$fan_rate <- (Data$post_reach_fan_unique/(Data$post_reach_fan_unique + Data$post_reach_viral_unique))
Data$post_image <- paste("<img src ='", Data$full_picture,"'",'title=""', 'alt="" border="0" height="100" width="100">')


DataBH <- merge(DataBH, ReactionsData, by = "status_id", all.x = TRUE)
DataBH <- DataBH[!duplicated(DataBH),]
DataBH$created_time <- as.POSIXct(strptime(DataBH$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")
DataBH$date = strptime(DataBH$date, "%d/%m/%Y")
DataBH$date <- as.Date(DataBH$date)
# DataBH[DataBH$sharetext == "",]$sharetext <- "No Share Text"
DataBH[DataBH$sharetext == "",]$sharetext <- as.character(DataBH[DataBH$sharetext == "",]$status_id)
DataBH[DataBH$headline == "",]$headline <- as.character(DataBH[DataBH$headline == "",]$status_id)
Encoding(DataBH$sharetext) <- "latin1"
Encoding(DataBH$headline) <- "latin1"
DataBH$total_interactions <- DataBH$total_comments+DataBH$total_likes + DataBH$total_shares
DataBH$interaction_rate <- (DataBH$total_comments+DataBH$total_likes + DataBH$total_shares)/DataBH$post_reach
DataBH$ctr <- DataBH$link_clicks/DataBH$post_reach
DataBH$views_rate <- DataBH$post_video_views/DataBH$post_reach
DataBH$viral_fan_rate <- DataBH$post_reach_viral_unique/DataBH$post_reach_fan_unique
DataBH$share_rate <- DataBH$total_shares/(DataBH$total_comments+DataBH$total_likes + DataBH$total_shares)
DataBH$total_reactions <- (DataBH$feed_likes + DataBH$love + DataBH$wow + DataBH$haha + DataBH$sad + DataBH$angry)
DataBH$feed_likes_rate <- round(DataBH$feed_likes/DataBH$total_reactions, 4)
DataBH$love_rate <- round(DataBH$love/DataBH$total_reactions, 4)
DataBH$wow_rate <- round(DataBH$wow/DataBH$total_reactions, 4)
DataBH$haha_rate <- round(DataBH$haha/DataBH$total_reactions, 4)
DataBH$sad_rate <- round(DataBH$sad/DataBH$total_reactions, 4)
DataBH$angry_rate <- round(DataBH$angry/DataBH$total_reactions, 4)
DataBH$viral_rate <- (DataBH$post_reach_viral_unique/(DataBH$post_reach_fan_unique + DataBH$post_reach_viral_unique))
DataBH$fan_rate <- (DataBH$post_reach_fan_unique/(DataBH$post_reach_fan_unique + DataBH$post_reach_viral_unique))
DataBH$post_image <- paste("<img src ='", DataBH$full_picture,"'",'title=""', 'alt="" border="0" height="100" width="100">')


DataFC <- merge(DataFC, ReactionsData, by = "status_id", all.x = TRUE)
DataFC <- DataFC[!duplicated(DataFC),]
DataFC$created_time <- as.POSIXct(strptime(DataFC$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")
DataFC$date = strptime(DataFC$date, "%d/%m/%Y")
DataFC$date <- as.Date(DataFC$date)
# DataFC[DataFC$sharetext == "",]$sharetext <- "No Share Text"
DataFC[DataFC$sharetext == "",]$sharetext <- as.character(DataFC[DataFC$sharetext == "",]$status_id)
DataFC[DataFC$headline == "",]$headline <- as.character(DataFC[DataFC$headline == "",]$status_id)
Encoding(DataFC$sharetext) <- "latin1"
Encoding(DataFC$headline) <- "latin1"
DataFC$total_interactions <- DataFC$total_comments+DataFC$total_likes + DataFC$total_shares
DataFC$interaction_rate <- (DataFC$total_comments+DataFC$total_likes + DataFC$total_shares)/DataFC$post_reach
DataFC$ctr <- DataFC$link_clicks/DataFC$post_reach
DataFC$views_rate <- DataFC$post_video_views/DataFC$post_reach
DataFC$viral_fan_rate <- DataFC$post_reach_viral_unique/DataFC$post_reach_fan_unique
DataFC$total_reactions <- (DataFC$feed_likes + DataFC$love + DataFC$wow + DataFC$haha + DataFC$sad + DataFC$angry)
DataFC$feed_likes_rate <- round(DataFC$feed_likes/DataFC$total_reactions, 4)
DataFC$love_rate <- round(DataFC$love/DataFC$total_reactions, 4)
DataFC$wow_rate <- round(DataFC$wow/DataFC$total_reactions, 4)
DataFC$haha_rate <- round(DataFC$haha/DataFC$total_reactions, 4)
DataFC$sad_rate <- round(DataFC$sad/DataFC$total_reactions, 4)
DataFC$angry_rate <- round(DataFC$angry/DataFC$total_reactions, 4)
DataFC$viral_rate <- (DataFC$post_reach_viral_unique/(DataFC$post_reach_fan_unique + DataFC$post_reach_viral_unique))
DataFC$fan_rate <- (DataFC$post_reach_fan_unique/(DataFC$post_reach_fan_unique + DataFC$post_reach_viral_unique))
DataFC$share_rate <- DataFC$total_shares/(DataFC$total_comments+DataFC$total_likes + DataFC$total_shares)
DataFC$post_image <- paste("<img src ='", DataFC$full_picture,"'",'title=""', 'alt="" border="0" height="100" width="100">')


DataArticles <- Data[Data$post_type == "link",]
DataArticles <- merge(DataArticles, EditorialData, by = "status_id", all.x = TRUE)
DataArticles <- merge(DataArticles[,], LinkData[,c("status_id", "mitu_link", "category", "sponsored", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataArticles <- ddply(DataArticles, "mitu_link", transform, average_ctr = mean(ctr), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_link_clicks = mean(link_clicks))

DataArticles$author_status <- ifelse(!(DataArticles$author %in% c("Jorge Rodriguez-Jimenez", "Omar Villegas", "Lucas Molandes", "Jessica Garcia", "Andrew Santiago", "Jason Marcus")), "Contributor", DataArticles$author)

DataArticles$author_status <- ifelse(DataArticles$author %in% c("mitÃº Staff", "Adriana Venegas", "Fidel Martinez", "Alex Alvarez", "Wendy Barba"), "Old Staff", DataArticles$author_status)



DataVideos <- Data[Data$post_type == "video",]
DataVideos <- merge(DataVideos[,], VideoData[,c("status_id", "video_repost_sharetext", "video_meme", "series", "category", "format", "sponsored", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataVideos <- ddply(DataVideos, "video_repost_sharetext", transform, average_views_rate = mean(views_rate), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_video_views = mean(post_video_views), average_viral_fan_rate = mean(viral_fan_rate))
# DataVideos$created_time <- as.POSIXct(strptime(DataVideos$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")

DataPhotos <- Data[Data$post_type == "photo",]
DataPhotos <- merge(DataPhotos[,],PhotoData[,c("status_id", "image_text_py", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataPhotos <- ddply(DataPhotos, "image_text_py", transform, average_share_rate = mean(share_rate), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_viral_fan_rate = mean(viral_fan_rate))
# DataPhotos$created_time <- as.POSIXct(strptime(DataPhotos$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")


DataArticlesBH <- DataBH[DataBH$post_type == "link",]
DataArticlesBH <- merge(DataArticlesBH, EditorialData, by = "status_id", all.x = TRUE)
DataArticlesBH <- merge(DataArticlesBH[,], LinkDataBH[,c("status_id", "mitu_link", "category", "sponsored", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataArticlesBH <- ddply(DataArticlesBH, "mitu_link", transform, average_ctr = mean(ctr), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_link_clicks = mean(link_clicks))

DataArticlesBH$author_status <- ifelse(!(DataArticlesBH$author %in% c("Jorge Rodriguez-Jimenez", "Omar Villegas", "Lucas Molandes", "Jessica Garcia", "Andrew Santiago", "Jason Marcus")), "Contributor", DataArticlesBH$author)

DataArticlesBH$author_status <- ifelse(DataArticlesBH$author %in% c("mitÃº Staff", "Adriana Venegas", "Fidel Martinez", "Alex Alvarez", "Wendy Barba"), "Old Staff", DataArticlesBH$author_status)


DataVideosBH <- DataBH[DataBH$post_type == "video",]
DataVideosBH <- merge(DataVideosBH[,], VideoDataBH[,c("status_id", "video_repost_sharetext", "video_meme", "series", "category", "format", "sponsored", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataVideosBH <- ddply(DataVideosBH, "video_repost_sharetext", transform, average_views_rate = mean(views_rate), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_video_views = mean(post_video_views), average_viral_fan_rate = mean(viral_fan_rate))
# DataVideos$created_time <- as.POSIXct(strptime(DataVideos$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")

DataPhotosBH <- DataBH[DataBH$post_type == "photo",]
DataPhotosBH <- merge(DataPhotosBH[,],PhotoDataBH[,c("status_id", "image_text_py", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataPhotosBH <- ddply(DataPhotosBH, "image_text_py", transform, average_share_rate = mean(share_rate), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_viral_fan_rate = mean(viral_fan_rate))
# DataPhotos$created_time <- as.POSIXct(strptime(DataPhotos$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")


DataArticlesFC <- DataFC[DataFC$post_type == "link",]
DataArticlesFC <- merge(DataArticlesFC, EditorialData, by = "status_id", all.x = TRUE)
DataArticlesFC <- merge(DataArticlesFC[,], LinkDataFC[,c("status_id", "mitu_link", "category", "sponsored", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataArticlesFC <- ddply(DataArticlesFC, "mitu_link", transform, average_ctr = mean(ctr), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_link_clicks = mean(link_clicks))

DataArticlesFC$author_status <- ifelse(!(DataArticlesFC$author %in% c("Jorge Rodriguez-Jimenez", "Omar Villegas", "Lucas Molandes", "Jessica Garcia", "Andrew Santiago", "Jason Marcus")), "Contributor", DataArticlesFC$author)

DataArticlesFC$author_status <- ifelse(DataArticlesFC$author %in% c("mitÃº Staff", "Adriana Venegas", "Fidel Martinez", "Alex Alvarez", "Wendy Barba"), "Old Staff", DataArticlesFC$author_status)


DataVideosFC <- DataFC[DataFC$post_type == "video",]
DataVideosFC <- merge(DataVideosFC[,], VideoDataFC[,c("status_id", "video_repost_sharetext", "video_meme", "series", "category", "format", "sponsored", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataVideosFC <- ddply(DataVideosFC, "video_repost_sharetext", transform, average_views_rate = mean(views_rate), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_video_views = mean(post_video_views), average_viral_fan_rate = mean(viral_fan_rate))
# DataVideos$created_time <- as.POSIXct(strptime(DataVideos$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")

DataPhotosFC <- DataFC[DataFC$post_type == "photo",]
DataPhotosFC <- merge(DataPhotosFC[,],PhotoDataFC[,c("status_id", "image_text_py", "reposted", "original", "repost", "repost_order", "times_repost", "days_bet_repost")])
DataPhotosFC <- ddply(DataPhotosFC, "image_text_py", transform, average_share_rate = mean(share_rate), average_interaction_rate = mean(interaction_rate), average_post_reach = mean(post_reach), average_viral_fan_rate = mean(viral_fan_rate))
# DataPhotos$created_time <- as.POSIXct(strptime(DataPhotos$created_time, "%d/%m/%Y %H:%M"), tz = "GMT")

save(Data, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/PostData.Rda")
save(DataArticles, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataArticles.Rda")
save(DataVideos, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataVideos.Rda")
save(DataPhotos, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataPhotos.Rda")
save(DataBH, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/PostDataBH.Rda")
save(DataArticlesBH, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataArticlesBH.Rda")
save(DataVideosBH, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataVideosBH.Rda")
save(DataPhotosBH, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataPhotosBH.Rda")

save(DataFC, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/PostDataFC.Rda")
save(DataArticlesFC, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataArticlesFC.Rda")
save(DataVideosFC, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataVideosFC.Rda")
save(DataPhotosFC, file = "C:/Users/Marco Galvis/Documents/Repost_App_2.0/data/DataPhotosFC.Rda")

save(Data, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/PostData.Rda")
save(DataArticles, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataArticles.Rda")
save(DataVideos, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataVideos.Rda")
save(DataPhotos, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataPhotos.Rda")
save(DataBH, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/PostDataBH.Rda")
save(DataArticlesBH, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataArticlesBH.Rda")
save(DataVideosBH, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataVideosBH.Rda")
save(DataPhotosBH, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataPhotosBH.Rda")

save(DataFC, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/PostDataFC.Rda")
save(DataArticlesFC, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataArticlesFC.Rda")
save(DataVideosFC, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataVideosFC.Rda")
save(DataPhotosFC, file = "C:/Users/Marco Galvis/Documents/WeeklyRecApp/data/DataPhotosFC.Rda")

save(Data, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/PostData.Rda")
save(DataArticles, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataArticles.Rda")
save(DataVideos, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataVideos.Rda")
save(DataPhotos, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataPhotos.Rda")
save(DataBH, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/PostDataBH.Rda")
save(DataArticlesBH, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataArticlesBH.Rda")
save(DataVideosBH, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataVideosBH.Rda")
save(DataPhotosBH, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataPhotosBH.Rda")

save(DataFC, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/PostDataFC.Rda")
save(DataArticlesFC, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataArticlesFC.Rda")
save(DataVideosFC, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataVideosFC.Rda")
save(DataPhotosFC, file = "C:/Users/Marco Galvis/Documents/CreatorsContent App/data/DataPhotosFC.Rda")
