
echo "load kibana resources"
curl -XPOST "$KIBANA_URL/api/saved_objects/_import?overwrite=true&compatibilityMode=true" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: true" --form file=@kafka_latency.ndjson