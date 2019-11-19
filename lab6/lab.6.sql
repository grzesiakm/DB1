//1.
CREATE FUNCTION lenVec (real, real)
RETURNS REAL
LANGUAGE plpgsql AS '
DECLARE 
x ALIAS FOR $1;
y ALIAS FOR $2;
BEGIN
	RETURN sqrt(x*x + y*y);
END;
';

//example
SELECT lenVec (3, 5) AS result;


//2.
CREATE TABLE equationXY (
	x real,
	y real
);

CREATE OR REPLACE FUNCTION equation (real, real, real)
RETURNS TABLE(x real, y real)
LANGUAGE plpgsql AS '
BEGIN
	FOR x IN 1 .. 100 LOOP
		INSERT INTO equationXY VALUES (x, $1 * x * x + $2 * x + $3);
	END LOOP;
	RETURN QUERY
		SELECT * FROM equation;
END;
';

//example
SELECT equation(1, -2, 1);

//3.
CREATE TABLE temp (C real, F real);
CREATE OR REPLACE FUNCTION tempConvert ()
RETURNS TABLE (x real, y real)
LANGUAGE plpgsql AS '
BEGIN
FOR x IN 1 .. 1000 LOOP 
INSERT INTO temp VALUES (x/10, (x/10)*1.8+32);
END LOOP;
RETURN QUERY
SELECT * FROM temp;
END;
';
 
SELECT tempConvert();

//4.

