/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY(START WITH 1 INCREMENT BY 1),
    name varchar(100),
    date_of_birth DATE,
    escape_attempts integer,
    neutered BOOLEAN,
    weight_kg DECIMAL(5,2),
    PRIMARY KEY (id)
);

/*  Vet clinic database: query and update animals table */

ALTER TABLE animals ADD species varchar(200);

/* Vet clinic database: query multiple tables
*/

CREATE TABLE owners(
    id SERIAL,
    full_name varchar(100),
    age integer,
    PRIMARY KEY (id)
);

CREATE TABLE species(
    id SERIAL,
    name varchar(100),
    PRIMARY KEY (id)
);
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id int REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id int REFERENCES owners(id);

/*Vet clinic database: add "join table" for visits */

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name varchar(100),
    age integer,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    species_id integer,
    vets_id integer,
    PRIMARY KEY (species_id, vets_id),
    FOREIGN KEY (species_id) REFERENCES species(id),
    FOREIGN KEY (vets_id) REFERENCES vets(id)
);


-- CREATE TABLE visits (
--     animal_id integer,
--     vets_id integer,
--     visit_date DATE,
--     FOREIGN KEY (animal_id) REFERENCES animals(id),
--     FOREIGN KEY (vets_id) REFERENCES vets(id)
-- );

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vets_id INT REFERENCES vets(id),
  visit_date DATE,
  PRIMARY KEY(id)
);

-- Vet clinic database: database performance audit
/* add indexing for animals id querying*/

CREATE INDEX visit_animal_id_idx  ON visits (animal_id DESC);

/* add indexing for vets id querying*/

CREATE INDEX visits_vets_id_idx ON visits(vets_id);

/* add indexing for owners email querying*/

CREATE INDEX owners_email_idx ON owners(email);
