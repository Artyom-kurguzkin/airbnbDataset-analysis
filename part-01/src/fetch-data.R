# Set up the mongolite package.
install.packages("mongolite")
library(mongolite)

# Use a connection_string to connect to mongodb. This uses my login details.
# You will need to change this to reflect your details if you want to connect 
# to mongodb.
connection_string = "mongodb+srv://feld0017:BJrrqJpRLkmh43jG@comp2031.kovjwrp.mongodb.net/?retryWrites=true&w=majority"

# Load the data from mongodb.
data = mongo(collection = "listingsAndReviews", db = "sample_airbnb", url = connection_string)

# OPTIONAL: Export the data to a binary json (bson) file.
data$export(file("part-01/dat/data.bson"), bson = TRUE)

# Convert the data to a Tibble:
# Install Tidyverse
install.packages("tidyverse")
library(tidyverse)

# Make the Tibble
data_tb = as_tibble(data$aggregate())


# "clean data"

data_tb = select(add_column(data_tb,
              transmute(data_tb,
              review_scores_accuracy = data_tb$review_scores$review_scores_accuracy, 
              review_scores_cleanliness = data_tb$review_scores$review_scores_cleanliness, 
              review_scores_checkin = data_tb$review_scores$review_scores_checkin,
              review_scores_communication = data_tb$review_scores$review_scores_communication,
              review_scores_location = data_tb$review_scores$review_scores_location,
              review_scores_value = data_tb$review_scores$review_scores_value,
              review_scores_rating = data_tb$review_scores$review_scores_rating)),
              -review_scores)

data_tb = select(
            add_column(data_tb,
              transmute(data_tb, 
                        images_picture_url = data_tb$images$picture_url)),
              -images)

data_tb = select(
            add_column(data_tb,
              transmute(data_tb, 
              availability_30 = data_tb$availability$availability_30, 
              availability_60 = data_tb$availability$availability_60, 
              availability_90 = data_tb$availability$availability_90, 
              availability_365 = data_tb$availability$availability_365)),
              -availability)

data_tb = select(
            add_column(data_tb,
             transmute(data_tb,
                       host_id=data_tb$host$host_id,
                       host_url=data_tb$host$host_url,
                       host_name=data_tb$host$host_name,
                       host_location=data_tb$host$host_location,
                       host_about=data_tb$host$host_about,
                       host_response_time=data_tb$host$host_response_time,
                       host_thumbnail_url=data_tb$host$host_thumbnail_url,
                       host_picture_url=data_tb$host$host_picture_url,
                       host_neighbourhood=data_tb$host$host_neighbourhood,
                       host_response_rate=data_tb$host$host_response_rate,
                       host_is_superhost=data_tb$host$host_is_superhost,
                       host_has_profile_pic=data_tb$host$host_has_profile_pic,
                       host_identity_verified=data_tb$host$host_identity_verified,
                       host_listings_count=data_tb$host$host_listings_count,
                       host_total_listings_count=data_tb$host$host_total_listings_count,
                       host_verifications=data_tb$host$host_verifications
                       )),
              -host
          )

data_tb = select(
  add_column(data_tb,
             transmute(data_tb,
                       address_street=data_tb$address$street,
                       address_suburb=data_tb$address$suburb,
                       address_government_area=data_tb$address$government_area,
                       address_market=data_tb$address$market,
                       address_country=data_tb$address$country,
                       address_country_code=data_tb$address$country_code,
                       address_location_type=data_tb$address$location$type,
                       address_location_coordinates=data_tb$address$location$coordinates,
                       address_location_is_location_exact=data_tb$address$location$is_location_exact
             )),
  -address
)

# This does work
write_tsv(data_tb, file="part-01/dat/data.csv")
