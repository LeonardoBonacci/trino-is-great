# trino-is-great

https://trino.io/docs/current/installation/containers.html
https://trino.io/docs/current/connector/kafka-tutorial.html

```
./bin/kafka-topics --bootstrap-server=localhost:9092 --list

./bin/kafka-console-producer --bootstrap-server localhost:9092 --topic foo

./bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic foo --from-beginning
```

```
/kafka-tpch load --brokers localhost:9092 --prefix tpch. --tpch-type tiny
```