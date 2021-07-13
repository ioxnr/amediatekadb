DROP TRIGGER IF EXISTS check_likes_insert; -- пользователь не может одновременно поставить лайк и дизлайк
DELIMITER //
CREATE TRIGGER check_likes_insert BEFORE INSERT ON ratings
FOR EACH ROW
BEGIN
	IF NEW.likes = 1 AND NEW.dislikes = 1 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid value. Like and dislike cannot be at the same time';
	END IF; 
END //
DELIMITER ;


DROP TRIGGER IF EXISTS check_likes_update;
DELIMITER //
CREATE TRIGGER check_likes_update BEFORE UPDATE ON ratings
FOR EACH ROW
BEGIN
	IF NEW.likes = 1 AND NEW.dislikes = 1 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid value. Like and dislike cannot be at the same time';
	END IF; 
END //
DELIMITER ;


DROP TRIGGER IF EXISTS check_kino1tv_insert; -- устанавливаем дефолтные значения для сущности kino1tv
DELIMITER //
CREATE TRIGGER check_kino1tv_insert BEFORE INSERT ON movies
FOR EACH ROW
BEGIN
	IF NEW.movie_type = (SELECT id FROM movie_types WHERE name = 'kino1tv') THEN
		SET NEW.country = (SELECT id FROM countries WHERE country = 'Russia'), 
			NEW.company = (SELECT id FROM companies WHERE company = 'Perviy Kanal');
	END IF; 
END //
DELIMITER ;


