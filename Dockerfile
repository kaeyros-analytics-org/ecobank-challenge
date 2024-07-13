# Use the official R base image
FROM r-base:latest

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libxt-dev \
    libcairo2-dev \
    libssh2-1-dev \
    libsodium-dev \
    libgit2-dev \
    libgit2-ssh-1-dev

# Install R packages
RUN R -e "install.packages(c('shiny', 'shiny.fluent', 'reactable', 'sf', 'shinyWidgets', 'markdown', 'stringr', 'leaflet', 'plotly', 'shinycssloaders', 'pool', 'readxl', 'shinyjs', 'openxlsx', 'glue', 'rintrojs', 'dplyr', 'echarts4r', 'lubridate', 'quanteda', 'topicmodels', 'stopwords', 'tm', 'text', 'lsa', 'stringr', 'tidytext', 'jsonlite', 'LDAvis', 'SnowballC', 'textstem', 'proxy', 'rsconnect', 'fastText', 'maps', 'maptools'), repos='https://cloud.r-project.org/')"

# Copy the Shiny app files to the container
COPY . /app

# Set the port to expose
EXPOSE 3838

# Run the Shiny app
CMD ["R", "-e", "shiny::runApp(port=8180, launch.browser=FALSE)"]
