# trino-is-great

https://trino.io/docs/current/installation/containers.html
https://trino.io/docs/current/connector/kafka-tutorial.html

```
./bin/kafka-topics --bootstrap-server=localhost:9092 --list

./bin/kafka-console-producer --bootstrap-server localhost:9092 --topic foo

./bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic foo --from-beginning
```

```
./bin/kafka-console-producer --bootstrap-server localhost:9092 --topic trans.transfers --property "parse.key=true" --property "key.separator=:"
bahamas: {"transferId": "i-am-random", "poolId": "bahamas", "from":"foo", "to":"bar", "amount":10.10, "when":1674179837 }
bahamas: {"transferId": "i-am-random", "poolId": "bahamas", "from":"bar", "to":"goo", "amount":5.10 , "when":1674189838 }

./bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic trans.transfers --property print.key=true --property key.separator=" >" --from-beginning
```

```
WITH
  debit AS (SELECT sum(amount) AS SMILE FROM transfers where to = 'bar'),
  credit AS (SELECT sum(amount) AS CRY FROM transfers where _from = 'bar')
SELECT coalesce(SMILE, 0) - coalesce(CRY, 0) AS balance FROM debit, credit;
```

```
trino:trans> WITH
         ->   debit AS (SELECT sum(amount) AS SMILE FROM transfers where to = 'bar'),
         ->   credit AS (SELECT sum(amount) AS CRY FROM transfers where _from = 'bar')
         -> SELECT coalesce(SMILE, 0) - coalesce(CRY, 0) AS balance FROM debit, credit;
 balance
---------
     5.0
(1 row)
```

```
SHOW CATALOGS;
SHOW SCHEMAS IN mysql;
USE heroes;
SHOW TABLES;

CREATE TABLE IF NOT EXISTS bla (
  blakey bigint,
  blaname varchar
)
COMMENT 'A table to join.';

INSERT INTO bla VALUES (1, 'foo');

select mysql.heroes.bla.* from mysql.heroes.bla;
select kafka.trans.transfers.* from kafka.trans.transfers;

select bla.*, transfers.* from mysql.heroes.bla as bla join kafka.trans.transfers as transfers on transfers._from = bla.blaname;
```

```
trino> select bla.*, transfers.* from mysql.heroes.bla as bla join kafka.trans.transfers as transfers on transfers._from = bla.blaname;
 blakey | blaname | transferid  | poolid  | _from | to  | amount |    when
--------+---------+-------------+---------+-------+-----+--------+------------
      1 | foo     | i-am-random | bahamas | foo   | bar |   10.1 |       NULL
      1 | foo     | i-am-random | bahamas | foo   | bar |   10.1 | 1674179837
(2 rows)

Query 20230120_025955_00038_hdrcg, FINISHED, 1 node
Splits: 11 total, 11 done (100.00%)
0.20 [6 rows, 544B] [29 rows/s, 2.63KB/s]
```

https://www.youtube.com/watch?v=lA7lSo-r7i8
