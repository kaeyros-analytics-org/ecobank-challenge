# Base R Shiny image
FROM rocker/shiny:latest

# Installation de l'openjdk
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Installation de libglpk40 et libsecret-1-0
RUN apt-get update && apt-get install -y libglpk40 libsecret-1-0

# Installation des dépendances système pour les packages R
RUN apt-get update && apt-get install -y libudunits2-dev libproj-dev libgdal-dev libgeos-dev libgsl-dev

# Installation des packages R spécifiés
RUN R -e "install.packages(c('rJava', 'shiny', 'shiny.fluent', 'reactable', 'sf', 'shinyWidgets', 'markdown', 'stringr', 'leaflet', 'plotly', 'shinycssloaders', 'pool', 'readxl', 'shinyjs', 'openxlsx', 'glue', 'rintrojs', 'dplyr', 'echarts4r', 'lubridate', 'quanteda', 'topicmodels', 'stopwords', 'tm', 'text', 'lsa', 'tidytext', 'jsonlite', 'LDAvis', 'SnowballC', 'textstem', 'proxy', 'rsconnect', 'fastText', 'maps'))"

# Installation du package maptools depuis R-Forge
RUN R -e "install.packages('maptools', repos='http://R-Forge.R-project.org')"

# Make a directory in the container
WORKDIR /app

# Copy your files into the container
COPY . /app

# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
