CREATE DATABASE clinic;

CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth date,
  PRIMARY KEY(id)
);



CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at DATE,
  patient_id int,
  status VARCHAR(200),
  PRIMARY KEY (id)    
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100),
  name VARCHAR(100),
  PRIMARY KEY(id)
);

CREATE TABLE histories_treatements (
  id INT GENERATED ALWAYS AS IDENTITY,
  treatment_id INT,
  history_id INT,
  treatment_prescription_date date,
  PRIMARY KEY(id),
  CONSTRAINT fk_treatment_id
    FOREIGN KEY (treatment_id)
    REFERENCES treatments(id)
    ON DELETE SET NULL,
  CONSTRAINT fk_histories_id
    FOREIGN KEY (history_id)
    REFERENCES medical_histories(id)
    ON DELETE SET NULL
);

CREATE TABLE invoices (
id INT GENERATED ALWAYS AS IDENTITY,
total_amount decimal,
generated_at date,
payed_at date,
medical_history_id INT,
PRIMARY KEY (id),
CONSTRAINT fk_inv_med_his
  FOREIGN KEY (medical_history_id)
  REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price decimal,
  quantity INT,
  total_price decimal,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_inv_items_treatment
    FOREIGN KEY(treatment_id)
    REFERENCES treatments(id)
    ON DELETE SET NULL,
  CONSTRAINT fk_inv_items_inv 
    FOREIGN KEY (invoice_id)
    REFERENCES invoices(id)
    ON DELETE SET NULL
);

