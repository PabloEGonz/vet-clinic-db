/*Queries that provide answers to the questions from all projects.*/

-- SELECT * from animals WHERE name LIKE '%mon';

-- SELECT name from animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-01-2019';

-- SELECT name from animals WHERE (neutered = 't') AND ( escape_attempts < 3);

-- SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

-- SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- SELECT * from animals WHERE neutered = 't';

-- SELECT * from animals WHERE NOT name = 'Gabumon';

-- SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*  Vet clinic database: query and update animals table */

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT delborn;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delborn;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals; 
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts > 0; 
SELECT ROUND(AVG(weight_kg), 2) FROM animals;
SELECT neutered, ROUND(AVG(escape_attempts), 2) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, ROUND(AVG(escape_attempts), 2) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '01-01-2000' GROUP BY species;
