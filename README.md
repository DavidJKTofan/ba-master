# Final Project

Master Thesis of our Masters in Business Analytics. The focus of this project is the city of Madrid, Spain.
<br><br>
Title in Spanish: Predicción del precio de la vivienda mediante el uso de métodos estadísticos espaciales.
<br><br>
Title in English: Prediction of house prices through the use of spatial statistical methods.
<br><br>
<br>
**DISCLAIMER:** _educational purposes only. Some data files were excluded from the repository in order to respect certain privacy laws. This repository does not represent the Contributors' or any other person's or institution's political or personal views or opinions.
The information contained in this repository is for general information and educational purposes only. While we – the Contributors – endeavour to keep the information up to date and correct, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the content or the websites, services, or related graphics contained on this repository for any purpose. Any reliance you place on such information is therefore strictly at your own risk. In no event will we be liable for any loss or damage including without limitation, indirect or consequential loss or damage, or any loss or damage whatsoever arising from loss of data or profits arising out of, or in connection with, the use of the information stated in this repository._


# Abstract

The housing market offers great opportunities to those who know how to take advantage of them. In this document we propose a spatial statistical study of the price of housing aimed both at obtaining an accurate prediction and at ensuring that said prediction is based on a solid and stable statistical model throughout the space; guaranteeing acceptable results even when trying to predict based on the data of a new house, totally unrelated to those used in the modeling phase.
Thanks to these techniques, we intend to offer a different point of view, basing our study on the influence that the price of a house suffers due to the value of its neighboring homes, and thus proposing a new framework of work and research little explored compared to other more traditional statistical models used for this topic.


# Statistical Models used

- Generalized Linear Model (GLM)
- Spatial Generalized Linear Model (GLM)
- Spatial AutoRegressive (SAR) 


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

