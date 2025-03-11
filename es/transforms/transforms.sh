curl -XPOST "$ELASTICSEARCH_URL/_transform/kafka-latency-1m/_stop" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
curl -XDELETE "$ELASTICSEARCH_URL/_transform/kafka-latency-1m" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
curl -XDELETE "$ELASTICSEARCH_URL/kafka-latency-1m" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY"

curl -XPUT "$ELASTICSEARCH_URL/_transform/kafka-latency-1m" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json" -d @kafka-latency-1m.json
curl -XPOST "$ELASTICSEARCH_URL/_transform/kafka-latency-1m/_start" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
