#!/usr/bin/env -S Rscript --vanilla

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
	cat("Usage: ./quack.R grpc://user:pass@some.server:port/ 'ducksql-query'\n\n")
	args <- c("grpc://user:persistence@localhost:8815/", "select 42;")
	message("Using default connectionstring:\n", args[1], "\n\n")
	message("Using default ducksql query:\n", args[2], "\n\n")
}

u <- args[1] |> httr2::url_parse()

#adbi_uri <- with(u, paste0(scheme, "://", username, ":", password, "@", hostname, ":", port, path))
adbi_uri <- with(u, paste0(scheme, "://", hostname, ":", port, path))

b64creds <- 
	charToRaw(paste0(u$username, ":", u$password)) |> 
	base64enc::base64encode()

header <- paste("authorization", b64creds)

sql <- args[2]

con <- adbi::dbConnect(
	drv = adbi::adbi("adbcflightsql"), 
	uri = adbi_uri,
	# see https://arrow.apache.org/adbc/current/driver/flight_sql.html
	#adbc.flight.sql.rpc.call_header.authorization = b64creds
	adbc.flight.sql.authorization_header = header
	) |> suppressMessages()

on.exit(DBI::dbDisconnect(con))


# print and exit
con |> DBI::dbGetQuery(sql) |> tibble::as_tibble() |> print(n = 100)

q(status = 0)
