# Base R Shiny image
FROM rocker/shiny

# Installation de l'openjdk
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Exécuter la commande find pour rechercher libjvm.so et copier le chemin dans une variable d'environnement
RUN LIBJVM_PATH=$(find / -name libjvm.so 2>/dev/null) && echo "export LIBJVM_PATH=$LIBJVM_PATH" >> /etc/profile

# Copier la bibliothèque libjvm.so dans le conteneur en utilisant le chemin capturé
COPY $LIBJVM_PATH /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/

# Définir la variable d'environnement LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH

# Make a directory in the container
WORKDIR /app

# Copy your files into the container
COPY . /app

# Install libglpk40 and libsecret-1-0
RUN apt-get update && apt-get install -y libglpk40 libsecret-1-0

# Install R dependencies
RUN R -e "install.packages('shiny', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shiny.fluent', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('reactable', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('sf', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shinyWidgets', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('markdown', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('stringr', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('leaflet', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('plotly', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shinycssloaders', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('pool', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('readxl', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('shinyjs', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('openxlsx', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('glue', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('rintrojs', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('echarts4r', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('lubridate', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('quanteda', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('topicmodels', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('stopwords', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('tm', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('text', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('lsa', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('tidytext', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('jsonlite', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('LDAvis', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('SnowballC', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('textstem', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('proxy', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('rsconnect', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('fastText', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('maps', repos='https://cloud.r-project.org/')"

# Expose the application port
EXPOSE 8180

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8180)"]
