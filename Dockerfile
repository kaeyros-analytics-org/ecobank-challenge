# Base R Shiny image
FROM rocker/shiny:latest

# Installation de l'openjdk
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Installation de libglpk40 et libsecret-1-0
RUN apt-get update && apt-get install -y libglpk40 libsecret-1-0

# Installation des dépendances système pour les packages R
RUN apt-get update && apt-get install -y libudunits2-dev libproj-dev libgdal-dev libgeos-dev libgsl-dev

# Make a directory in the container
WORKDIR /app

# Copy your files into the container
COPY . /app

# Installation de renv
RUN R -e "install.packages('renv')"

# Installation des packages R à partir du fichier renv.lock
RUN R -e "renv::snapshot()"

# Installation du package maptools depuis R-Forge
RUN R -e "install.packages('shiny')"

# Installation du package maptools depuis R-Forge
RUN R -e "install.packages('maptools', repos='http://R-Forge.R-project.org')"

# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
