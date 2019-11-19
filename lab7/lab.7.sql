//1

CREATE or replace FUNCTION ocenianie_trigger()
RETURNS TRIGGER AS $$
DECLARE 
studentID integer;
przedmiotID integer;
max_ocen integer;
num integer;
BEGIN
max_ocen := 3;
przedmiotID := NEW.przedmiot_id;
studentID := NEW.student_id;
SELECT count(*) INTO num FROM Ocena WHERE (studentID = student_id AND przedmiotID = przedmiot_id);
IF(num < 3) THEN
RAISE NOTICE 'Mozna dodac ocene:';
RETURN NEW;
ELSE 
RAISE NOTICE 'Nie mozna dodac wiecej niz 3 oceny!';
RETURN NULL;                                                   
END IF;                                                        
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER trig_ocenianie BEFORE INSERT on Ocena FOR EACH ROW EXECUTE PROCEDURE ocenianie_trigger();


//2


//3

CREATE TABLE log ( 
    table_name varchar,
    operation varchar
);

CREATE OR REPLACE FUNCTION log()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO log (table_name, operation) VALUES(TG_RELNAME, TG_OP);
RETURN NEW;
END;
$$;

CREATE TRIGGER ocena_log AFTER INSERT OR UPDATE OR DELETE ON Ocena FOR EACH ROW EXECUTE PROCEDURE log();

