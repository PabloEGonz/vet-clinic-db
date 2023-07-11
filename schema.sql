/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts integer,
    neutered BOOLEAN,
    weight_kg DECIMAL(5,2)
);
