INSERT INTO air (air_code, model, range)

VALUES ('SU9', 'Sukhoi SuoerJet- 100', 3000);

insert into air(air_code, model, range)
VALUES ('773', 'Boeing 777 -300', 11100),
       ('763', 'Boeing 767-300', 7900),
       ('733', 'Boeing 737-300', 4200),
       ('320', 'Airbus A320-200', 5700),
       ('321', 'Airbus A321-200', 5600),
       ('319', 'Airbus A319-100', 6700),
       ('CN1', 'Cessna 208 Caravan', 1200),
       ('CR2', 'Bombardier CRJ-200', 2700);
SELECT model, air_code, range
FROM air
ORDER BY model;
SELECT model, air_code, range
FROM air
WHERE range >= 4000
  AND range <= 6000;

UPDATE air
SET range = 3500
WHERE air_code = 'SU9';

DELETE
FROM air
WHERE air_code = 'CN1';
DELETE
FROM air
WHERE range > 10000
   OR range < 3000;

CREATE TABLE my_seats
(
    air_code        char(3)     NOT NULL,
    seat_no         varchar(4)  NOT NULL,
    fare_conditions varchar(10) NOT NULL,
    CHECK ( fare_conditions IN ('Economy', 'Comfort', 'Business') ),
    PRIMARY KEY (air_code, seat_no),
    FOREIGN KEY (air_code)
        REFERENCES air (air_code)
        ON DELETE CASCADE
);

INSERT INTO my_seats
VALUES ('SU9', '1A', 'Business'),
       ('763', '10B', 'Business');

INSERT INTO my_seats
VALUES ('763', '15C', 'Economy'),
       ('319', '18E', 'Comfort');

SELECT air_code, count(*)
FROM my_seats
GROUP BY air_code;

SELECT air_code, count(*)
FROM my_seats
GROUP BY air_code
ORDER BY count(*);

SELECT aircraft_code, count(*)
FROM seats
GROUP BY aircraft_code
ORDER BY count(*);

SELECT aircraft_code, fare_conditions, count(*)
FROM seats
GROUP BY aircraft_code, fare_conditions
ORDER BY aircraft_code, fare_conditions;

SELECT 0.1::real * 10 = 1.0::real;

SELECT current_date;

select 'sep 12, 2022'::date;

SELECT to_char(current_date, 'dd-mm-yyyy');

SELECT current_time;

SELECT '02:22:30'::time;

SELECT 'pm 11:09:34'::time;

SELECT timestamp with time zone '2016-09-22 22:45:32';

SELECT timestamptz '2000-08-01 03:04:44';

SELECT current_timestamp;

SELECT '1 year 2 months ago'::interval;

SELECT 'P0001-02-03T04:05:06'::interval;

SELECT ('2016-06-16'::timestamp - '2016-01-01'::timestamp)::interval;

SELECT (date_trunc('hour', current_timestamp));

SELECT extract('mon' FROM timestamp '1999-11-27 12:34.123456');

CREATE TABLE database
(
    is_open_source boolean,
    dbms_name      text
);

INSERT INTO database
VALUES (TRUE, 'PostgreSQL');
INSERT INTO database
VALUES ('f', 'Oracle');
INSERT INTO database
VALUES ('yes', 'MySQL');
INSERT INTO database
VALUES ('n', 'MS SQL Server');

SELECT *
FROM database;

CREATE TABLE pilots
(
    pilot_name text,
    schedule   integer[]
);

INSERT INTO pilots
VALUES ('Ivan', '{1,3,5,6,7}' :: integer[]),
       ('Petr', '{1,2,5,7}' :: integer[]),
       ('Pavel', '{1, 5}'::integer[]),
       ('Boris', '{3,5,6}':: integer[]);

SELECT *
FROM pilots;

UPDATE pilots
SET schedule = schedule || 7
WHERE pilot_name = 'Boris';

UPDATE pilots
SET schedule = array_append(schedule, 1)
where pilot_name = 'Pavel';

SELECT *
FROM pilots;

UPDATE pilots
SET schedule = array_prepend(1, schedule)
where pilot_name = 'Pavel';

UPDATE pilots
set schedule = array_remove(schedule, 2)
WHERE pilot_name = 'Ivan';

UPDATE pilots
SET schedule[1] = 2,
    schedule[2] = 3
where pilot_name = 'Petr';

UPDATE pilots
SET schedule[1:2] = ARRAY [2,3]
where pilot_name = 'Petr';

SELECT *
FROM pilots
WHERE array_position(schedule, 3) IS NOT NULL;

SELECT *
FROM pilots
WHERE schedule @> '{1,7}'::integer[];

SELECT *
FROM pilots
WHERE schedule && ARRAY [2,5];

SELECT *
FROM pilots
WHERE NOT schedule && ARRAY [2, 5];

SELECT unnest(schedule) AS days_of_week
FROM pilots
WHERE pilot_name = 'Ivan';

CREATE TABLE pilot_hobbies
(
    pilot_name text,
    hobbies    jsonb
);

INSERT INTO pilot_hobbies
VALUES ('Ivan',
        '{
                  "sports": [
                    "soccer",
                    "swimming"
                  ],
                  "home_lib": true,
                  "trips": 3
                }'::jsonb),
       ('Petr',
        '{
          "sports": [
            "tennis",
            "swimming"
          ],
          "home_lib": true,
          "trips": 2
        }'::jsonb),
       ('Pavel',
        '{
                  "sports": [
                    "swimming"
                  ],
                  "home_lib": false,
                  "trips": 4
                }'::jsonb),
       ('Boris',
        '{
                  "sports": [
                    "soccer",
                    "swimming",
                    "tennis"
                  ],
                  "home_lib": true,
                  "trips": 0
                }'::jsonb);

SELECT  *from pilot_hobbies;

SELECT * FROM pilot_hobbies
WHERE hobbies @> '{"sports": ["soccer"]}'::jsonb;

SELECT pilot_name, hobbies->'sports' AS sports
FROM pilot_hobbies
WHERE hobbies->'sports' @> '["soccer"]'::jsonb;

SELECT count(*)
FROM pilot_hobbies
WHERE hobbies ? 'sports';

UPDATE pilot_hobbies
SET hobbies = hobbies ||'{ "sports": [ "hockey" ] }'
WHERE pilot_name = 'Boris';

UPDATE pilot_hobbies
SET hobbies = jsonb_set(hobbies, '{sports, 1}', '"soccer"')
WHERE pilot_name = 'Boris'
