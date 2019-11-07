CREATE SCHEMA univers;
SET search_path TO univers;

CREATE DOMAIN domStartUpEndNum AS TEXT
CHECK(
VALUE ~ '[A-Z]%[1-9]'
OR VALUE ~ '[A-Z]%[_][1-9]'
);

CREATE DOMAIN domUrl TEXT 
CONSTRAINT valid_value 
CHECK(
VALUE ~ 'http://%.org'
);

CREATE DOMAIN domStamp VARCHAR 
CONSTRAINT valid_value 
CHECK(
VALUE ~ '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[03][0-9] %'
);


CREATE SEQUENCE seqID;


CREATE TABLE universe (id INT PRIMARY KEY UNIQUE NOT NULL, name domStartUpEndNum UNIQUE NOT NULL);

CREATE TABLE tabsystem (id INT PRIMARY KEY UNIQUE NOT NULL, idUniverse INT REFERENCES universe(id) NOT NULL, name domStartUpEndNum UNIQUE NOT NULL, discStamp domStamp NOT NULL);

CREATE TABLE tabsun (id INT PRIMARY KEY UNIQUE NOT NULL, idSystem INT REFERENCES tabsystem(id) NOT NULL, name domStartUpEndNum UNIQUE NOT NULL);

CREATE TABLE tabplanet (id seqID PRIMARY KEY UNIQUE NOT NULL, idSystem INT REFERENCES tabsystem(id), name domStartUpEndNum UNIQUE NOT NULL, period DECIMAL(5,2), distance DECIMAL(10,2), URL domUrl NOT     NULL);

CREATE TABLE tabplanet2sun (idSun INT REFERENCES tabsun NOT NULL, idPlanet INT REFERENCES tabplanet NOT NULL);

CREATE TABLE tabmoon (id seqID PRIMARY KEY UNIQUE NOT NULL, name domStartUpEndNum UNIQUE NOT NULL, period DECIMAL(5,2), distance DECIMAL(10,2), idMoon seqID REFERENCES tabmoon, idPlanet seqID REFERENC    ES tabplanet);


CREATE INDEX nameUniverse ON universe(name);

CREATE INDEX nameSystem ON tabsystem(name);
 
CREATE INDEX nameSun ON tabsun(name);
 
CREATE INDEX namePlanet ON tabplanet(name);
 
CREATE INDEX nameMoon ON tabmoon(name);

