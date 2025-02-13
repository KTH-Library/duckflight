#!/usr/bin/env -S Rscript --vanilla

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
	cat("Usage: fly.R 'ducksql-query'\n")
	q(status = -1)
}

query <- args[1]

con <- adbi::dbConnect(
	drv = adbi::adbi("adbcflightsql"), 
	uri = "grpc://sqlflite:31337/",
	username = "sqlflite_username",
	password = "sqlflite_password") 

on.exit(DBI::dbDisconnect(con))

# print query
con |> DBI::dbGetQuery(query) |> tibble::as_tibble() |> print(n = 100)

q(status = 0)
