/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES ('Agumon', 'Feb 3 2020', 0, true, 10.23), 
('Gabumon', 'Nov 15 2018', 2, true, 8), 
('Pikachu', 'Jan 7 2021', 1, false, 15.04), 
('Devimon', 'May 12 2017', 5, true, 11);

/*  Vet clinic database: query and update animals table */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) 
VALUES ('Charmander', 'Feb 8, 2020', 0, false, -11),
('Plantmon', 'Nov 15, 2021', 2, true, -5.7),
('Squirtle', 'Apr 2, 1993', 3, false, -12.13),
('Angemon', 'Jun 12, 2005', 1, true, -45),
('Boarmon', 'Jun 7, 2005', 7, true, 20.4),
('Blossom', 'Oct 13, 1998', 3, true, 17),
('Ditto', 'May 14, 2022', 4, true, 22);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker ', 38);

INSERT INTO species (name)
VALUES('Pokemon'), ('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

/*Vet clinic database: add "join table" for visits */

INSERT INTO vets (name, age, date_of_graduation)
VALUES('William Tatcher', 45, 'Apr 23, 2000'),
('Maisy Smith', 26, 'Jan 17, 2019'),
('Stephanie Mendez', 64, 'May 4, 1981'),
(' Jack Harkness', 38, 'Jun 8, 2008');

INSERT INTO specializations (species_id, vets_id)
VALUES (1, 1),(1,3),(2,3),(2,4);

INSERT INTO visits(animal_id, vets_id, visit_date)
VALUES(1, 1, 'May 24, 2020'),
(1, 3, 'Jul 22, 2020'),
(2, 4, 'Feb 2, 2021'),
(5, 2, ' Jan 5, 2020'),
(5, 2, 'Mar 8, 2020'),
(5, 2, 'May 14, 2020'),
(3, 3, 'May 4, 2021'),
(9, 4, 'Feb 24, 2021'),
(7, 2, 'Dec 21, 2019'),
(7, 1, 'Aug 10, 2020'),
(7, 2, 'Apr 7, 2021'),
(10, 3, 'Sep 29, 2019'),
(8, 4, 'Oct 3, 2020'),
(8, 4, 'Nov 4, 2020'),
(4, 2, 'Jan 24, 2019'),
(4, 2, 'May 15, 2019'),
(4, 2, 'Feb 27, 2020'),
(4, 2, 'Aug 3, 2020'),
(6, 3, 'May 24, 2020'),
(6, 1, 'Jan 11, 2021');

-- Vet clinic database: database performance audit

INSERT INTO visits (animal_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

