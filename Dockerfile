# Utilisation d'une image plus légère de base
FROM rocker/r-ver:4.0.5

# Installation de l'openjdk et des bibliothèques système en une seule commande
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    libglpk40 \
    libsecret-1-0 \
    && rm -rf /var/lib/apt/lists/*

# Création d'un répertoire de travail
WORKDIR /app

# Copie des fichiers dans le conteneur
COPY . /app

# Suppression de renv.lock pour éviter les conflits
RUN rm -f /app/renv.lock

# Installation des packages R en une seule étape
RUN R -e "install.packages(c('shiny', 'shiny.fluent', 'reactable', 'shinyWidgets', 'markdown', 'stringr', 'leaflet', 'plotly', 'shinycssloaders', 'pool', 'readxl', 'shinyjs', 'openxlsx', 'glue', 'rintrojs', 'dplyr', 'echarts4r', 'lubridate', 'quanteda', 'topicmodels', 'stopwords', 'tm', 'text', 'lsa', 'tidytext', 'jsonlite', 'LDAvis', 'SnowballC', 'textstem', 'proxy', 'rsconnect', 'fastText', 'maps'), repos='https://cloud.r-project.org/')"

# Installation du package sf
RUN R -e "install.packages('sf', repos='https://cloud.r-project.org/')"

# Exposer le port de l'application
EXPOSE 8180

# Exécuter l'application Shiny
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
