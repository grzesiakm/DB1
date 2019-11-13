CREATE TABLE Student(Nr_S INT PRIMARY KEY,
                     Indeks Varchar(5) UNIQUE,
                     Imie varchar(20) NOT NULL,
                     Nazwisko varchar(40) NOT NULL,
                     Grupa varchar(10) NOT NULL);

CREATE TABLE Przedmiot (Nr_P INT PRIMARY KEY,
                        Nazwa Varchar(10) );

CREATE TABLE Ocena(Nr_O INT,
                    ocena INT ,
                    Data DATE,
                    student_ID INT,
                    przedmiot_ID INT,
                    FOREIGN KEY (przedmiot_ID) references Przedmiot(Nr_P),
                    FOREIGN KEY (student_ID) references Student(Nr_S));
