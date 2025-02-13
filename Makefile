#! make

build:
	docker build -t duckflight -f Containerfile .

prompt:
	docker run --rm -it duckflight

query:
	# start grpc flight sql server
	docker compose up -d

	# issue a ducksql query
	docker compose run -it --rm --remove-orphans duckflight ./fly.R \
		"from lineitem limit 10;"

webquery:
	docker compose run -it --rm --remove-orphans duckflight ./fly.R \
		"summarize (from read_json_auto('https://api.openalex.org/works/w2990427812', ignore_errors=true));"

clean:
	docker compose down
