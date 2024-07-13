# Base R Shiny image
FROM rocker/shiny

# Installation de l'openjdk


# Installation de libglpk40 et libsecret-1-0
RUN apt-get update && apt-get install -y libglpk40 libsecret-1-0

# Installation des dépendances système pour les packages R
RUN apt-get update && apt-get install -y libudunits2-dev libproj-dev libgdal-dev libgeos-dev libgsl-dev

# Make a directory in the container
WORKDIR /app

# Copy your files into the container
COPY . /app

# Crée un script R pour installer les packages
RUN echo "install.packages(c('rJava', 'shiny', 'shiny.fluent', 'reactable', 'sf', 'shinyWidgets', 'markdown', 'stringr', 'leaflet', 'plotly', 'DT', 'shinycssloaders', 'pool', 'readxl', 'shinyjs', 'openxlsx', 'glue', 'rintrojs', 'dplyr', 'echarts4r', 'lubridate', 'quanteda', 'topicmodels', 'stopwords', 'ldatuning', 'tm', 'text', 'lsa', 'tidytext', 'jsonlite', 'LDAvis', 'SnowballC', 'textstem', 'proxy', 'rsconnect', 'fastText', 'maps', 'maptools'))" > /app/install_packages.R

# Exécute le script pour installer les packages
RUN Rscript /app/install_packages.R

# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
