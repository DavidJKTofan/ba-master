# Master Thesis
Master Thesis of my Master in Business Analytics (work in progress)...

# Data Source
Idealista API requested from https://www.idealista.com/labs/ which allowed us to get 50 property records per GET request, up to 100 requests per month.

# Data Cleaning & Transformation
Data downloaded over time (API requests) as JSON files, then deleted duplicates (by propertyCode) and unified all records, and finally converted to DataFrame.
<br>
Made sure that all datatypes are appropriate (e.g. size = number, district = character).

