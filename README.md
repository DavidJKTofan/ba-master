# Master Thesis
Master Thesis of my Master in Business Analytics (work in progress)...
<br><br>
For educational purposes only.

# Data Sources

- <b>Idealista API</b>: allowed us to get 50 property records per GET request, up to 100 requests per month. (<a href="https://www.idealista.com/labs/">Requested from Idealista Labs</a>). Requested in February 2020.

- <b>ALL-JSON-FILES.csv</b>: all JSON data collected from the API, united into one single file.

- <b>Datos_abiertos_Red_de_Metros.zip</b>: Metro Madrid Shapefile. Source: https://data-crtm.opendata.arcgis.com/datasets/m4-accesos?geometry=-3.730%2C40.417%2C-3.669%2C40.429. (<a href="http://www.crtm.es/">Powered by CRTM</a>). Downloaded in June 2020.

- <b>Madrid_Postal_Codes.zip</b>: Postal Codes of Madrid Shapefile. Source: https://www.madrid.org/nomecalles/DescargaBDTCorte.icm. (<a href="http://www.madrid.org/iestadis/">Centro Regional de Información Cartográfica. Comunidad de Madrid</a>). Downloaded in June 2020.

- <b>Salud_Farmacias.zip</b>: Pharmacies in Madrid Shapefile. Source: https://www.madrid.org/nomecalles/DescargaBDTCorte.icm. (<a href="http://www.madrid.org/iestadis/">Centro Regional de Información Cartográfica. Comunidad de Madrid</a>). Downloaded in June 2020.

- <b>Educacion_Centros.zip</b>: Public Education Centres in Madrid Shapefile. Source: https://www.madrid.org/nomecalles/DescargaBDTCorte.icm. (<a href="http://www.madrid.org/iestadis/">Centro Regional de Información Cartográfica. Comunidad de Madrid</a>). Downloaded in June 2020.

# Data Cleaning & Transformation
Data downloaded over time (API requests) as JSON files with [Idealista_API.R](Idealista_API.R), then unified all records and deleted duplicates (by propertyCode), and finally converted to DataFrame with [JSON2DF.ipynb](JSON2DF.ipynb) on Google Colab.
<br><br>
Made sure that all datatypes are appropriate (e.g. size = number, district = character).

# Contributors

- Andrés David DELGADO MOSQUERA

- Iván Carlos BARRIO HERREROS

- David Jo Konstantin TOFAN
