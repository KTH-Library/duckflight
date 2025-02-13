# duckflight

Using R to interact with a remote duckdb-powered service there are for example these services which allow connections over grpc using ADBC:

- Voltron "sqlflite"
- quackpy server

In R one then needs for example the "adbi" package and the "adbcflightsql" driver.

This is unlike running duckdb locally where packages like 'duckplyr' and 'duckdb' are commonly used.

See the `fly.R` script for an example which makes a ADBC Flight SQL connection using grpc to connect to a remote server with duckdb.

The script can be used to query the service using a ducksql statement.


## Usage through Makefile

The `Containerfile` provides an environment with the required deps installed. 

It can be built into an image "duckflight" using `make build`.

The `compose.yaml` provides the above two ADBC Flight SQL capable services along with a "duckflight" command.

Services can be started with `docker compose up -d`.

The `make query` target queries the `sqlflite` service using a ducksql query like 'from lineitem limit 5;'

The `make webquery` uses a duckdb extension (json) to read and return data from a web api.
