CREATE OR REPLACE VIEW title_info AS
	SELECT m1.id AS title_id,
		m_t.name AS title_type,
		m1.title AS title,
		g.genre AS genre,
		(SELECT CONCAT(d.firstname, ' ', d.lastname)) AS directors,
		(SELECT CONCAT(c1.firstname, ' ', c1.lastname)) AS `cast`,
		c2.country AS country,
		c3.company AS company,
		m1.age_of_viewer AS age_of_viewer,
		m1.premiere AS premiere,
		m1.synopsis AS synopsis,
		m2.filename AS poster,
		m3.filename AS trailer,
		c4.name AS collection
		
		FROM movies AS m1
		
		LEFT JOIN movie_types AS m_t
		ON m1.movie_type = m_t.id
		LEFT JOIN genres AS g 
		ON m1.genre = g.id 
		LEFT JOIN directors AS d 
		ON m1.directors = d.id 
		LEFT JOIN `cast` AS c1
		ON m1.`cast` = c1.id 
		LEFT JOIN countries AS c2
		ON m1.country = c2.id
		LEFT JOIN companies AS c3
		ON m1.company = c3.id
		LEFT JOIN media AS m2
		ON m1.poster_id = m2.id 
		LEFT JOIN media AS m3
		ON m1.trailer_id = m3.id 
		LEFT JOIN collections AS c4
		ON m1.collection_id = c4.id
		
		WHERE m2.media_type_id IN (SELECT id FROM media_types WHERE name = 'image')
		OR m3.media_type_id IN (SELECT id FROM media_types WHERE name = 'video')
	
		ORDER BY title;


CREATE OR REPLACE VIEW user_profile AS	
	SELECT u.id AS id,
		u.email AS email,
		u.phone AS phone,
		p.nickname AS nickname,
		m.filename AS avatar,
		p.created_at AS date_of_creation
		
		FROM users AS u 
		
		LEFT JOIN profiles AS p
		ON u.id = p.user_id
		LEFT JOIN media AS m 
		ON p.avatar_id = m.id;

	
CREATE OR REPLACE VIEW user_subscriptions AS
	SELECT p.user_id AS user_id,
		p.nickname AS nickname,
		s.subscription_plan AS subscription_plan,
		s.description AS description
	
		FROM profiles AS p 
		
		LEFT JOIN subscriptions AS s 
		ON p.user_id = s.user_id;
		

CREATE OR REPLACE VIEW user_favorites AS
	SELECT p.user_id AS user_id,
		p.nickname AS nickname,
		m.title AS favorite_movies,
		f.created_at AS datetime_added
		
		FROM profiles AS p 
		
		LEFT JOIN favorites AS f 
		ON p.user_id = f.user_id
		LEFT JOIN movies AS m 
		ON f.movie_id = m.id;
	
	
CREATE OR REPLACE VIEW user_history AS
	SELECT p.user_id AS user_id,
		p.nickname AS nickname,
		m.title AS watched,
		h.`date` AS date_watching
		
		FROM profiles AS p 
		
		LEFT JOIN history AS h
		ON p.user_id = h.user_id
		LEFT JOIN movies AS m 
		ON h.movie_id = m.id;
	
			  
CREATE OR REPLACE VIEW title_rating AS
	SELECT t.id, t.title, l.like_count, d.dislike_count
		FROM (SELECT id, title FROM movies WHERE id IN (SELECT movie_id FROM ratings)) AS t
		LEFT JOIN (SELECT SUM(likes) AS like_count, movie_id FROM ratings GROUP BY movie_id) 
			   AS l
			   ON t.id = l.movie_id
		LEFT JOIN (SELECT SUM(dislikes) AS dislike_count, movie_id FROM ratings GROUP BY movie_id) 
			   AS d
			   ON t.id = d.movie_id
			  
			   ORDER BY title;

			  