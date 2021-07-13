DROP DATABASE IF EXISTS amediamovies;
CREATE DATABASE amediamovies;


DROP TABLE IF EXISTS media_types; -- картинки и видео
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
  	body TEXT,
    filename VARCHAR(255), 	
    `size` INT,
	metadata JSON,

    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100), 
	phone BIGINT UNSIGNED UNIQUE,
	
	INDEX users_email_idx(email),
	INDEX users_phone_idx(phone)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    nickname VARCHAR(50),
    avatar_id BIGINT UNSIGNED NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT NOW(),
	
	INDEX profile_nickname_idx(nickname),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE 
		ON DELETE CASCADE,
	FOREIGN KEY (avatar_id) REFERENCES media(id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	genre VARCHAR(200) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	country VARCHAR(200) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
	id SERIAL PRIMARY KEY,
	company VARCHAR(200) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS directors;
CREATE TABLE directors (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(200),
	lastname VARCHAR(200),
	
	INDEX directors_firstname_lastname_idx (firstname, lastname)
);

DROP TABLE IF EXISTS `cast`;
CREATE TABLE `cast` (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(200),
	lastname VARCHAR(200),
	
	INDEX cast_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS collections;
CREATE TABLE collections (
	id SERIAL PRIMARY KEY, 
	name VARCHAR(200) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS movie_types; -- Типы: фильм, сериал или kino1tv
CREATE TABLE movie_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
	id SERIAL PRIMARY KEY, 
	movie_type BIGINT UNSIGNED,
	title VARCHAR(100) NOT NULL,
    genre BIGINT UNSIGNED,
    directors BIGINT UNSIGNED,
    `cast` BIGINT UNSIGNED,
    country BIGINT UNSIGNED,
    company BIGINT UNSIGNED,
    age_of_viewer ENUM ('0+', '6+', '12+', '16+', '18+') DEFAULT '18+',
    premiere DATE,
    synopsis TEXT,
    poster_id BIGINT UNSIGNED,
    trailer_id BIGINT UNSIGNED,
    video BIGINT UNSIGNED,
    collection_id BIGINT UNSIGNED,
    
    INDEX movies_title_idx(title),
    INDEX movies_genre_idx(genre),
    INDEX movies_country_idx(country),
    INDEX movies_company_idx(company),
    
    FOREIGN KEY (movie_type) REFERENCES movie_types(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (genre) REFERENCES genres(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (directors) REFERENCES directors(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (`cast`) REFERENCES `cast`(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (country) REFERENCES countries(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (company) REFERENCES companies(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (poster_id) REFERENCES media(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY (trailer_id) REFERENCES media(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (video) REFERENCES media(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (collection_id) REFERENCES collections(id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
	id SERIAL PRIMARY KEY, 
	movie_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED,
	likes BIT DEFAULT 0,
	dislikes BIT DEFAULT 0,

	FOREIGN KEY (user_id) REFERENCES profiles(user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (movie_id) REFERENCES movies(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites (
	id SERIAL PRIMARY KEY, 
	user_id BIGINT UNSIGNED NOT NULL, 
	movie_id BIGINT UNSIGNED,
	created_at TIMESTAMP DEFAULT NOW(),

	FOREIGN KEY (user_id) REFERENCES profiles(user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (movie_id) REFERENCES movies(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS history;
CREATE TABLE history (
	id SERIAL PRIMARY KEY, 
	user_id  BIGINT UNSIGNED NOT NULL,
	movie_id BIGINT UNSIGNED,
	`date` DATE,

	FOREIGN KEY (user_id) REFERENCES profiles(user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (movie_id) REFERENCES movies(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
	id SERIAL PRIMARY KEY, 
	user_id BIGINT UNSIGNED NOT NULL,
	subscription_plan VARCHAR(100),
	description TEXT,
	created_at TIMESTAMP DEFAULT NOW(),
	
	INDEX subscriptions_user_id_idx(user_id),
	
	FOREIGN KEY (user_id) REFERENCES profiles(user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

