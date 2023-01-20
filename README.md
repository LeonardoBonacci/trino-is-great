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

TODO add 'when' field

```
./bin/kafka-console-producer --bootstrap-server localhost:9092 --topic tpch.transfers --property "parse.key=true" --property "key.separator=:"
bahamas: {"transferId": "i-am-random", "poolId": "bahamas", "from":"foo", "to":"bar", "amount":10.10}
bahamas: {"transferId": "i-am-random", "poolId": "bahamas", "from":"bar", "to":"goo", "amount":5.10}

./bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic tpch.transfers --property print.key=true --property key.separator=" >" --from-beginning


SELECT sum(cast(json_extract_scalar(_message, '$.amount') AS double)) FROM transfers;
```

```
WITH
  debit AS (SELECT sum(amount) AS SMILE FROM transfers where to = 'bar'),
  credit AS (SELECT sum(amount) AS CRY FROM transfers where _from = 'bar')
SELECT coalesce(SMILE, 0) - coalesce(CRY, 0) AS balance FROM debit, credit;
```

```
trino:tpch> WITH
         ->   debit AS (SELECT sum(amount) AS SMILE FROM transfers where to = 'bar'),
         ->   credit AS (SELECT sum(amount) AS CRY FROM transfers where _from = 'bar')
         -> SELECT coalesce(SMILE, 0) - coalesce(CRY, 0) AS balance FROM debit, credit;
 balance
---------
     5.0
(1 row)
```