-- Создание таблиц для музыкального сервиса

-- Таблица Genre
CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица Artist
CREATE TABLE Artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    genre_id INTEGER NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES Genre(id) ON DELETE RESTRICT
);

-- Таблица Album
CREATE TABLE Album (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER CHECK (release_year > 0),
    artist_id INTEGER NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES Artist(id) ON DELETE RESTRICT
);

-- Таблица Track
CREATE TABLE Track (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER CHECK (duration > 0),
    album_id INTEGER NOT NULL,
    FOREIGN KEY (album_id) REFERENCES Album(id) ON DELETE RESTRICT
);

-- Вставка тестовых данных в таблицы музыкального сервиса

-- Вставка данных в Genre
INSERT INTO Genre (name) VALUES
    ('Rock'),
    ('Pop'),
    ('Jazz');

-- Вставка данных в Artist
INSERT INTO Artist (name, genre_id) VALUES
    ('The Beatles', 2), -- Pop
    ('Led Zeppelin', 1), -- Rock
    ('Miles Davis', 3); -- Jazz

-- Вставка данных в Album
INSERT INTO Album (title, release_year, artist_id) VALUES
    ('Abbey Road', 1969, 1), -- The Beatles
    ('Led Zeppelin IV', 1971, 2), -- Led Zeppelin
    ('Kind of Blue', 1959, 3); -- Miles Davis

-- Вставка данных в Track
INSERT INTO Track (title, duration, album_id) VALUES
    ('Come Together', 260, 1), -- Abbey Road
    ('Stairway to Heaven', 480, 2), -- Led Zeppelin IV
    ('So What', 540, 3); -- Kind of Blue

-- Запросы для музыкального сервиса

-- 1. Все исполнители жанра "Rock"
SELECT a.name AS artist_name, g.name AS genre_name
FROM Artist a
JOIN Genre g ON a.genre_id = g.id
WHERE g.name = 'Rock';

-- 2. Все альбомы, выпущенные после 1970 года
SELECT al.title, al.release_year, a.name AS artist_name
FROM Album al
JOIN Artist a ON al.artist_id = a.id
WHERE al.release_year > 1970;

-- 3. Список треков с названием альбома и длительностью
SELECT t.title AS track_title, t.duration, al.title AS album_title
FROM Track t
JOIN Album al ON t.album_id = al.id
ORDER BY t.duration DESC;

-- 4. Количество треков в каждом альбоме
SELECT al.title, COUNT(t.id) AS track_count
FROM Album al
LEFT JOIN Track t ON al.id = t.album_id
GROUP BY al.id, al.title;

-- 5. Общая длительность всех треков в каждом альбоме
SELECT al.title, SUM(t.duration) AS total_duration
FROM Album al
LEFT JOIN Track t ON al.id = t.album_id
GROUP BY al.id, al.title;

-- Создание таблицы сотрудников

CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0)
);

-- Вставка тестовых данных в Employee
INSERT INTO Employee (name, department, salary) VALUES
    ('John Doe', 'Marketing', 50000.00),
    ('Jane Smith', 'IT', 60000.00),
    ('Mike Johnson', 'Support', 45000.00);

-- Запросы для сотрудников

-- 1. Сотрудники из отдела IT
SELECT name, department, salary
FROM employee
WHERE department = 'IT';

-- 2. Сотрудники с зарплатой выше 50000
SELECT name, department, salary
FROM employee
WHERE salary > 50000
ORDER BY salary DESC;

-- 3. Средняя зарплата и количество сотрудников по каждому отделу
SELECT department, AVG(salary) AS average_salary, COUNT(*) AS employee_count
FROM employee
GROUP BY department;