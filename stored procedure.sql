##create code for podcast_advertiser_information
CREATE OR REPLACE VIEW podcast_advertiser_information AS
  SELECT ps.title AS podcast_title, ps.category AS genre, ps.language, ps.advertiser_id, pa.company AS advertiser, pa.type_of_business AS advertiser_business, pa.email,
    (
        SELECT COUNT(advertiser_id)
        FROM `podcast shows`
        WHERE advertiser_id = ps.advertiser_id
    ) AS count_of_advertisers
  FROM `podcast shows` ps
  JOIN `podcast advertisers` pa
      ON ps.id = pa.id
  GROUP BY pa.advertiser_id;

##run podcast_advertiser_information
SELECT *
FROM podcast_advertiser_information;

##Stored PROCEDURE
DELIMITER $$
DROP PROCEDURE IF EXISTS getPodcastAdvertisersList$$

CREATE PROCEDURE getPodcastAdvertisersList (inAdvertiserID INT, OUT outCountOfShowsPerAdvertiser INT)
BEGIN
    SET @advertiser_id := inAdvertiserID;

	SELECT COUNT(*) INTO outCountOfShowsPerAdvertiser
	FROM `podcast shows`
    WHERE advertiser_id = @advertiser_id;
END $$
DELIMITER ;

##Call stored PROCEDURE
CALL getPodcastAdvertisersList(24, @advertiser_name);

##Confirm count
SELECT @advertiser_name;
