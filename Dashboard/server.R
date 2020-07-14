#### SERVER ####
# ---------------------------------------------------------------------------------------- #

### SERVER LIBRARIES ###
library(shiny)
source('global.R', local = TRUE) # Load more libraries and functions

# ---------------------------------------------------------------------------------------- #

### SERVER ###
shinyServer(function(input, output, session) {
    
    ## BUTTON PRESS ##
    # Move from "Parámetros" to "Análisis" MenuTab
    observeEvent(input$goButton, {
        newtab <- switch(input$tabs, "dashboard" = "analyse","analyse" = "dashboard")
        updateTabItems(session, "tabs", newtab)
    })
    
    # --------------------- #
    
    ## USER INPUT VARIABLES ##
    # SIZE OUTPUT
    output$size_output <- renderText({
        paste("<b>","Size: ","</b>", input$size_input)
    })
    # ROOMS OUTPUT
    output$rooms_output <- renderText({
        paste("<b>","Rooms: ","</b>", input$rooms_input)
    })
    # BATHROOMS OUTPUT
    output$bathrooms_output <- renderText({
        paste("<b>","Bathrooms: ","</b>", input$bathrooms_input)
    })
    # HASLIFT OUTPUT
    output$hasLift_output <- renderText({
        paste("<b>","hasLift: ","</b>", input$hasLift_input)
    })
    # STATUS OUTPUT
    output$status_output <- renderText({
        paste("<b>","Status: ","</b>", input$status_input)
    })
    # POSTAL CODE OUTPUT
    output$postal_code_output <- renderText({
        paste("<b>","Postal Code: ","</b>", input$postal_code_input)
    })
    # OSM OUTPUT
    output$osm_output <- renderText({
        paste("<b>","OSM: ","</b>", input$osm_input)
    })
    
    # --------------------- #
    
    # IF NA function
    falseifNA <- function(x){
        ifelse(is.na(x), mean(cod_postal_analysis$avg_price_COD_POSTAL, na.rm = TRUE), x)
    }
    
    ## PLOTS ##
    # InfoBoxes
    output$Info1 <- renderValueBox({
        # When Button clicked
        if(input$goButton > 0) {
            # Average Price per Postal Code (COD_POSTAL)
            output_cod_postal_avg <- cod_postal_analysis[cod_postal_analysis[, "COD_POSTAL"] == input$postal_code_input,]
            output_cod_postal <- output_cod_postal_avg[,2]
            # Check if NA
            output_cod_postal <- falseifNA(output_cod_postal)
            # Conditions
            if (output_cod_postal >= 250001)
            {
                valueBox(tags$p("Precio medio del Código postal", style = "font-size: 60%;"), 
                         subtitle = tags$p(paste0("€ ", formatC(as.numeric(output_cod_postal), format="f", digits=0, big.mark=".", decimal.mark = ",")), style = "font-size: 150%;"),
                         icon = icon("map-marked"),
                         color = "green")
            }
            else if (output_cod_postal < 250000)
            {
                valueBox(tags$p("Precio medio del Código postal", style = "font-size: 60%;"), 
                         subtitle = tags$p(paste0("€ ", formatC(as.numeric(output_cod_postal), format="f", digits=0, big.mark=".", decimal.mark = ",")), style = "font-size: 150%;"),
                         icon = icon("map-marked"),
                         color = "red")
            }
            else {
                valueBox(tags$p("Precio medio del Código postal", style = "font-size: 60%;"), 
                         subtitle = tags$p(paste0("€ ", formatC(as.numeric(output_cod_postal), format="f", digits=0, big.mark=".", decimal.mark = ",")), style = "font-size: 150%;"),
                         #subtitle = tags$p(output_cod_postal, style = "font-size: 150%;"),
                         icon = icon("map-marked"),
                         color = "yellow")
            }
        } else {
            valueBox(tags$p("Precio medio del Código postal", style = "font-size: 60%;"), 
                     subtitle = tags$p("Waiting...", style = "font-size: 150%;"),
                     icon = icon("map-marked"),
                     color = "red")
        }
    })

    output$Info2 <- renderValueBox({
        # When Button clicked
        if(input$goButton > 0) {
            # Filter data
            final_df_COD_POSTAL_value <- final_df_COD_POSTAL %>%
                filter(final_df_COD_POSTAL$COD_POSTAL == input$postal_code_input,
                       final_df_COD_POSTAL$size.x >= input$size_input,
                       final_df_COD_POSTAL$rooms.x == input$rooms_input,
                       final_df_COD_POSTAL$bathrooms.x == input$bathrooms_input,
                       final_df_COD_POSTAL$hasLift.x == input$hasLift_input
                )
            # Check if value correct
            check_this <- is_empty(final_df_COD_POSTAL_value)
            if(check_this == FALSE){
                final_df_COD_POSTAL_value <- round(mean(final_df_COD_POSTAL_value$size.x), digits = 2)
            } else {
                final_df_COD_POSTAL_value <- round(mean(final_df_COD_POSTAL$size.x), digits = 2)
            }
            # Condition
            if (final_df_COD_POSTAL_value >= 75)
            {
                # valueBox
                valueBox(tags$p("Media de metros cuadrados", style = "font-size: 60%;"),
                         #subtitle = tags$p(input$size_input, style = "font-size: 150%;"),
                         subtitle = tags$p(final_df_COD_POSTAL_value, style = "font-size: 150%;"),
                         icon = icon("ruler-combined"),
                         color = "green")
            } else {
                # valueBox
                valueBox(tags$p("Media de metros cuadrados", style = "font-size: 60%;"),
                         #subtitle = tags$p(input$size_input, style = "font-size: 150%;"),
                         subtitle = tags$p(final_df_COD_POSTAL_value, style = "font-size: 150%;"),
                         icon = icon("ruler-combined"),
                         color = "yellow")
            }
        } else {
            valueBox(tags$p("Media de metros cuadrados", style = "font-size: 60%;"),
                     subtitle = tags$p("Waiting...", style = "font-size: 150%;"),
                     icon = icon("ruler-combined"),
                     color = "red")
        }
    })
    output$Info3 <- renderValueBox({
        # When Button clicked
        if(input$goButton > 0) {
            # Filter data
            final_df_COD_POSTAL_value <- final_df_COD_POSTAL %>%
                filter(final_df_COD_POSTAL$COD_POSTAL == input$postal_code_input,
                       final_df_COD_POSTAL$size.x >= input$size_input,
                       final_df_COD_POSTAL$rooms.x == input$rooms_input,
                       final_df_COD_POSTAL$bathrooms.x == input$bathrooms_input,
                       final_df_COD_POSTAL$hasLift.x == input$hasLift_input
                )
            # Check if value correct
            check_this <- is_empty(final_df_COD_POSTAL_value)
            if(check_this == FALSE){
                final_df_COD_POSTAL_value <- round(mean(final_df_COD_POSTAL_value$poblacionnacionales), digits = 2)
            } else {
                final_df_COD_POSTAL_value <- round(mean(final_df_COD_POSTAL$poblacionnacionales), digits = 2)
            }
            # Condition
            if (final_df_COD_POSTAL_value >= 170000)
            {
                # valueBox
                valueBox(tags$p("Media de población en el area", style = "font-size: 60%;"),
                         subtitle = tags$p(paste0("€ ", formatC(as.numeric(final_df_COD_POSTAL_value), format="f", digits=0, big.mark=".", decimal.mark = ",")), style = "font-size: 150%;"),
                         #subtitle = tags$p(final_df_COD_POSTAL_value, style = "font-size: 150%;"),
                         icon = icon("user-friends"),
                         color = "green")
            } else {
                # valueBox
                valueBox(tags$p("Media de población en el area", style = "font-size: 60%;"),
                         subtitle = tags$p(paste0("€ ", formatC(as.numeric(final_df_COD_POSTAL_value), format="f", digits=0, big.mark=".", decimal.mark = ",")), style = "font-size: 150%;"),
                         #subtitle = tags$p(final_df_COD_POSTAL_value, style = "font-size: 150%;"),
                         icon = icon("user-friends"),
                         color = "yellow")
            }
        } else {
            valueBox(tags$p("Media de población en el area", style = "font-size: 60%;"),
                     subtitle = tags$p("Waiting...", style = "font-size: 150%;"),
                     icon = icon("user-friends"),
                     color = "red")
        }
    })
    
    # --------------------- #
    
    ## DATATABLE ##
    values <- reactiveValues()
    # Empty DataFrame
    values$df <- data.frame(lat = numeric(0), long = numeric(0), size = numeric(0), rooms = numeric(0), bathrooms = numeric(0), hasLift = numeric(0), status = numeric(0), floor = numeric(0), postal_code = numeric(0), district = numeric(0))
    # When Button clicked
    newEntry <- observe({
        if(input$goButton > 0) {
            newLine <- isolate(c(input$location_lat_input, input$location_long_input, input$size_input, input$rooms_input, input$bathrooms_input, input$hasLift_input, input$status_input, input$floor_input, input$postal_code_input, input$district_input))
            # Add new values to DataTable
            isolate(values$df[nrow(values$df) + 1,] <- c(input$location_lat_input, input$location_long_input, input$size_input, input$rooms_input, input$bathrooms_input, input$hasLift_input, input$status_input, input$floor_input, input$postal_code_input, input$district_input))
        }})
    
    ## DATATABLE OUTPUT ##
    output$table_register <- renderDataTable({
        # USER INPUT REGISTER TABLE
        datatable(values$df,
                  caption = htmltools::tags$caption(
                      style = 'caption-side: bottom; text-align: center;',
                      'Table 1: ', htmltools::em('Data searched by the user during current session.')
                  ),
                  extensions = c('FixedColumns'),
                  escape=FALSE,
                  rownames=FALSE,
                  filter = list(position = 'top', clear = FALSE, plain=T),
                  options = list(
                      dom = 'ifrtlp',
                      fixedColumns=list(leftColumns =1),
                      searching=T,
                      pageLength=10,
                      scrollX=TRUE,
                      autoWidth = T,
                      deferRender=F,
                      stateSave=TRUE
                  ))
    })
    
    # --------------------- #
    
    ## DATATABLE ##
    # DATATABLE OUTPUT
    output$idealista_table <- renderDataTable({
        # DataTable Options
        properties_data = datatable(properties_data,
                                    caption = htmltools::tags$caption(
                                        style = 'caption-side: bottom; text-align: center;',
                                        'Table 1: ', htmltools::em('Data from Idealista API.')
                                    ),
                                    extensions = c('FixedColumns'),
                                    escape=FALSE,
                                    rownames=FALSE,
                                    filter = list(position = 'top', clear = FALSE, plain=T),
                                    options = list(
                                        dom = 'ifrtlp',
                                        fixedColumns=list(leftColumns =1),
                                        searching=T,
                                        pageLength=10,
                                        scrollX=TRUE,
                                        autoWidth = T,
                                        deferRender=F,
                                        stateSave=TRUE
                                    )) %>% 
            formatCurrency("price", currency = "€", digits = 0, before = FALSE)
        
        return(properties_data)
    })
    
    # --------------------- #
    
    ## INFO BOXES ##
    # InfoBoxes
    output$info_box_1 <- renderValueBox({
        valueBox(tags$p("Media de precio", style = "font-size: 90%;"), 
                 subtitle = tags$p(paste0("€ ", formatC(as.numeric(info_box1), format="f", digits=0, big.mark=".", decimal.mark = ",")), style = "font-size: 150%;"),
                 #info_box1
                 icon = icon("tags"))
    })
    output$info_box_2 <- renderValueBox({
        valueBox(tags$p("Media de tamaño", style = "font-size: 90%;"), 
                 subtitle = tags$p(info_box2, style = "font-size: 150%;"),
                 icon = icon("arrows-alt-h"),
                 color = "yellow")
    })
    output$info_box_3 <- renderValueBox({
        valueBox(tags$p("Media de habitaciones", style = "font-size: 90%;"), 
                 subtitle = tags$p(info_box3, style = "font-size: 150%;"),
                 icon = icon("door-closed"),
                 color = "green")
    })
    
    # --------------------- #
    
    ## PLOTS ##
    
    ## Distribution Factor Plot
    output$property_factor <- renderPlot({
        return(properties_data_factor_graph)
    })
    
    ## hasLift Plot
    output$hasLift_graph <- renderPlot({
        return(properties_data_hasLift_graph)
    })
    
    ## hasParkingSpace_graph Plot
    output$floor_status_graph <- renderPlot({
        return(floor_status_global)
    })
    
    ## hasParkingSpace_graph Plot
    output$price_size_floor_graph <- renderPlot({
        return(price_size_floor)
    })
    
    ## Correlation Plot
    output$correlation_graph <- renderPlot({
        return(correlation_plot)
    })
    
    # --------------------- #
    
    # Leaflet Height
    Height <- reactive(input$Height)
    
    # USER LONGITUDE LATITUDE (LONGLAT) OUTPUT
    output$leaflet_map_distance_graph <- renderLeaflet({
        # When Button clicked
        if(input$goButton > 0) {
            # Prepare the text for tooltips:
            mytext1 <- paste(
                "<b>Hospital</b>","<br/>",
                "Postal Code: ", hospital_df$COD_POSTAL,
                sep="") %>%
                lapply(htmltools::HTML)
            mytext2 <- paste(
                "<b>Metro Station</b>", "<br/>",
                "Access Name: ", visual_leaflet_data$NOMBREVIA, "<br/>",
                "Postal Code: ", visual_leaflet_data$COD_POSTAL,
                sep="") %>%
                lapply(htmltools::HTML)
            mytext3 <- paste(
                "<b>Pharmacy</b>", "<br/>",
                "District: ", visual_leaflet_data$district, "<br/>",
                "Neighborhood: ", visual_leaflet_data$neighborhood, "<br/>",
                "Postal Code: ", visual_leaflet_data$COD_POSTAL,
                sep="") %>%
                lapply(htmltools::HTML)
            # USER LOCATION INPUT
            long_input <- as.numeric(input$location_long_input)
            lat_input <- as.numeric(input$location_lat_input)
            # Icon as Legend
            html_legend <- "<img src='https://img.icons8.com/flat_round/64/000000/home--v1.png'> Your property"
            # LEAFLET PLOT
            m <- leaflet(options = leafletOptions(minZoom = 10, maxZoom = 18)) %>%
                addTiles() %>%
                # PROPERTY MARKER
                addMarkers(lng = long_input, 
                           lat = lat_input, 
                           popup="Your property",
                           icon = list(
                               iconUrl = 'https://img.icons8.com/flat_round/64/000000/home--v1.png', # Home Page icon by Icons8. Source: https://icons8.com/icon/rvNyu-uVzP4L/home-page
                               iconSize = c(60, 60)
                           )) %>%
                # HOSPITALS
                addCircleMarkers(data = visual_leaflet_data,
                                 lat = ~hospital_df$latitude_hospital,
                                 lng = ~hospital_df$longitude_hospital,
                                 radius = 2,
                                 color = "red",
                                 label = mytext1) %>% 
                # METRO STATIONS
                addCircleMarkers(data = visual_leaflet_data,
                                 lat = ~y, lng = ~x,
                                 radius = 2,
                                 color = "blue",
                                 label = mytext2) %>%
                # PHARMACIES
                addCircleMarkers(data = visual_leaflet_data,
                                 lat = ~latitude_farmacia, lng = ~longitude_farmacia,
                                 radius = 2,
                                 color = "green",
                                 label = mytext3) %>%
                # BOUNDS AND VIEWS
                setMaxBounds(lng1 = -3.903, lat1 = 40.216, lng2 = -3.303, lat2 = 40.816 ) %>% 
                setView(long_input, lat_input, zoom = 15) %>%
                # LEGEND
                addLegend(
                    position = "bottomright",
                    colors =c("#0000ff", "#FF0000"),
                    labels = c("Metro stations","Pharmacies"),
                    title = "Legend."
                ) %>%
                addControl(html = html_legend, position = "bottomleft")
            
            return(m)
        }
    })
    
    # --------------------- #
    
    ## PREDICT BUTTON ##
    output$model_result <- renderText({
        # When Button clicked
        if(input$goButton > 0) {
            # distance INPUT
            df_filtered_distance <- final_df %>%
                filter(district == input$district_input)
            df_filtered_distance_mean <- mean(df_filtered_distance$distance)
            
            # floorotro INPUT
            # Conditions
            if (input$floor_input == "otro") {
                floor_otro_input <- 1
            } else {
                floor_otro_input <- 0
            }
            
            # status INPUT
            if (input$status_input == 'good') {
                status_model <- 1
            } else if (input$status_input == 'renew') {
                status_model <- 2
            } else if (input$status_input == 'newdevelopment') {
                status_model <- 3
            } else {
                status_model <- 4
            }
            
            # ventas INPUT
            df_filtered_ventas <- final_df %>%
                filter(district == input$district_input)
            df_filtered_ventas_mean <- mean(df_filtered_ventas$ventas)
            
            #
            df_filtered_poblacionextranjeros <- final_df %>%
                filter(district == input$district_input)
            df_filtered_poblacionextranjeros_mean <- mean(df_filtered_poblacionextranjeros$poblacionextranjeros)
            
            # desempleo INPUT
            df_filtered_desempleomujeres <- final_df %>%
                filter(district == input$district_input)
            df_filtered_desempleomujeres_mean <- mean(df_filtered_desempleomujeres$desempleomujeres)
            
            # distancia_km_hospital INPUT
            ## FIND CLOSEST HOSPITAL ##
            # HOSPITAL LONGLAT DATA
            long_hospital <- hospital_df$latitude_hospital
            lat_hospital <- hospital_df$longitude_hospital
            # cbind
            locations_LongLat <- cbind(long_hospital,lat_hospital)
            # USER LOCATION (LONGLAT) INPUT
            longitude <- as.numeric(input$location_long_input)
            latitude <- as.numeric(input$location_lat_input)
            location_data <- cbind(longitude,latitude)
            location_dataframe <- as.data.frame(location_data)
            # Calculate Distance
            Dist <- distm(locations_LongLat,  # ALL points
                          location_dataframe,  # One Property
                          fun = distCosine) / 1000
            # Output = kilometers (km)
            Dist <- apply(Dist,  # variable
                          1,  # 1 = Row / 2 = Columns
                          min)
            # Find closest places/locations to Property
            min_number <- which.min(Dist) # which(Dist == min(Dist))
            min_number_value <- locations_LongLat[min_number,]
            # Add values to DataFrame (unite)
            location_dataframe$distancia_hospital <- NA
            location_dataframe[,3] <- min(Dist)
            location_dataframe[,4] <- min_number_value[1]
            names(location_dataframe)[length(names(location_dataframe))] <- "long_hospital"
            location_dataframe[,5] <- min_number_value[2]
            names(location_dataframe)[length(names(location_dataframe))] <- "lat_hospital"
            # final value
            hospital_distancia <- as.numeric(location_dataframe$distancia_hospital)
            
            
            # distancia_km_metro INPUT
            ## FIND CLOSEST METRO STATION ##
            # METRO LONGLAT DATA
            long_metro <- visual_leaflet_data$y
            lat_metro <- visual_leaflet_data$x
            # cbind
            locations_metro_LongLat <- cbind(long_metro, lat_metro)
            # USER LOCATION (LONGLAT) INPUT
            longitude <- as.numeric(input$location_long_input)
            latitude <- as.numeric(input$location_lat_input)
            location_data <- cbind(longitude,latitude)
            location_dataframe <- as.data.frame(location_data)
            # Calculate Distance
            Dist <- distm(locations_metro_LongLat,  # ALL points
                          location_dataframe,  # One Property
                          fun = distCosine) / 1000
            # Output = kilometers (km)
            Dist <- apply(Dist,  # variable
                          1,  # 1 = Row / 2 = Columns
                          min)
            # Find closest places/locations to Property
            min_number <- which.min(Dist) # which(Dist == min(Dist))
            min_number_value <- locations_metro_LongLat[min_number,]
            # Add values to DataFrame (unite)
            location_dataframe$distancia_metro <- NA
            location_dataframe[,3] <- min(Dist)
            location_dataframe[,4] <- min_number_value[1]
            names(location_dataframe)[length(names(location_dataframe))] <- "long_metro"
            location_dataframe[,5] <- min_number_value[2]
            names(location_dataframe)[length(names(location_dataframe))] <- "lat_metro"
            # final value
            metro_distancia <- as.numeric(location_dataframe$distancia_metro)
            
            # distancia INPUT
            # CASTELLANA
            LAT_IND <- c('40.466388','40.462478','40.457449','40.452853','40.448583','40.444247','40.440336','40.435412','40.430798','40.426347','40.421438','40.415924','40.411145')
            LONG_IND <- c('-3.6912797','-3.6920947','-3.6926637','-3.6931247','-3.6935427','-3.6938537','-3.6938967','-3.6911177','-3.6911717','-3.6923197','-3.6943477','-3.6962787','-3.6949057')
            LAT_IND <- as.numeric(LAT_IND)
            LONG_IND <- as.numeric(LONG_IND)
            
            castellana <- data.frame(LONG_IND, LAT_IND)
            
            # USER DataFrame
            #location_dataframe
            user_location_dataframe <- location_dataframe[,1:2]
            # Loop
            for (zz in 1:nrow(as.data.frame(user_location_dataframe))) { 
                xx = 9999999
                for (ww in 1:nrow(castellana)) {
                    yy = distm(c(user_location_dataframe$longitude[zz], user_location_dataframe$latitude[zz]),c(castellana$LONG_IND[ww],castellana$LAT_IND[ww]), fun = distHaversine)
                    if (yy < xx){
                        xx = yy # Al final del bucle tendremos la menor de las distancias
                    }
                }
                user_location_dataframe$distancia[zz] <- xx
            } # End Loop
            # Distancia Validation
            user_location_dataframe$distancia <- user_location_dataframe$distancia < 400 # TRUE los que están a menos de 400 metros de Castellana
            user_location_dataframe_logical <- user_location_dataframe[,3]
            
            # norteTRUE INPUT
            norte_input <- longitude > 40.403030
            
            # Model Data
            data <- data.frame(distancia_km_metro = metro_distancia,
                               distancia_km_hospital = hospital_distancia,
                               distance = df_filtered_distance_mean,  # distance
                               size = as.numeric(input$size_input),
                               size2 = as.numeric(input$size_input)**2,
                               size3 = as.numeric(input$size_input)**3,
                               rooms = as.numeric(input$rooms_input),
                               bathrooms = as.numeric(input$bathrooms_input),
                               status = as.numeric(status_model),
                               hasLift = as.numeric(input$hasLift_input),
                               ventas = as.numeric(df_filtered_ventas_mean),
                               poblacionextranjeros = as.numeric(df_filtered_poblacionextranjeros_mean),
                               desempleomujeres = as.numeric(df_filtered_desempleomujeres_mean),
                               floorotro = as.numeric(floor_otro_input),
                               distanciaTRUE = user_location_dataframe_logical,
                               norteTRUE = norte_input,
                               distancia = user_location_dataframe_logical,
                               norte = norte_input
            )
            # Prediction
            predicted_value <- predict(my_model, data)
            # condition
            if (predicted_value > 10) {
                # Prediction
                predicted_value <- predicted_value
            } else {
                # filter
                final_df_predicted <- final_df %>%
                    filter(district == input$district_input)
                # Mean
                final_df_predicted_mean <- mean(final_df_predicted$price)
                # Prediction
                predicted_value <- final_df_predicted_mean
            }
            # FINAL PREDICTION
            return(paste(format(round(as.numeric(predicted_value), digits = 2), big.mark = ","), "€"))
        }
    })
    
    # --------------------- #
    
    # ## DATATABLE ##
    # accuracy_values <- reactiveValues()
    # # Empty DataFrame
    # accuracy_values$df <- data.frame(RMSE = numeric(0))
    # # When Button clicked
    # accuracy_entry <- observe({
    #     if(input$goButton > 0) {
    #         # NEW
    #         newAccuracyLine <- isolate(c(input$location_lat_input))
    #         # Add new accuracy_values to DataTable
    #         isolate(accuracy_values$df[nrow(accuracy_values$df) + 1,] <- c(RMSE(predicted_value, final_df$price)))
    #     }
    # })
    # 
    # # RMSE function
    # RMSE = function(m, o){
    #     sqrt(mean((m - o)^2))
    # }
    # 
    # ## DATATABLE OUTPUT ##
    # output$table_register <- renderDataTable({
    #     # USER INPUT REGISTER TABLE
    #     datatable(accuracy_values$df,
    #               caption = htmltools::tags$caption(
    #                   style = 'caption-side: bottom; text-align: center;',
    #                   'Table 1: ', htmltools::em('Data searched by the user during current session.')
    #               ),
    #               extensions = c('FixedColumns'),
    #               escape=FALSE,
    #               rownames=FALSE,
    #               filter = list(position = 'top', clear = FALSE, plain=T),
    #               options = list(
    #                   dom = 'ifrtlp',
    #                   fixedColumns=list(leftColumns =1),
    #                   searching=T,
    #                   pageLength=10,
    #                   scrollX=TRUE,
    #                   autoWidth = T,
    #                   deferRender=F,
    #                   stateSave=TRUE
    #               ))
    # })
    
    ## MODEL ACCURACY ##
    output$model_accuracy_1 <- renderText({
        #accuracy(my_model)[2]
        format(as.numeric(accuracy(my_model)[2]), big.mark = ",")
    })
    
    # ## MODEL ACCURACY ##
    # output$model_accuracy_1 <- renderText({
    #     # Wait
    #     Sys.sleep(8)  # Seconds
    #     # RMSE test
    #     RMSE_value <- MLmetrics::RMSE(
    #         y_pred = predict(my_model, newdata = predicted_value),
    #         y_true = final_df$price
    #     )
    # })
    
    # --------------------- #
    
})
