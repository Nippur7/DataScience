CREATE TABLE IF NOT EXISTS prueba.cyclist_career_teams (
  id UUID PRIMARY KEY,
  lastname text,
  teams set<text>
);


INSERT INTO prueba.cyclist_career_teams (
  id, lastname, teams
 ) VALUES (
  5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 
  'VOS', 
  {
    'Rabobank-Liv Woman Cycling Team',
    'Rabobank-Liv Giant',
    'Rabobank Women Team',
    'Nederland bloeit'
  }
);


INSERT INTO prueba.cyclist_career_teams (id,lastname,teams) VALUES (e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN', { 'Rabobank-Liv Woman Cycling Team','Sengers Ladies Cycling Team','Team Flexpoint' } );
INSERT INTO prueba.cyclist_career_teams (id,lastname,teams) VALUES (cb07baad-eac8-4f65-b28a-bddc06a0de23, 'ARMITSTEAD', { 'Boels-Dolmans Cycling Team','AA Drink - Leontien.nl','Team Garmin - Cervelo' } );
INSERT INTO prueba.cyclist_career_teams (id,lastname,teams) VALUES (1c9ebc13-1eab-4ad5-be87-dce433216d40, 'BRAND', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','AA Drink - Leontien.nl','Leontien.nl' } );


SELECT * FROM prueba.cyclist_career_teams;

CREATE TABLE IF NOT EXISTS prueba.cyclist_telefono (
  id UUID PRIMARY KEY,
  telefonos set<text>
);

INSERT INTO prueba.cyclist_telefono (id, telefonos) VALUES (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, {'123-141','235245'});
INSERT INTO prueba.cyclist_telefono (id, telefonos) VALUES (1c9ebc13-1eab-4ad5-be87-dce433216d40, {'123-141','235245'});

SELECT * FROM prueba.cyclist_telefono;
DESC prueba.cyclist_telefono;

UPDATE prueba.cyclist_telefono SET telefonos = {'123-11','11'} WHERE id = 1c9ebc13-1eab-4ad5-be87-dce433216d40;

SELECT * FROM prueba.cyclist_telefono;

SELECT MAX(id) FROM prueba.cyclist_telefono;
SELECT COUNT(*) FROM prueba.cyclist_telefono;

INSERT INTO prueba.cyclist_telefono (id, telefonos) VALUES (1c9ebc13-1eab-4ad5-be87-dce433216d40, {'222-333','6789'});

SELECT * FROM prueba.cyclist_telefono;

INSERT INTO prueba.cyclist_career_teams (id,lastname,teams) VALUES (1c9ebc13-1eab-4ad5-be87-dce433216d41, 'BRAND', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','AA Drink - Leontien.nl','Leontien.nl' } );

SELECT * FROM prueba.cyclist_career_teams;

SELECT lastname, MAX(id) FROM prueba.cyclist_career_teams GROUP BY lastname;

CREATE INDEX cyclist_career_teams_lastname ON prueba.cyclist_career_teams (lastname);

SELECT id, MAX(lastname) FROM prueba.cyclist_career_teams GROUP BY id;

TRUNCATE TABLE prueba.cyclist_telefono;

SELECT * FROM prueba.cyclist_telefono;

DROP TABLE prueba.cyclist_telefono;

CREATE TABLE prueba.cyclist_telefono (
    id uuid PRIMARY KEY,
    telefonos set<text>
);

SELECT * FROM prueba.cyclist_career_teams WHERE id IN (1c9ebc13-1eab-4ad5-be87-dce433216d40);