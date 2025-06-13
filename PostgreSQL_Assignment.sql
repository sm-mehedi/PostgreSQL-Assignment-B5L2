-- Active: 1747980861147@@127.0.0.1@5432@conservation_db

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

INSERT INTO rangers (name, region)
VALUES ('Alice Green', 'Northern Hills'),
        ('Bob White', 'River Delta'),
        ('Carol King ', 'Mountain Range')
       
SELECT*FROM rangers;

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(20) NOT NULL
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT*FROM species;

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(50) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes VARCHAR(100)
);

ALTER TABLE sightings
ALTER COLUMN notes TYPE TEXT;


insert into sightings (species_id, ranger_id, location, sighting_time, notes)
Values(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
      (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
      (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
      (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT*FROM sightings;

-- Problem 1
INSERT INTO rangers (name, region)
VALUES ('Derek Fox','Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT sighting_id species_id, ranger_id, location, sighting_time, notes from sightings
WHERE location LIKE '%Pass%';

-- Problem 4
SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name
ORDER BY rangers.name;

-- Problem 5
SELECT species.common_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;

-- Problem 6

SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;


-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
Where discovery_date < '1800-01-01';

-- Problem 8
ALTER TABLE sightings ADD COLUMN time_of_day TEXT;

UPDATE sightings
SET time_of_day = 
  CASE 
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
    ELSE 'Evening'
  END;

SELECT sighting_id, time_of_day
FROM sightings;


-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);



