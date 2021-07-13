DROP PROCEDURE IF EXISTS collections;
DELIMITER //
CREATE PROCEDURE collections(IN name_of_collection VARCHAR(200))
BEGIN
	SELECT title_type, title, genre, directors, `cast`, country, company, age_of_viewer, premiere, synopsis, poster, trailer
	FROM title_info
	WHERE collection = name_of_collection
	ORDER BY premiere DESC;
END//
DELIMITER ;

CALL collections('Rem et vitae alias.');



DROP PROCEDURE IF EXISTS movie_types;
DELIMITER //
CREATE PROCEDURE movie_types(IN `type` VARCHAR(100))
BEGIN
	SELECT title, genre, directors, `cast`, country, company, age_of_viewer, premiere, synopsis, poster, trailer, collection
	FROM title_info
	WHERE title_type = `type`
	ORDER BY premiere DESC;
END//
DELIMITER ;

CALL movie_types('films');



DROP PROCEDURE IF EXISTS movie_genres;
DELIMITER //
CREATE PROCEDURE movie_genres(IN title_genre VARCHAR(200))
BEGIN
	SELECT title_type, title, directors, `cast`, country, company, age_of_viewer, premiere, synopsis, poster, trailer, collection
	FROM title_info
	WHERE genre = title_genre
	ORDER BY premiere DESC;
END//
DELIMITER ;

CALL movie_genres('Non et nemo iusto.');



DROP PROCEDURE IF EXISTS movie_country;
DELIMITER //
CREATE PROCEDURE movie_country (IN title_country VARCHAR(200))
BEGIN
	SELECT title_type, title, genre, directors, `cast`, company, age_of_viewer, premiere, synopsis, poster, trailer, collection
	FROM title_info
	WHERE country = title_country
	ORDER BY premiere DESC;
END//
DELIMITER ;

CALL movie_country('Ireland');



DROP PROCEDURE IF EXISTS movie_company;
DELIMITER //
CREATE PROCEDURE movie_company (IN title_company VARCHAR(200))
BEGIN
	SELECT title_type, title, genre, directors, `cast`, country, age_of_viewer, premiere, synopsis, poster, trailer, collection
	FROM title_info
	WHERE company = title_company
	ORDER BY premiere DESC;
END//
DELIMITER ;

CALL movie_company('Gleason-Turner');



DROP PROCEDURE IF EXISTS ranking_by_rating; 
DELIMITER //
CREATE PROCEDURE ranking_by_rating (OUT value INT)
BEGIN
	SELECT (like_count - dislike_count) AS rating, title
	FROM title_rating
	ORDER BY rating DESC;
END//
DELIMITER ;

CALL ranking_by_rating(@rating);



DROP PROCEDURE IF EXISTS ranking_by_newest; 
DELIMITER //
CREATE PROCEDURE ranking_by_newest (OUT value INT)
BEGIN
	SELECT  title_type, title, genre, directors, `cast`, country, company, age_of_viewer, premiere, synopsis, poster, trailer, collection
	FROM title_info
	ORDER BY premiere DESC;
END//
DELIMITER ;

CALL ranking_by_newest(@newest);


