# Notes

`es/transforms/kafka-latency-1m.json` assumes ECS field names.

* If you are using Jaeger-based tracing, you will need to adjust the field names in `es/transforms/kafka-latency-1m.json` accordingly.
* If you are using OTel-native-based tracing (EDOT Collector with Elasticsearch Exporter), you will need to adjust the field names in `es/transforms/kafka-latency-1m.json` accordingly.

# Setup

## Environment Variables Setup

Create a `.env` and follow the steps below to add the necessary values:

ELASTICSEARCH_USER=
ELASTICSEARCH_PASSWORD=
ELASTICSEARCH_APIKEY=
ELASTIC_APM_SERVER_SECRET=
ELASTIC_APM_SERVER_ENDPOINT=

ELASTICSEARCH_URL=
KIBANA_URL=

`export $(cat .env | xargs)`

## Elastic Setup

Load transforms and Kibana resources:

```
cd es
./es.sh
```

## Build

`docker compose build`

# Run

`docker compose up`