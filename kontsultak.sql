CREATE TABLE phone_data (
usid INT,
action STRING,
ts BIGINT,
x DOUBLE,
y DOUBLE,
z DOUBLE
) WITH (
'connector' = 'kafka', 
'topic' = 'smart', 
'scan.startup.mode' = 'earliest-offset',
'properties.bootstrap.servers' = '172.20.0.11:9092',
'format' = 'json' 
);

CREATE TABLE ts_data (
ts BIGINT,
x DOUBLE,
y DOUBLE,
z DOUBLE
) WITH (
'connector' = 'elasticsearch-7', 
'hosts' = 'http://elasticsearch:9200',
'index' = 'ts_data' 
);

INSERT INTO ts_data
SELECT ts,x,y,z
FROM phone_data;
