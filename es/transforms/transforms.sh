curl -XPOST "$ELASTICSEARCH_URL/_transform/kafka-latency/_stop" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
curl -XDELETE "$ELASTICSEARCH_URL/_transform/kafka-latency" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
curl -XDELETE "$ELASTICSEARCH_URL/kafka-latency" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY"

curl -XPUT "$ELASTICSEARCH_URL/_transform/kafka-latency" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json" -d @kafka-latency.json
curl -XPOST "$ELASTICSEARCH_URL/_transform/kafka-latency/_start" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
