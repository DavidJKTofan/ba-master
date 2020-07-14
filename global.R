# ---------------------------------------------------------------------------------------- #
### LIBRARIES ###
# ---------------------------------------------------------------------------------------- #

prepare_packages <- function(packages){
  # Chequeamos que paquetes no estan instalados:
  non_intalled <- packages[!(packages %in% installed.packages()[, "Package"])]
  # En caso de existir alguno a?n no instalado, lo instalamos:
  if (length(non_intalled)) 
    install.packages(non_intalled, dependencies = TRUE, repos = "http://cran.us.r-project.org")
  # Cargamos toda la lista de paquetes:
  sapply(packages, require, character.only = TRUE)
}
# List of libraries
packages <- c("RCurl", # getURL
              "shinycssloaders", # Loading sign
              "dplyr", # Data manipulation
              "ggplot2", # Visualization
              "plotly", # Interactive plots
              "ggcorrplot", # Correlation Analysis
              "DT", # Data Table
              "sjmisc", # is_empty
              "forecast", # Model accuracy
              ## Spatial Libraries ##
              "leaflet", # Interactive maps
              #"osmdata", # OSM
              "rgeos", # gCentroid
              #"rgdal", # readOGR
              "geosphere" # distm
)
# Load libraries
prepare_packages(packages)

# ---------------------------------------------------------------------------------------- #
### LOAD EXTERNAL FILES ###
# ---------------------------------------------------------------------------------------- #

## Statistical Model ##
if (exists('my_model')) {
  #print("hello")
} else {
  my_model <- readRDS(gzcon(url("https://github.com/DavidJKTofan/ba-master/blob/master/Data/final_model.rds?raw=true")), .GlobalEnv)
}

# ------------------------------------------------ #

## COD_POSTAL DATA ##
# Average price per postal code
if (exists('cod_postal_analysis') && is.data.frame(get('cod_postal_analysis'))) {
  #print("hello")
} else {
  cod_postal_analysis <- readRDS(gzcon(url("https://github.com/DavidJKTofan/ba-master/blob/master/Data/cod_postal_analysis.Rda?raw=true")), .GlobalEnv)
}

# ------------------------------------------------ #

## VISUAL LEAFLET DATA ##
# Long-Lat
if (exists('visual_leaflet_data') && is.data.frame(get('visual_leaflet_data'))) {
  #print("hello")
} else {
  visual_leaflet_data <- readRDS(gzcon(url("https://github.com/DavidJKTofan/ba-master/blob/master/Data/leaflet_data.Rda?raw=true")), .GlobalEnv)
}

visual_leaflet_data$COD_POSTAL

# ------------------------------------------------ #

## Hospital Coordinates DataFrame ##
if (exists('hospital_df') && is.data.frame(get('hospital_df'))) {
  #print("hello")
} else {
  hospital_df <- readRDS(gzcon(url("https://github.com/DavidJKTofan/ba-master/blob/master/Data/Madrid_hospital_coordinates.rds?raw=true")), .GlobalEnv)
}

# ------------------------------------------------ #

## Final DataFrame ##
if (exists('final_df') && is.data.frame(get('final_df'))) {
  #print("hello")
} else {
  final_df <- readRDS(gzcon(url("https://github.com/DavidJKTofan/ba-master/blob/master/Data/final_df.rds?raw=true")), .GlobalEnv)
}

# ------------------------------------------------ #

## Scaled Final DataFrame with ALL DATA ##
if (exists('final_df_scaled') && is.data.frame(get('final_df_scaled'))) {
  #print("hello")
} else {
  final_df_scaled <- readRDS(gzcon(url("https://github.com/DavidJKTofan/ba-master/blob/master/Data/final_df_scaled.rds?raw=true")), .GlobalEnv)
}

# Property Data and Demographic Data
# Merge final_df with COD_POSTAL data  # TESTING
final_df_COD_POSTAL <- merge(x = final_df, y = visual_leaflet_data, by = c("longitude","latitude"))#, all.x = TRUE) # Left Outer Join

# ------------------------------------------------ #

## Idealista Property Data ##
properties_data <- read.csv("https://raw.githubusercontent.com/DavidJKTofan/ba-master/master/Data/ALL-JSON-FILES.csv", header=T)
# Filter Data
properties_data <- properties_data %>%
  filter(properties_data$price < 500001,  # Only properties with less than 500k price
         properties_data$size < 500,  # m2
         properties_data$propertyType == 'flat', # Only property type Flat
         properties_data$municipality == 'Madrid')  # Only properties with less than 20k size
# Set PropertyCode as Index
rownames(properties_data) <- properties_data$propertyCode
# Drop unnecessary columns
drops <- c('X',
           'propertyCode', # Index
           'propertyType', # All flat
           'numPhotos',
           'address',
           'showAddress',
           'municipality', # All Mdrid
           'url',
           #'neighborhood',
           'hasVideo',
           'hasPlan',
           'has3DTour',
           'has360',
           #'priceByArea',
           'newDevelopmentFinished',
           'parkingSpace.isParkingSpaceIncludedInPrice',
           #'parkingSpace.parkingSpacePrice',
           'topNewDevelopment')
properties_data <- properties_data[ , !(names(properties_data) %in% drops)]

## CALCULATIONS ##
# VISIÓN GENERAL
info_box1 <- format(round(mean(properties_data$price), 2), nsmall = 2)
info_box2 <- format(round(mean(properties_data$size), 2), nsmall = 2)
info_box3 <- format(round(mean(properties_data$rooms), 2), nsmall = 2)

## ANALYSIS ##
# Factor Data only
properties_data_factor <- data.frame(select_if(properties_data, is.factor))
# Occurrences
# factor_lista <- properties_data_factor %>% 
#   count(district) %>% 
#   filter(n > 1) %>% 
#   select(-n)
factor_lista <- as.data.frame(table(properties_data_factor$district))
colnames(factor_lista)[1] <- "district"
colnames(factor_lista)[2] <- "Freq"
factor_lista <- factor_lista[factor_lista[, "Freq"] > 1,]
rownames(factor_lista) <- NULL
# Vector 
target <- as.vector(factor_lista$district)
# Filter
properties_data_factor <- filter(factor_lista, district %in% target) 
# Merge
properties_data_factor_g <- merge(properties_data_factor, properties_data)
# Convert status nan to good
properties_data_factor_g$status[properties_data_factor_g$status == "nan"] <- "good"
# Create graphs (BarCharts) for each column
properties_data_factor_graph <- ggplot(properties_data_factor_g, aes(district, fill = status)) + 
  geom_bar() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
# Recast/reorder floor variables
recast_data <- properties_data %>%
  mutate(floor = factor(ifelse(floor == '-1' | 
                                 floor == 'bj' | 
                                 floor == 'en' | 
                                 floor == 'ss' | 
                                 floor == 'st', 
                               # OTRO
                               'otro', 
                               ifelse(floor == '1', 
                                      # PRIMERA
                                      'primera', 
                                      ifelse(floor == '2' | 
                                               floor == '3' | 
                                               floor == '4' |
                                               floor == '5', 
                                             # MITAD
                                             'mitad',
                                             # ALTO
                                             'alto')))))  # floor groups
# TRUE/FALSE
recast_data$hasLift <- as.logical(recast_data$hasLift)
# hasLift Plot
properties_data_hasLift_graph <- ggplot(recast_data, aes(x = floor, fill = hasLift)) +
  geom_bar(position = 'fill') +
  theme_classic()
# Floor Status Plot
floor_status_global <- ggplot(recast_data, aes(x = floor, fill = status)) +
  geom_bar(position = 'fill') +
  theme_classic()
# price_size_floor Plot
# Non-linearity: check if the price is related to size
price_size_floor <- ggplot(recast_data, aes(x = size, y = price)) +
  geom_point(aes(color = floor),
             size = 0.5) +
  stat_smooth(method = 'lm',
              formula = y~poly(x, 2),
              se = TRUE,
              aes(color = floor)) +
  theme_classic()

## ##
# Recast/reorder floor variables
recast_data <- recast_data %>%
  mutate(status = factor(ifelse(status == 'good', 
                                # 1
                                '1', 
                                ifelse(status == 'renew', 
                                       # 2
                                       '2', 
                                       ifelse(status == 'newdevelopment', 
                                              # 3
                                              '3',
                                              # 4
                                              '4')))))  # status groups

## CORRELATION ##
correlations <- cor(properties_data[,c('price',
                                       'size', 
                                       'rooms', 
                                       'bathrooms', 
                                       'distance', 
                                       'priceByArea', 
                                       'parkingSpace.parkingSpacePrice')], 
                    use = 'complete.obs')
# Visualize correlation
correlation_plot <- ggcorrplot(correlations,  title = 'Correlación', method = 'square')

# ------------------------------------------------ #

# ---------------------------------------------------------------------------------------- #
