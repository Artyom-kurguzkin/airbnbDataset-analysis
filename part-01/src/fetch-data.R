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

# This doesn't work, because of the columns have multiple entries? Convert them to vectors?
write_tsv(data_tb, file="part-01/dat/data.csv",)

