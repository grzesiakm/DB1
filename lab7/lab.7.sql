//1.

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
	SELECT count(*) INTO num FROM ocena WHERE (studentID = student_id AND przedmiotID = przedmiot_id);
	IF(num < 3) THEN
		RAISE NOTICE 'Mozna dodac ocene:';
		RETURN NEW;
	ELSE 
		RAISE NOTICE 'Nie mozna dodac wiecej niz 3 oceny!';
		RETURN NULL;                                                   
	END IF;                                                        
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER trig_ocenianie BEFORE INSERT ON ocena FOR EACH ROW EXECUTE PROCEDURE ocenianie_trigger();


//2.

CREATE TABLE Srednia(
	srednia real,
	studentID INT,
	przedmiotID INT,
	FOREIGN KEY (przedmiotID) references Przedmiot(NrP),
	FOREIGN KEY (studentID) references Student(NrS));

CREATE OR REPLACE function avgUpdate() 
RETURNS TRIGGER AS $$
DECLARE
	count real;
	srednia record;
BEGIN
	IF (new.ocena >= 3) THEN
		SELECT srednia(ocena) INTO count FROM ocena WHERE studentID = new.studentID and przedmiotID = new.przedmiotID;
		RAISE NOTICE ''srednia: %'', count;
		SELECT * INTO srednia FROM Srednia WHERE studentID = new.studentID AND przedmiotID = new.przedmiotID;
	IF not found THEN
		INSERT INTO srednia VALUES (count, new.studentID, new.przedmiotID);
	ELSE 
		UPDATE Srednia SET srednia = count WHERE studentID = new.studentID AND przedmiotID = new.przedmiotID;
	END IF;
	END IF;
	RETURN NULL;
END;
$$ language 'plpgsql';

CREATE TRIGGER srednia AFTER INSERT ON ocena FOR EACH ROW EXECUTE PROCEDURE avgUpdate();


//3.

CREATE TABLE log ( 
    table_name varchar,
    operation varchar
);

CREATE OR REPLACE FUNCTION log()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO log (table_name, operation) VALUES (TG_RELNAME, TG_OP);
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER ocena_log AFTER INSERT OR UPDATE OR DELETE ON ocena FOR EACH ROW EXECUTE PROCEDURE log();

