FROM ghcr.io/rocker-org/tidyverse:4.4.2

RUN apt-get update -y && apt-get install -y \
	golang

RUN install2.r pak && R -e "pak::pak(c('r-dbi/adbi', 'apache/arrow-adbc/r/adbcflightsql'))"

CMD ["R"]

