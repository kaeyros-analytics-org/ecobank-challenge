# Base R Shiny image
FROM rocker/shiny

# Installation de l'openjdk et des bibliothèques système
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    libglpk40 \
    libsecret-1-0 \
    && rm -rf /var/lib/apt/lists/*

# Make a directory in the container
WORKDIR /app

# Copy your files into the container
COPY . /app

# Remove renv.lock to avoid conflict
RUN rm -f /app/renv.lock

# Install R dependencies from CRAN
RUN R -e "install.packages(c('shiny', 'shiny.fluent', 'reactable', 'sf', 'shinyWidgets', 'markdown', 'stringr', 'leaflet', 'plotly', 'shinycssloaders', 'pool', 'readxl', 'shinyjs', 'openxlsx', 'glue', 'rintrojs', 'dplyr', 'echarts4r', 'lubridate', 'quanteda', 'topicmodels', 'stopwords', 'tm', 'text', 'lsa', 'tidytext', 'jsonlite', 'LDAvis', 'SnowballC', 'textstem', 'proxy', 'rsconnect', 'fastText', 'maps'), repos='https://cran.r-project.org')"

# Install maptools from specified repository
RUN R -e "install.packages('maptools', repos='https://cloud.r-project.org/')"

# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
