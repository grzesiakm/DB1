CREATE TABLE public.Czytelnicy (
                Czytelnik_id INTEGER NOT NULL,
                Aktywny BOOLEAN NOT NULL,
                Imie VARCHAR NOT NULL,
                Nazwisko VARCHAR NOT NULL,
                CONSTRAINT czytelnicy_pk PRIMARY KEY (Czytelnik_id)
);


CREATE TABLE public.Ksiazki (
                Ksiazki_id INTEGER NOT NULL,
                Autorzy_id INTEGER NOT NULL,
                Tytul VARCHAR NOT NULL,
                ISBN INTEGER NOT NULL,
                CONSTRAINT ksiazki_pk PRIMARY KEY (Ksiazki_id)
);


CREATE TABLE public.Ksiazki_Czytelnicy (
                Ksiazki_Czytelnicy_id INTEGER NOT NULL,
                Czytelnik_id INTEGER NOT NULL,
                Ksiazki_id INTEGER NOT NULL,
                Data_wypozyczenia TIMESTAMP NOT NULL,
                Data_oddania TIMESTAMP NOT NULL,
                CONSTRAINT ksiazki_czytelnicy_pk PRIMARY KEY (Ksiazki_Czytelnicy_id)
);


CREATE TABLE public.Autorzy (
                Autorzy_id INTEGER NOT NULL,
                Imie VARCHAR NOT NULL,
                Nazwisko VARCHAR NOT NULL,
                CONSTRAINT autorzy_pk PRIMARY KEY (Autorzy_id)
);


ALTER TABLE public.Ksiazki_Czytelnicy ADD CONSTRAINT ksiazki_czytelnicy_czytelnicy_fk
FOREIGN KEY (Czytelnik_id)
REFERENCES public.Czytelnicy (Czytelnik_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Autorzy ADD CONSTRAINT ksiazki_autorzy_fk
FOREIGN KEY (Ksiazki_id)
REFERENCES public.Ksiazki (Ksiazki_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Ksiazki_Czytelnicy ADD CONSTRAINT ksiazki_ksiazki_czytelnicy_fk
FOREIGN KEY (Ksiazki_id)
REFERENCES public.Ksiazki (Ksiazki_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Ksiazki ADD CONSTRAINT autorzy_ksiazki_fk
FOREIGN KEY (Autorzy_id)
REFERENCES public.Autorzy (Autorzy_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
