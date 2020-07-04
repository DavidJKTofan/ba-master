### IDEALISTA API ###

# Working Directory
setwd("/Users/YOURNAMEHERE/Desktop")

# Consumer Key & Secret (CONFIDENTIAL)
source("Idealista_Auth.R")  # Load variables from external file
#consumer_key <- "XXXXX"
#consumer_secret <- "XXXXX"
# SOURCE: http://developers.idealista.com/access-request

# Secret
secret <- jsonlite::base64_enc(paste(consumer_key, consumer_secret, sep = ":"))

## Search URL parameters ##
operation <- "sale"  # sale, rent
order <- "publicationDate"  # priceDown
center <- "40.4167,-3.70325"  # Madrid
distance <- "3000"  # meters
maxPrice <- "500000"  # euros
propertyType <- "homes"  # homes, offices, premises, garages, bedrooms
sorting <- "desc"  # asc
language <- "es"  # es, it, pt

## FOR LOOP parameters ##
# Amount of loops
x <- 10  # Search pages
# Time between loops
sleeping <- 12  # Seconds

for (i in 1:x) {
  ## START ##
  # Total waiting time
  if (i == 1){
    y <- x * sleeping
    print(paste("Wait for", y, "seconds in total, for", x, "JSON files."))
  }
  
  # Request
  req <- httr::POST("https://api.idealista.com/oauth/token",
                    httr::add_headers(
                      "Authorization" = paste("Basic", gsub("\n", "", secret)),
                      "Content-Type" = "application/x-www-form-urlencoded;charset=UTF-8"
                    ),
                    body = "grant_type=client_credentials"
  )
  # Token
  token <- paste("Bearer", httr::content(req)$access_token)
  
  # Search URL
  url <- paste("https://api.idealista.com/3.5/es/search?operation=", operation, 
               "&maxItems=50&order=", order, 
               "&center=", center, 
               "&distance=", distance, 
               "&maxPrice=", maxPrice, 
               "&propertyType=", propertyType, 
               "&sort=", sorting, 
               "&numPage=",i,
               "&language=", language, 
               sep = "")

  # Request
  req <- httr::POST(url, httr::add_headers("Authorization" = token))
  
  # Timestamp
  newsystime <- format(Sys.time(),"%Y-%m-%d-%H-%M-%S")
  
  # Request JSON file as text
  json <- httr::content(req, as = "text")
  
  # Convert JSON
  df <- jsonlite::fromJSON(json)
  
  # Save JSON file with timestamp
  jsonlite::write_json(df, path = paste("Idealista_", newsystime, ".json", sep = ""))
  
  # Progress
  if (i < x){
    # Saved confirmation
    print(paste("JSON File", i, "has been saved.", sep = " "))
    # Wait
    Sys.sleep(sleeping)  # Seconds
  } else {
    # Saved confirmation
    print(paste("JSON File", i, "has been saved.", sep = " "))
    # Done
    print("Done!")
    print("All JSON files have been saved in your Working Directory.")
  }
  ## END ##
}


## ALTERNATIVE URLs ##
#url <- "https://api.idealista.com/3.5/es/search?operation=sale&maxItems=50&order=priceDown&center=40.4167,-3.70325&distance=3000&maxPrice=500000&propertyType=homes&sort=desc&numPage=1&language=es"

#url <- "https://api.idealista.com/3.5/es/search?operation=sale&maxItems=50&order=priceDown&center=40.4167,-3.70325&distance=10000&maxPrice=500000&propertyType=homes&subtypology=flats&sort=desc&numPage=1&language=es"
