curl -XDELETE "$ELASTICSEARCH_URL/_transform/kafka-trace-stats-1m" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json"
curl -XDELETE "$ELASTICSEARCH_URL/kafka-trace-stats-1m" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY"

curl -XPUT "$ELASTICSEARCH_URL/_transform/kafka-trace-stats-1m" -H "Authorization: ApiKey $ELASTICSEARCH_APIKEY" -H "kbn-xsrf: reporting" -H "Content-Type: application/json" -d @kafka.json

