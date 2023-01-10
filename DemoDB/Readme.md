# Install PostgreSQL 
#### Manjaro
```
sudo pacman -S postgresql postgis
```
```
sudo su postgres -l
```
```
sudo -u postgres -i
```
```
initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data/'
```
```exit```
```
sudo systemctl status postgresql
```
```
sudo systemctl start postgresql
```
```
q 

# Create PostgreSQl_DB

_____

```
CREATE TABLE air
( air_code char( 3 ) NOT NULL,
model text Not NULL,
range integer NOT NULL,
CHECK ( range > 0 ),
PRIMARY KEY ( air_code )
);
```

### View Table.

```
\d air
```

#### View all table.

```
\d
```

### Delete Table.

`DROP TABLE <name_table>;`

### Insert string on the Table.

```
INSERT INTO <name_table> (air_code model, range)
VALUES ( 'SU9', 'SUkhoi SuperJet-100', 3000)
```

### Access string in table/ Fetching rows from a table.

```
SELECT <attribute_name>, <attribute_name>, ...
FROM <Table_name>;
```

ALL:

```
SELECT * FROM <Table_name>
```

### Sorting rows in a table.

```
SELECT model, air_code, range
FROM air
ORDER By model;
```

```
SELECT model, air_code, range
FROM air
WHERE range >= 4000 AND range <+ 6000;
```

### Update rows in a table.

```
UPDATE air SET range = 3500
WHERE air_code = 'SU9';
```

### Delete one row from the table.

```
DELETE FROM air WHERE air_code = 'CN1';
```

### Delete conditionally.

```
DELETE FROM air WHERE range > 10000 OR range < 3000;
```

### Delete all rows from the table.

```
DELETE FROM air;
```

### History commands.

`
\s <file_name_history>
`

### Create second table.

```
CREATE TABLE my_seats
( air_code char(3) NOT NULL,
seat_no varchar(4) NOT NULL,
fare_conditions varchar(10) NOT NULL,
CHECK ( fare_conditions IN ('Economy', 'Comfort', 'Business') ),
PRIMARY KEY (air_code, seat_no),
FOREIGN KEY (air_code)
REFERENCES air (air_code)
    ON DELETE CASCADE
);
```

### Fill in the table my_seats.

```
INSERT INTO my_seats
VALUES ('SU9', '1A', 'Business'),
       ('763', '10B', 'Business'),
       ('763', '15C', 'Economy'),
       ('319', '18E', 'Comfort');
```
### Row grouping.
Suppose we need to get information about the quantity
cabin seats for all types of aircraft.<br/>
_(Предположим, что нам нужно получить информацию о количестве
мест в салонах для всех типов самолетов.)_
#### Irrational decision.
```
SELECT count (*) FROM my_seats WHERE air_code = 'SU9'
SELECT count (*) FROM my_seats WHERE air_code = '319'
```
#### Rational Decision and sorting.
```
SELECT air_code, count(*) FROM my_seats
GROUP BY air_code
ORDER BY count(*);
```
#### Grouping by two attributes.
```
SELECT aircraft_code, fare_conditions, count(*) FROM seats
GROUP BY aircraft_code, fare_conditions
ORDER BY aircraft_code, fare_conditions;
```



