/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';

SELECT name from animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-01-2019';

SELECT name from animals WHERE (neutered = 't') AND ( escape_attempts < 3);

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = 't';

SELECT * from animals WHERE NOT name = 'Gabumon';

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

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
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0; 
SELECT ROUND(AVG(weight_kg), 2) FROM animals;
SELECT neutered, ROUND(AVG(escape_attempts), 2) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, ROUND(AVG(escape_attempts), 2) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '01-01-2000' GROUP BY species;

SELECT name AS OWNS FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name AS POKEMONS FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT full_name, name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(species_id) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon' ;

SELECT animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id  
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT full_name, COUNT(full_name) FROM animals INNER JOIN owners ON animals.owner_id = owners.id  
GROUP BY full_name;

SELECT full_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(full_name) DESC
LIMIT 1;

/*Vet clinic database: add "join table" for visits */

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(animals.name) FROM animals 
JOIN visits ON animal_id = animals.id
JOIN vets ON vets.id = vets_id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM vets 
LEFT JOIN specializations ON specializations.vets_id = vets.id 
LEFT JOIN species ON species.id = species_id;

SELECT animals.name  FROM animals 
JOIN visits ON animal_id = animals.id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez' 
AND visits.visit_date BETWEEN 'April 1, 2020' 
AND 'August 30, 2020';

SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
GROUP BY animals.name 
ORDER BY COUNT(animals.name) DESC
LIMIT 1;


SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
vets.name AS vet_name, vets.age AS vet_age, vets.date_of_graduation,
visit_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(vets.name) FROM vets
JOIN visits ON visits.vets_id = vets.id
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN species ON species.id = specializations.species_id
WHERE species.name IS NULL;

SELECT species.name FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vets_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;

-- Vet clinic database: database performance audit

INSERT INTO visits (animal_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

ALTER TABLE ADD INDEX visit_animal_id_idx (animal_id);

CREATE INDEX visit_animal_id_idx  ON visits (animal_id DESC);

