SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE (neutered = TRUE AND escape_attempts <3);

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE (weight_kg BETWEEN 10.4 AND 17.3);

SELECT COUNT(*) AS ANIMALS_NBR FROM animals;

SELECT COUNT(*) AS NEVER_ESCAPED_ANIMALS FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS AVG_WEIGHT FROM animals;

SELECT neutered,SUM(escape_attempts) AS TOTAL_ESCAPE FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg) AS MINIMUM_WEIGHT , MAX(weight_kg) as MAXIMUM_WEIGHT 
FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS AVG_ESCAPE_NBR 
FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;
