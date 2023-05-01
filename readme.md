# COMP2031 - DATA ENGINEERING
- - - - - - - - - - - - - - -

## Introduction
Currently, this repo is seperated in to different sections. First, it is devided by parts, and then by whether it is code or data. Code is located in the `part-??/src/` directory, and any data files are located in the `part-??/dat/` directory. If anyone has a way they would rather organize it, feel free to change it as you see fit.

In the end, all code will need to be merged in to a single file, but keeping them separate may make it easier for people to work with.

We are all collaborating on this, so feel free to change stuff as you see fit, just make sure you document what you changed and why.

## Part 1
Currently, part one just downloads the data from MongoDB, using my connection string. **My connection string will not work for you.**

It also exports the data to a `bson` (binary json) file. This file can be loaded for further work by first using 
```R
data = mongo(connection_string = <YOUR_CONNECTION_STRING_HERE>)
```
then load the file, by doing 
```R
data$import(file("part-01/dat/data.bson"), bson = True)
```

