##code for genres
SELECT CONCAT(pl.first_name, ' ', pl.last_name) AS listener_name, pl.country, pl.zip_code, ps.title AS podcast_title, ps.category AS genre,
            CASE
                WHEN pl.user_activity = 0 THEN 'Active'
                WHEN pl.user_activity = 1 THEN 'Inactive'
            END AS listener_status
FROM `podcast shows` ps
JOIN `podcast listeners` pl
    ON ps.id = pl.id
ORDER BY pl.country, ps.category;

##code for Wondery
SELECT CONCAT(pl.first_name, ' ', pl.last_name) AS listener_name, pl.country, pl.zip_code, ps.title AS podcast_title, ps.author, ps.category AS genre,
            CASE
                WHEN pl.user_activity = 0 THEN 'Active'
                WHEN pl.user_activity = 1 THEN 'Inactive'
            END AS listener_status
FROM `podcast shows` ps
JOIN `podcast listeners` pl
    ON ps.id = pl.id
WHERE ps.author LIKE '%Wondery%'
ORDER BY pl.country;

DROP TABLE Podcast_Listener_Status;
DROP TRIGGER Podcast_User_Listener_Status_Update;

##Trigger
CREATE TABLE Podcast_Listener_Status (
listener_id INT(11),
first_name VARCHAR(255),
last_name VARCHAR(255),
id VARCHAR(255),
street_address VARCHAR(255),
city VARCHAR(255),
country VARCHAR(255),
zip_code VARCHAR(255),
user_activity INT(11),
new_user_activity INT(11),
LogDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

SELECT USER();

DELIMITER $$
CREATE TRIGGER Podcast_User_Listener_Status_Update
    AFTER UPDATE ON `podcast listeners`
    FOR EACH ROW
BEGIN
    INSERT INTO Podcast_Listener_Status(listener_id, first_name, last_name, id, street_address, city, country, zip_code, user_activity, new_user_activity)
    VALUES
    (USER(), OLD.listener_id, OLD.first_name, OLD.last_name, OLD.id, OLD.street_address, OLD.city, OLD.country, OLD.zip_code, OLD.user_activity, NEW.user_activity);
END$$
DELIMITER ;

SELECT *
FROM `podcast listeners`
ORDER BY RAND()
LIMIT 1;

UPDATE `podcast listeners`
SET user_activity = 0
WHERE listener_id = 118
	AND first_name = 'Norman'
	AND last_name = 'Petty'
	AND id = '006c3135-deed-34c5-a215-4037e3c34e55'
	AND street_address = 'Ap #350-1678 Tincidunt Avenue'
	AND city = 'Herenthout'
	AND country = 'Mayotte'
	AND zip_code = 82747;

SELECT *
FROM Podcast_Listener_Status;

SELECT *
FROM `podcast listeners`
WHERE listener_id = 118;

SHOW CREATE TRIGGER Podcast_User_Listener_Status_Update;


