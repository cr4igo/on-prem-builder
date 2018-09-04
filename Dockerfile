FROM ubuntu:17.10
# create your custom my.bldr.env file with the correct oauth information

RUN mkdir -p /app
WORKDIR /app

COPY scripts/ scripts/
COPY uninstall.sh scripts/uninstall.sh
# my.bldr.env can be overwritten, see docker-compose file
COPY my.bldr.env bldr.env

RUN chmod +x scripts/*.sh

RUN apt-get update && apt-get install -y --no-install-recommends sudo curl ca-certificates dirmngr

ENTRYPOINT ["/app/scripts/entrypoint.sh"]
