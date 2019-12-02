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

//
SELECT lenVec (3, 5) AS result;


//2.

CREATE TYPE pair AS (x int, y real);

CREATE OR REPLACE FUNCTION equation (real, real, real)
RETURNS setof pair
LANGUAGE plpgsql AS '
DECLARE 
	pair pair%rowtype;
	A ALIAS FOR $1;
	B ALIAS FOR $2;
	C ALIAS FOR $3;
BEGIN
	FOR x IN 1 .. 100 LOOP
		pair.x = x;
	       	pair.y = x*x*A + x*C + x*C;
	       	RETURN next (pair.x, pair.y);
	END LOOP;
	RETURN;
END;
';

//
SELECT equation(1, -2, 1);


//3.

CREATE TYPE converted AS (x real, y real);

CREATE OR REPLACE FUNCTION tempConvert ()
RETURNS setof converted
LANGUAGE plpgsql AS '
DECLARE
	conv converted%rowtype;
BEGIN
	FOR x IN 1 .. 1000 LOOP 
		conv.x = x/10;
		conv.y =  x*1.8+32;
		RETURN next (conv.x, conv.y);
	END LOOP;
	RETURN;
END;
';
 
//
SELECT tempConvert();


//4.

CREATE OR REPLACE FUNCTION liczba_studentow() 
RETURNS integer
LANGUAGE plpgsql AS '
DECLARE
	result integer;
BEGIN
	SELECT COUNT(*) INTO result FROM student;
	RETURN result;
 END;
';

//
SELECT liczba_studentow();


//5.

CREATE OR REPLACE FUNCTION liczba_studentow_1(text) 
RETURNS integer
LANGUAGE plpgsql AS '
DECLARE
	result integer;
BEGIN
	SELECT COUNT(*) INTO result FROM student WHERE grupa = $1;
	RETURN result;
 END;
';

//
SELECT liczba_studentow(is3gr3);


//6.

CREATE OR REPLACE FUNCTION srednia(text) 
RETURNS real
LANGUAGE plpgsql AS '
DECLARE
	result real;
BEGIN
       	SELECT AVG(ocena) INTO result from (SELECT * from ocena o JOIN student s ON s.Nr_s = o.student_id ) AS stud_ocen WHERE stud_ocen.Nazwisko = $1 GROUP BY Nr_S;
	RETURN result; 
END;
';

//
SELECT srednia(Sienkiewicz); 


//7.

CREATE OR REPLACE FUNCTION genLog() 
RETURNS setof text 
LANGUAGE plpgsql AS ' 
DECLARE 
	studLog student%rowtype;
BEGIN 
	FOR studLog IN SELECT * FROM student 
	LOOP 
		BEGIN RETURN NEXT studLog.Imie || studLog.Nazwisko;
	END LOOP;
	RETURN; 
END;
';

//
SELECT genLog();


//8.
