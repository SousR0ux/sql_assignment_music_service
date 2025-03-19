-- Таблица жанров
CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица исполнителей
CREATE TABLE Artist (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Промежуточная таблица "Исполнители - Жанры" (многие ко многим)
CREATE TABLE ArtistGenre (
    artist_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (artist_id, genre_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genre(id) ON DELETE CASCADE
);

-- Таблица альбомов
CREATE TABLE Album (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER CHECK (release_year > 0)
);

-- Промежуточная таблица "Исполнители - Альбомы" (многие ко многим)
CREATE TABLE ArtistAlbum (
    artist_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL,
    PRIMARY KEY (artist_id, album_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES Album(id) ON DELETE CASCADE
);

-- Таблица треков
CREATE TABLE Track (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER CHECK (duration > 0),
    album_id INTEGER NOT NULL,
    FOREIGN KEY (album_id) REFERENCES Album(id) ON DELETE CASCADE
);

-- Таблица сборников (компиляций)
CREATE TABLE Compilation (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER CHECK (release_year > 0)
);

-- Промежуточная таблица "Сборники - Треки" (многие ко многим)
CREATE TABLE CompilationTrack (
    compilation_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    PRIMARY KEY (compilation_id, track_id),
    FOREIGN KEY (compilation_id) REFERENCES Compilation(id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES Track(id) ON DELETE CASCADE
);

-- Вставка данных в Genre
INSERT INTO Genre (name) VALUES
    ('Rock'),
    ('Pop'),
    ('Jazz');

-- Вставка данных в Artist
INSERT INTO Artist (name) VALUES
    ('The Beatles'),
    ('Led Zeppelin'),
    ('Miles Davis');

-- Вставка данных в ArtistGenre
INSERT INTO ArtistGenre (artist_id, genre_id) VALUES
    (1, 2), -- The Beatles - Pop
    (2, 1), -- Led Zeppelin - Rock
    (3, 3); -- Miles Davis - Jazz

-- Вставка данных в Album
INSERT INTO Album (title, release_year) VALUES
    ('Abbey Road', 1969),
    ('Led Zeppelin IV', 1971),
    ('Kind of Blue', 1959);

-- Вставка данных в ArtistAlbum
INSERT INTO ArtistAlbum (artist_id, album_id) VALUES
    (1, 1), -- The Beatles - Abbey Road
    (2, 2), -- Led Zeppelin - Led Zeppelin IV
    (3, 3); -- Miles Davis - Kind of Blue

-- Вставка данных в Track
INSERT INTO Track (title, duration, album_id) VALUES
    ('Come Together', 260, 1),
    ('Stairway to Heaven', 480, 2),
    ('So What', 540, 3);

-- Вставка данных в Compilation
INSERT INTO Compilation (title, release_year) VALUES
    ('Best of Rock', 2020),
    ('Jazz Classics', 2018);

-- Вставка данных в CompilationTrack
INSERT INTO CompilationTrack (compilation_id, track_id) VALUES
    (1, 2), -- "Stairway to Heaven" в "Best of Rock"
    (2, 3); -- "So What" в "Jazz Classics"
