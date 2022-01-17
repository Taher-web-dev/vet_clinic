SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE (neutered = TRUE AND escape_attempts <3);

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE (weight_kg BETWEEN 10.4 AND 17.3);

BEGIN ;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE  FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT BB2022;
UPDATE animals SET weight_kg = weight_kg * -1 ; 
ROLLBACK TO BB2022;
UPDATE animals SEt weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) AS ANIMALS_NBR FROM animals;

SELECT COUNT(*) AS NEVER_ESCAPED_ANIMALS FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS AVG_WEIGHT FROM animals;

SELECT neutered,SUM(escape_attempts) AS TOTAL_ESCAPE FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg) AS MINIMUM_WEIGHT , MAX(weight_kg) as MAXIMUM_WEIGHT 
FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS AVG_ESCAPE_NBR 
FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;

SELECT A.name, O.full_name 
FROM animals A
JOIN owners O ON A.owner_id = O.id 
WHERE O.full_name = 'Melody Pond';

SELECT A.name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, S.name AS type
FROM animals A 
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT A.name AS animal_name , O.full_name AS owner 
FROM animals A 
RIGHT JOIN owners O ON A.owner_id = O.id ;

SELECT COUNT(*) AS ANIMALS_NBR , S.name AS species
FROM animals A 
JOIN species S ON A.species_id = S.id 
GROUP BY species;

SELECT A.name , A.date_of_birth , A.escape_attempts, A.neutered , A.weight_kg 
FROM animals A 
JOIN owners O ON A.owner_id = O.id 
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

SELECT A.name , A.date_of_birth , A.escape_attempts, A.neutered , A.weight_kg
FROM animals A 
JOIN owners O ON A.owner_id = O.id 
WHERE A.escape_attempts = 0 AND O.full_name = 'Dean Winchester';


SELECT COUNT(*) AS ANIMALS_NBR, O.full_name 
FROM animals A 
JOIN owners O ON A.owner_id = O.id
GROUP BY (O.full_name) 
ORDER BY ANIMALS_NBR DESC
LIMIT 1;

SELECT  I.visite_date ,V.name AS vet_name ,A.name AS animal_name 
FROM visits AS I
JOIN animals A ON I.animal_id = A.id 
JOIN vets V ON I.vet_id = V.id
WHERE V.name = 'William Tatcher'
ORDER BY I.visite_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT(I.animal_id)) 
FROM visits I
JOIN vets V ON I.animal_id = V.id 
WHERE (v.name = 'Stephanie Mendez');

SELECT V.name AS vet_name , S.name AS speciality 
FROM specializations I 
RIGHT JOIN vets V ON I.vets_id = V.id
JOIN species S ON I.species_id = S.id;

SELECT A.name AS animal_name
FROM visits I 
JOIN animals A ON I.animal_id = A.id
JOIN vets V ON I.vet_id = V.id 
WHERE (V.name = 'Stephanie Mendez') AND (I.visite_date BETWEEN '2020-04-01' AND '2020-08-30');

SELECT A.name , Count(A.name) AS visite_nbr 
FROM visits I
JOIN animals A ON I.animal_id = A.id 
GROUP BY (A.name)
ORDER BY visite_nbr DESC
LIMIT 1;

SELECT A.name 
FROM visits I
JOIN animals A ON I.animal_id = A.id
JOIN vets V ON I.vet_id = V.id
WHERE V.name = 'Maisy Smith'
ORDER BY (I.visite_date) ASC 
LIMIT 1;

SELECT A.name AS animal_name, A.date_of_birth AS animal_date_of_birth , A.escape_attempts,
A.weight_kg, A.neutered, V.name AS vet_name, V.age AS vet_age , V.date_of_graduation,
I.visite_date 
FROM visits I 
JOIN animals A ON I.animal_id = A.id
JOIN vets V ON I.vet_id = V.id 
ORDER BY (I.visite_date) DESC
LIMIT 1;


SELECT COUNT(*) AS nbr_no_speacialized_vet
FROM visits I
JOIN animals A ON I.animal_id = A.id
JOIN vets V ON I.vet_id = V.id
JOIN specializations S ON V.id = S.vets_id
WHERE (A.species_id <> S.species_id);

SELECT S.name,COUNT(*) AS species_visite 
FROM visits I 
JOIN vets V ON I.vet_id = V.id
JOIN animals A ON I.animal_id = A.id
JOIN species S ON A.species_id = S.id
WHERE V.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY S.name DESC 
LIMIT 1;



-- queries for performance testing
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com'; 