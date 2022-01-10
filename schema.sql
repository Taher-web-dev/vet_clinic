CREATE TABLE animals (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(50),
date_of_birth date,
escape_attempts INT,
neutered bit,
weight_kg decimal,
PRIMARY KEY (id)
);
