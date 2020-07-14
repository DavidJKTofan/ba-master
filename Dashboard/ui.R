#### UI ####
### UI LIBRARIES ###
library(shiny)
library(shinydashboard)

# ---------------------------------------------------------------------------------------- #

### VARIABLES ###

## LEAFLET HEIGHT ##
Height = 800  # pixels

# ---------------------------------------------------------------------------------------- #

### DASHBOARD PAGE ###
dashboardPage(skin = "blue",
              dashboardHeader(title = "Cuadro de mando"),
              ## DASHBOARD MENU ##
              dashboardSidebar(
                sidebarMenu(id = "tabs",
                            menuItem("Parámetros", tabName = "dashboard", icon=icon("dashboard")),
                            menuItem("Análisis", tabName = "analyse", icon=icon("chart-bar")),
                            menuItem("Idealista", tabName = "idealista", icon=icon("home")),
                            menuItem("-- About --", startExpanded = FALSE,
                                     menuSubItem("About Us", tabName = "aboutus", icon=icon("address-card")),
                                     menuSubItem("Github Source Code", href="https://github.com/DavidJKTofan/ba-master/", icon = icon("github")))
                )
              ),
              ## DASHBOARD BODY ##
              dashboardBody(
                tabItems(
                  # DASHBOARD TAB #
                  tabItem(tabName = "dashboard",
                          h1("Parámetros"),
                          # ROW
                          fluidRow(
                            # BOX
                            box(width=6, height="20%",title="Seleccionar datos.", solidHeader = T, status = "primary",
                                # PROPERTY LOCATION INPUT
                                fluidRow(
                                  column(6,
                                         # LATITUDE INPUT
                                         numericInput("location_lat_input", label = "Latitude", value = 40.4063, min = 36, max = 48, step = 0.001)),
                                  column(6,
                                         # LONGITUDE INPUT
                                         numericInput("location_long_input", label = "Longitude", value = -3.7373, min = -7, max = 1, step = 0.001))
                                ),
                                helpText("Latitud y Longitud de la propiedad que quieres predecir. Variable: Lat-Long"),
                                fluidRow(
                                  column(6,
                                         # SIZE INPUT
                                         numericInput("size_input", label = "Tamaño", value = 62, min = 1, max = 500),
                                         helpText("Tamaño de la propiedad en metros cuadrados. Variable: size.")),
                                  column(6,
                                         # HASLIFT INPUT
                                         selectInput("hasLift_input", 
                                                     "Ascensor",
                                                     choices = c("Si" = 1,  # TRUE
                                                                 "No" = 0), # FALSE
                                                     selected = 0
                                                     ),  
                                         helpText("Si tiene ascensor el edificio de la propiedad o no. Variable: hasLift."))
                                ),
                                fluidRow(
                                  column(6,
                                         # ROOMS INPUT
                                         numericInput("rooms_input", label = "Habitaciones", value = 2, min = 1, max = 7),
                                         helpText("Número de habitaciones. Variable: rooms.")),
                                  column(6,
                                         # BATHROOMS INPUT
                                         numericInput("bathrooms_input", label = "Baños", value = 1, min = 1, max = 3),
                                         helpText("Número de baños. Variable: bathrooms"))
                                ),
                                fluidRow(
                                  column(6,
                                         # STATUS INPUT
                                         selectInput("status_input", 
                                                     "Estado",
                                                     choices = c("Good" = "good",
                                                                 "New Development " = "newdevelopment",
                                                                 "Renew" = "renew")),
                                         helpText("Estado de la propiedad. Variable: status.")),
                                  column(6,
                                         selectInput("floor_input",
                                                     "Piso",
                                                     choices = c("Otro" = "otro",
                                                                "Primera" = "primera",
                                                                "Mitad" = "mitad",
                                                                "Alto" = "alto"),
                                                     #choices = final_df_COD_POSTAL$floor.x,
                                                     #selected = unique(as.character(final_df_COD_POSTAL$floor.x)),
                                         ),
                                         helpText("Piso de la propiedad. Variable: floor."))
                                ),
                                fluidRow(
                                  column(6,
                                         # POSTAL CODE INPUT
                                         selectInput("postal_code_input", 
                                                     "Código Postal",
                                                     choices = unique(cod_postal_analysis$COD_POSTAL),
                                                     selected = 28011
                                                     ),
                                         # selectInput("postal_code_input", 
                                         #             "Código Postal",
                                         #             choices = cod_postal_analysis$COD_POSTAL),
                                         helpText("Código postal de la propiedad. Variable: COD_POSTAL.")),
                                  column(6,
                                         # DISTRICT INPUT
                                         selectInput("district_input", 
                                                     "Distrito",
                                                     choices = unique(final_df$district),
                                                     selected = "Latina",
                                                     ),
                                         helpText("Distrito de la propiedad. Variable: district."))
                                ),
                                # # OSM INPUT
                                # selectInput("osm_input", 
                                #             "Edificios relevantes",
                                #             choices = c("Hospital" = "hospital",
                                #                         "Colegio" = "school")),
                                # helpText("Edificios que son relevantes para el usuario. Variable: OSM."),
                                br(), # Space
                                #submitButton("Predecir", icon=icon("chart-bar")),  # connected to observe({}) in server
                                actionButton("goButton", "Predecir", icon=icon("chart-bar"))
                            ),
                            # BOX
                            box(width=6, height="20%",title = "Instrucciones.", solidHeader = T, status = "info",
                                p("Elige los parámetros de la propiedad que búscas en las opciones de la izquierda."),
                                p("El texto en grís debajo de cada parámetro te ayuda a entender más sobre las variables.")
                            ),
                            # BOX
                            box(width=6, height="20%",title = "Datos seleccionados.", solidHeader = T, status = "info",
                                p("Los siguientes parámetros están seleccionados:"),
                                # SIZE OUTPUT
                                h4(htmlOutput("size_output")),
                                # ROOMS OUTPUT
                                h4(htmlOutput("rooms_output")),
                                # BATHROOMS OUTPUT
                                h4(htmlOutput("bathrooms_output")),
                                # HASLIFT OUTPUT
                                h4(htmlOutput("hasLift_output")),
                                # STATUS OUTPUT
                                h4(htmlOutput("status_output")),
                                # POSTAL CODE OUTPUT
                                h4(htmlOutput("postal_code_output"))
                            )
                          )
                  ),
                  # DASHBOARD TAB #
                  tabItem(tabName = "analyse",
                          h2("Datos generales."),
                          br(), # Space
                          # ROW
                          fluidRow(
                            # POSTAL CODE INPUT
                            valueBoxOutput("Info1") %>% withSpinner(color="#367fa9"),
                            # SIZE INPUT
                            valueBoxOutput("Info2"),
                            # ROOMS INPUT
                            valueBoxOutput("Info3")
                          ),
                          h2("Análisis."),
                          # ROW
                          fluidRow(
                            # TABBOX
                            tabBox(title = "", width=12,
                                   # TABPANEL
                                   tabPanel(title=tagList(shiny::icon("line-chart"), "Análisis"),
                                            helpText("Análisis exploratorio."),
                                            # h3("Pronóstico del modelo."),
                                            # h5(strong(textOutput("model_result") %>% withSpinner(color="#367fa9"))),
                                            # br(), # Space
                                            # h3("RMSE."),
                                            # textOutput("model_accuracy_1"),
                                            #
                                            fluidRow(
                                              column(6,
                                                     h3("Pronóstico del modelo."),
                                                     h4(strong(textOutput("model_result") %>% withSpinner(color="#367fa9"))),
                                                     br(), # Space
                                                     ),
                                              column(6,
                                                     h3("RMSE."),
                                                     h4(textOutput("model_accuracy_1") %>% withSpinner(color="#367fa9")),
                                                     helpText("Root Mean Square Error (RMSE) del modelo.")
                                                     )
                                            ),
                                   ),
                                   # TABPANEL
                                   tabPanel(title=tagList(shiny::icon("map-marked-alt"), "Mapa"),
                                            helpText("Mapa interactivo."),
                                            # LEAFLET MAP
                                            leafletOutput("leaflet_map_distance_graph", height = Height) %>% withSpinner(color="#367fa9")
                                   ),
                                   # TABPANEL
                                   tabPanel(title=tagList(shiny::icon("table"), "Registro"),
                                            helpText("Registro de las predicciones realizadas durante la sesión."),
                                            # DATATABLE OUTPUT
                                            DT::dataTableOutput("table_register") %>% withSpinner(color="#367fa9"),
                                   )
                            ) #tabBox
                          )
                  ),
                  # DASHBOARD TAB #
                  tabItem(tabName = "idealista",
                          h2("Visión general."),
                          # ROW
                          fluidRow(
                            # INFO BOX 1
                            valueBoxOutput("info_box_1")  %>% withSpinner(color="#367fa9"),
                            # INFO BOX 2
                            valueBoxOutput("info_box_2"),
                            # INFO BOX 3
                            valueBoxOutput("info_box_3")
                          ),
                          h2("Análisis."),
                          # ROW
                          fluidRow(
                            # TABBOX
                            tabBox(title = "", width=12,
                                   # TABPANEL
                                   tabPanel(title=tagList(shiny::icon("line-chart"), "Análisis"),
                                            h3("Análisis exploratorio."),
                                            p("Datos filtrados por Madrid, tipo de propiedad 'flat', menos de 500 m2 en tamaño, y menos de 500.000€ en precio."),
                                            br(), # Space
                                            fluidRow(
                                              column(6,
                                                     helpText("Número y estado de las propiedades en los diferentes distritos de Madrid."),
                                                     plotOutput("property_factor", height = "600px") %>% withSpinner(color="#367fa9")
                                              ),
                                              column(6,
                                                     helpText("Distribución de las propiedades que tienen ascensor."),
                                                     plotOutput("hasLift_graph", height = "600px") %>% withSpinner(color="#367fa9")
                                              )
                                            ), # fluidRow
                                            hr(), # Line Space
                                            tags$style(HTML("hr {border-top: 1px solid #DCDCDC;}")),
                                            fluidRow(
                                              column(6,
                                                     helpText("Relación entre precio y tamaño, así como el piso."),
                                                     plotOutput("price_size_floor_graph", height = "600px") %>% withSpinner(color="#367fa9")
                                              ),
                                              column(6,
                                                     helpText("Distribución de los pisos y el estado de la propiedad."),
                                                     plotOutput("floor_status_graph", height = "600px") %>% withSpinner(color="#367fa9")
                                              )
                                            ), # fluidRow
                                            br() # Space
                                   ),
                                   tabPanel(title=tagList(shiny::icon("project-diagram"), "Correlación"),
                                            h3("Correlación."),
                                            helpText("Correlación entre las diferentes variables."),
                                            # CORRELATION OUTPUT
                                            plotOutput("correlation_graph", height = "600px") %>% withSpinner(color="#367fa9")
                                   ),
                                   # TABPANEL
                                   tabPanel(title=tagList(shiny::icon("database"), "Datos"),
                                            helpText("Registros descargados desde la API de Idealista."),
                                            # DATATABLE OUTPUT
                                            DT::dataTableOutput("idealista_table") %>% withSpinner(color="#367fa9")
                                   )
                            ) #tabBox
                          )
                  ),
                  # DASHBOARD TAB #
                  tabItem(tabName = "aboutus",
                          #h2("About Us"),
                          h2("Sobre nosotros."),
                          h4("Análisis predictivo del precio del m2 de vivienda en Madrid."),
                          br(),  # Space
                          # ROW
                          fluidRow(
                            # BOX
                            box(width=6, height="20%",title = "Equipo.", solidHeader = T, status = "primary",
                                p("Nuestro equipo está compuesto por:"),
                                tags$ul(
                                  tags$li("Andrés David DELGADO MOSQUERA"), 
                                  tags$li("Iván Carlos BARRIO HERREROS"), 
                                  tags$li("David Jo Konstantin TOFAN")
                                )
                            ),
                            # BOX
                            box(width=6, height="20%",title = "Objetivos.", solidHeader = T, status = "info",
                                p("Conforme a la Hipótesis planteada nos hemos planteado los siguientes objetivos en este trabajo de fin de máster:"),
                                tags$ul(
                                  tags$li("Encontrar aquellas variables que generen mayor influencia en el precio del m2 de la ciudad de Madrid."), 
                                  tags$li("Definir si el precio del m2 de Madrid presenta dependencia geoespacial con los vecinos.")
                                )
                            )),
                          # ROW
                          fluidRow(
                            # BOX
                            box(width=12, height="20%",title = "Insights obtenidos del estado del Arte.", solidHeader = T, status = "info",
                                p("Los siguientes insights obtenidos son hipótesis que se deberán evaluar en los siguientes análisis estadísticos: "),
                                tags$ul(
                                  tags$li("El precio del m2 en Madrid ha se ha incrementado en 0,3%  el último año."), 
                                  tags$li("Existe una diferencia de hasta un 300% en el valor del m2 de un distrito a otro ( Salamanca vs. Villaverde)."), 
                                  tags$li("La fluctuación del crecimiento del m2 por distrito irá desde un -24% en Arganzuela hasta un 23% en Vicálvaro para el año 2021. "),
                                  tags$li("La venta de viviendas en Madrid ha disminuido en un 7,64% de enero del 2019 a enero del 2020."),
                                  tags$li("Existe una diferencia de hasta el 450% en la transaccionalidad de viviendas de un distrito a otro (Centro vs. Barajas)."),
                                  tags$li("Existe una relación en la cantidad de población de un distrito vs. el valor del m2. A mayor población menor valor del m2 y viceversa."),
                                  tags$li("Existe una correlación entre la variación del PIB con el crecimiento anual del valor del m2 en Madrid de los 10 últimos años."),
                                  tags$li("Entre las principales metodologías utilizadas en Madrid para predecir el precio del m2 son el PER y el método de comparación."),
                                  tags$li("El promedio de descuento ofrecido al comercializar una vivienda en Madrid es del 18,9%."),
                                  tags$li("El método de comparación es el más utilizado por los principales players del mercado, tropicalizando así las variables a utilizar."),
                                  tags$li("Vemos que las variables que tienen una mayor correlación sobre el valor del m2 varían de una población a otra sin embargo la que se mantiene es el tamaño de su superficie.")
                                )
                            )
                          )
                          
                  ) # TAB
                )
                
              )
)
