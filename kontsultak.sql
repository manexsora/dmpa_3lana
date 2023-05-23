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

CREATE TABLE action_count (
action STRING,
zenbat BIGINT
) WITH (
'connector' = 'elasticsearch-7',
'hosts' = 'http://elasticsearch:9200',
'index' = 'action_count'
);

INSERT INTO action_count 
SELECT action, COUNT(action)
FROM phone_data
group by action;

CREATE TABLE action_xyz (
action STRING,
x DOUBLE,
y DOUBLE,
z DOUBLE
) WITH (
'connector' = 'elasticsearch-7',
'hosts' = 'http://elasticsearch:9200',
'index' = 'action_xyz'
);

INSERT INTO action_xyz 
SELECT action, x,y,z
FROM phone_data;



CREATE TABLE usid_count(
usid INT,
zenbat BIGINT
) WITH (
'connector' = 'elasticsearch-7',
'hosts' = 'http://elasticsearch:9200',
'index' = 'usid_count'
);

INSERT INTO usid_count
SELECT usid, COUNT(usid)
FROM phone_data
group by usid;