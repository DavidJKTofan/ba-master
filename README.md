# Master Thesis
Master Thesis of my Master in Business Analytics (work in progress)...

# Data Source

- Idealista API: allowed us to get 50 property records per GET request, up to 100 requests per month. (<a href="https://www.idealista.com/labs/">Requested from Idealista Labs</a>). Requested in February 2020.

- Datos_abiertos_Red_de_Metros.zip: Metro Madrid Shapefile. Source: https://data-crtm.opendata.arcgis.com/datasets/m4-accesos?geometry=-3.730%2C40.417%2C-3.669%2C40.429. (<a href="http://www.crtm.es/">Powered by CRTM</a>). Downladed in June 2020.

- ES.txt: GeoNames Postal Codes of Spain. Source: http://download.geonames.org/export/zip/. (<a href="http://www.geonames.org/">Creative Commons Attribution 3.0 License</a>). Downladed in June 2020.

- 0_Codigo_Postal_2016.zip: 

# Data Cleaning & Transformation
Data downloaded over time (API requests) as JSON files, then deleted duplicates (by propertyCode) and unified all records, and finally converted to DataFrame.
<br><br>
Made sure that all datatypes are appropriate (e.g. size = number, district = character).
