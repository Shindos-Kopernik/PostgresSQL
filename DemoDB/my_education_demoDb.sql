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
WHERE range >= 4000 AND range <= 6000;

UPDATE air SET range = 3500
WHERE air_code = 'SU9';

DELETE FROM air WHERE air_code = 'CN1';
DELETE FROM air WHERE range > 10000 OR range < 3000;

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

INSERT INTO my_seats
VALUES ('SU9', '1A', 'Business'),
       ('763', '10B', 'Business');

INSERT INTO my_seats
VALUES ('763', '15C', 'Economy'),
       ('319', '18E', 'Comfort');

SELECT air_code, count(*) FROM my_seats
GROUP BY air_code;

SELECT air_code, count(*) FROM my_seats
GROUP BY air_code
ORDER BY count(*);

SELECT aircraft_code, count(*) FROM seats
GROUP BY aircraft_code
ORDER BY count(*);

SELECT aircraft_code, fare_conditions, count(*) FROM seats
GROUP BY aircraft_code, fare_conditions
ORDER BY aircraft_code, fare_conditions;

SELECT 0.1::real * 10 = 1.0::real;

SELECT current_date;

SELECT current_time;
