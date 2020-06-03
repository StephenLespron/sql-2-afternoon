--Joins
--#1
SELECT
    *
FROM
    invoice
    JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE
    invoice_line.unit_price > 0.99;

-- #2
SELECT
    i.invoice_date,
    c.first_name,
    c.last_name,
    i.total
FROM
    invoice i
    JOIN customer c ON i.customer_id = c.customer_id;

--#3
SELECT
    c.first_name,
    c.last_name,
    sr.first_name,
    sr.last_name
FROM
    customer c
    JOIN employee sr ON c.support_rep_id = sr.employee_id;

--#4
SELECT
    al.title,
    ar.name
FROM
    album al
    JOIN artist ar ON al.artist_id = ar.artist_id;

--#5
SELECT
    plt.track_id
FROM
    playlist_track plt
    JOIN playlist pl ON pl.playlist_id = plt.playlist_id
WHERE
    pl.name = 'Music';

--#6
SELECT
    tr.name
FROM
    track tr
    JOIN playlist_track plt ON tr.track_id = plt.track_id
WHERE
    plt.playlist_id = 5;

--#7
SELECT
    tr.name,
    pl.name
FROM
    track tr
    JOIN playlist_track plt ON tr.track_id = plt.track_id
    JOIN playlist pl ON plt.playlist_id = pl.playlist_id;

--#8
SELECT
    tr.name,
    al.title
FROM
    album al
    JOIN track tr ON tr.album_id = al.album_id
    JOIN genre g ON tr.genre_id = g.genre_id
WHERE
    g.name = 'Alternative & Punk';

--Black Diamond
--Nested Queries
--#1
SELECT
    *
FROM
    invoice
WHERE
    invoice_id IN (
        SELECT
            invoice_id
        FROM
            invoice_line
        WHERE
            unit_price >.99
    );

--#2
SELECT
    *
FROM
    playlist_track
WHERE
    playlist_id IN(
        SELECT
            playlist_id
        FROM
            playlist
        WHERE
            name = 'Music'
    );

--#3
SELECT
    name
FROM
    track
WHERE
    track_id IN (
        SELECT
            track_id
        FROM
            playlist_track
        WHERE
            playlist_id = 5
    );

--#4
SELECT
    *
FROM
    track
WHERE
    genre_id IN (
        SELECT
            genre_id
        FROM
            genre
        WHERE
            name = 'Comedy'
    );

--5
SELECT
    *
FROM
    track
WHERE
    album_id IN (
        SELECT
            album_id
        FROM
            album
        WHERE
            title = 'Fireball'
    );

--#6
SELECT
    *
FROM
    track
WHERE
    album_id IN (
        SELECT
            album_id
        FROM
            album
        WHERE
            artist_id IN(
                SELECT
                    artist_id
                FROM
                    artist
                WHERE
                    name = 'Queen'
            )
    );

--Updating Rows
--#1
UPDATE
    customer
SET
    fax = NULL
WHERE
    fax IS NOT NULL;

--#2
UPDATE
    customer
SET
    company = 'Self'
WHERE
    company IS NULL;

--#3
UPDATE
    customer
SET
    last_name = 'Thompson'
WHERE
    first_name = 'Julia'
    AND last_name = 'Barnett';

--#4
UPDATE
    customer
SET
    support_rep_id = 4
WHERE
    email = 'luisrojas@yahoo.cl';

--#5
UPDATE
    track
SET
    composer = 'The darkness around us'
WHERE
    composer IS NULL
    AND genre_id IN (
        SELECT
            genre_id
        FROM
            genre
        WHERE
            name = 'Metal'
    );

--Distinct
--#1
SELECT
    DISTINCT composer
FROM
    track;

--#2
SELECT
    DISTINCT billing_postal_code
FROM
    invoice;

--#3
SELECT
    DISTINCT company
FROM
    customer;

--Delete Rows
--#1
DELETE FROM
    practice_delete
WHERE
    TYPE = 'bronze';

--#2
DELETE FROM
    practice_delete
WHERE
    TYPE = 'silver';

--#3
DELETE FROM
    practice_delete
WHERE
    value = '150';

--eCommerce Sim
--#1
CREATE TABLE users (
    user_id serial PRIMARY KEY,
    email varchar (50)
);

CREATE TABLE product (
    product_id serial PRIMARY KEY,
    name varchar(50),
    price integer
);

CREATE TABLE orders (
    order_id serial PRIMARY KEY,
    product_id integer REFERENCES product(product_id)
);

--#2
INSERT INTO
    users (email)
VALUES
    ('stephen@lespy.us'),
    ('alyssa@gmail.com'),
    ('Nathaniel@Minecraft.net');

INSERT INTO
    product(name, price)
VALUES
    ('hot porridge', 10),
    ('cold porridge', 20),
    ('just right porridge', 50);

INSERT INTO
    orders (product_id)
VALUES
    (1),
    (2),
    (3);

--#3
SELECT
    *
FROM
    orders
WHERE
    order_id = 1;

SELECT
    *
FROM
    orders;

SELECT
    sum(p.price)
FROM
    orders o
    JOIN product p ON p.product_id = o.product_id;

--#4
ALTER TABLE
    orders
ADD
    COLUMN user_id integer REFERENCES users(user_id);

--#5
UPDATE
    orders
SET
    user_id = 1
WHERE
    product_id = 1;

UPDATE
    orders
SET
    user_id = 2
WHERE
    product_id = 2;

UPDATE
    orders
SET
    user_id = 3
WHERE
    product_id = 3;

--#6
SELECT
    *
FROM
    orders
WHERE
    user_id = 1;

count(*)
FROM
    orders
WHERE
    user_id IN(1);

count(*)
FROM
    orders
WHERE
    user_id IN(2);

count(*)
FROM
    orders
WHERE
    user_id IN(3);