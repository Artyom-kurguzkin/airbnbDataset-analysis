library(reticulate)
py_run_string(
'
from pymongo import MongoClient
import pandas as pd

connection_string = "mongodb+srv://feld0017:BJrrqJpRLkmh43jG@comp2031.kovjwrp.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(connection_string)

db = client["sample_airbnb"]
data = db.listingsAndReviews.find()
#for i in data:
#  print(i["name"])
df = pd.DataFrame(list(data))
#print(df.head())
#print(df.columns)
df.replace(r"\\\\", "&", regex=True)

df.to_csv(path="fixed.tsv", sep="\t", index=False)
')
