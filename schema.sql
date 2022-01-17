CREATE TABLE animals (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(50),
date_of_birth date,
escape_attempts INT,
neutered boolean,
weight_kg decimal,
PRIMARY KEY (id)
);

ALTER TABLE animals 
ADD species VARCHAR(100);

DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100),
  age INT,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS species;
CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  PRIMARY KEY(id)
);

ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT constraint_fkey
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE SET NULL;

ALTER TABLE animals 
ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fkey_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE SET NULL;

DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  age INT,
  date_of_graduation date,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS specializations;
CREATE TABLE specializations (
  id INT GENERATED ALWAYS AS IDENTITY,
  vets_id INT,
  species_id INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_vets
    FOREIGN KEY (vets_id)
      REFERENCES vets(id)
      ON DELETE SET NULL,
  CONSTRAINT fk_species
    FOREIGN KEY (species_id)
      REFERENCES species(id)
      ON DELETE SET NULL
);

DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT,
  vet_id INT ,
  visite_date DATE,
  PRIMARY KEY (id),
  CONSTRAINT fk_animal
    FOREIGN KEY(animal_id)
      REFERENCES animals (id)
      ON DELETE SET NULL,
  CONSTRAINT fk_vets
    FOREIGN KEY(vet_id)
      REFERENCES vets(id)
      ON DELETE SET NULL
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, visite_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- Create Index on visit table for animal_id
CREATE INDEX visit_animal_id ON visits (animal_id DESC);

-- Create Index on visit table for animal_id
CREATE INDEX visit_vet_id ON visits (vet_id DESC);

-- Create Index on owners table for owner email
CREATE INDEX owners_email ON owners(email DESC);

