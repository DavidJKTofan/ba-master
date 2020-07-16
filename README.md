# Final Project

Master Thesis of our Masters in Business Analytics.
<br><br>
Title in Spanish: Predicción del precio de la vivienda mediante el uso de métodos estadísticos espaciales.
<br>
Title in English: Prediction of house prices through the use of spatial statistical methods.
<br>
The focus of this project is the city of Madrid, Spain.
<br>
DISCLAIMER: educational purposes only.

# Abstract

The housing market offers great opportunities to those who know how to take advantage of them. In this document we propose a spatial statistical study of the price of housing aimed both at obtaining an accurate prediction and at ensuring that said prediction is based on a solid and stable statistical model throughout the space; guaranteeing acceptable results even when trying to predict based on the data of a new house, totally unrelated to those used in the modeling phase.
Thanks to these techniques, we intend to offer a different point of view, basing our study on the influence that the price of a house suffers due to the value of its neighboring homes, and thus proposing a new framework of work and research little explored compared to other more traditional statistical models used for this topic.

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

# Dashboard Data Sources

Data sources which are especifically used for the Shiny Dashboard.

- <b>final_df.rds</b>: DataFrame of consolidated data.

- <b>final_df_scaled.rds</b>: scaled/normalized DataFrame of consolidated data.

- <b>final_model.rds</b>: Final statistical model.

- <b>leaflet_data.Rda</b>: DataFrame with all visual data for the interactive leaflet.

- <b>cod_postal_analysis.Rda</b>: DataFrame of Madrid postal data with average property price per area.

# Contributors

- Andrés David DELGADO MOSQUERA

- Iván Carlos BARRIO HERREROS

- David Jo Konstantin TOFAN

