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