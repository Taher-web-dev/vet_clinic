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