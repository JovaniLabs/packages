-- *** The Lost Letter ***
SELECT *
FROM addresses
WHERE address LIKE "900 Somerville Avenue%";

--+-----+-----------------------+-------------+
--| id  |        address        |    type     |
--+-----+-----------------------+-------------+
--| 432 | 900 Somerville Avenue | Residential |
--+-----+-----------------------+-------------+

SELECT *
FROM packages
WHERE from_address_id = (
    SELECT id
    FROM addresses
    WHERE address LIKE "900 Somerville Avenue%"
);

--+------+-----------------------+-----------------+---------------+
--|  id  |       contents        | from_address_id | to_address_id |
--+------+-----------------------+-----------------+---------------+
--| 384  | Congratulatory letter | 432             | 854           |
--| 2437 | String                | 432             | 484           |
--| 3529 | Letter opener         | 432             | 585           |
--| 5436 | Whiteboard            | 432             | 4984          |
--+------+-----------------------+-----------------+---------------+

SELECT * FROM addresses Where id = '854';

--+-----+-------------------+-------------+
--| id  |      address      |    type     |
--+-----+-------------------+-------------+
--| 854 | 2 Finnigan Street | Residential |
--+-----+-------------------+-------------+

SELECT * FROM scans WHERE package_id = (
    SELECT id FROM packages WHERE id = '384'
);

--+----+-----------+------------+------------+--------+----------------------------+
--| id | driver_id | package_id | address_id | action |         timestamp          |
--+----+-----------+------------+------------+--------+----------------------------+
--| 54 | 1         | 384        | 432        | Pick   | 2023-07-11 19:33:55.241794 |
--| 94 | 1         | 384        | 854        | Drop   | 2023-07-11 23:07:04.432178 |
--+----+-----------+------------+------------+--------+----------------------------+



-- *** The Devious Delivery ***

SELECT * FROM packages WHERE from_address_id is NULL;

--+------+---------------+-----------------+---------------+
--|  id  |   contents    | from_address_id | to_address_id |
--+------+---------------+-----------------+---------------+
--| 5098 | Duck debugger | NULL            | 50            |
--+------+---------------+-----------------+---------------+

SELECT * FROM addresses WHERE id = 50;

--+-------+-----------+------------+------------+--------+----------------------------+
--|  id   | driver_id | package_id | address_id | action |         timestamp          |
--+-------+-----------+------------+------------+--------+----------------------------+
--| 30123 | 10        | 5098       | 50         | Pick   | 2023-10-24 08:40:16.246648 |
--| 43690 | 4         | 5646       | 50         | Drop   | 2023-12-10 04:49:03.557839 |
--+-------+-----------+------------+------------+--------+----------------------------+

SELECT * FROM scans WHERE package_id = 5098;

--+-------+-----------+------------+------------+--------+----------------------------+
--|  id   | driver_id | package_id | address_id | action |         timestamp          |
--+-------+-----------+------------+------------+--------+----------------------------+
--| 30123 | 10        | 5098       | 50         | Pick   | 2023-10-24 08:40:16.246648 |
--| 30140 | 10        | 5098       | 348        | Drop   | 2023-10-24 10:08:55.610754 |
--+-------+-----------+------------+------------+--------+----------------------------+

SELECT * FROM addresses WHERE id = 348;

--+-----+------------------+----------------+
--| id  |     address      |      type      |
--+-----+------------------+----------------+
--| 348 | 7 Humboldt Place | Police Station |
--+-----+------------------+----------------+



-- *** The Forgotten Gift ***

SELECT * FROM addresses WHERE address = "109 Tileston Street";

--+------+-----------------+-------------+
--|  id  |     address     |    type     |
--+------+-----------------+-------------+
--| 4983 | 728 Maple Place | Residential |
--+------+-----------------+-------------+

SELECT * FROM packages WHERE to_address_id = 4983;

--+------+----------+-----------------+---------------+
--|  id  | contents | from_address_id | to_address_id |
--+------+----------+-----------------+---------------+
--| 9523 | Flowers  | 9873            | 4983          |
--+------+----------+-----------------+---------------+

SELECT * FROM scans WHERE package_id = 9523;

--+-------+-----------+------------+------------+--------+----------------------------+
--|  id   | driver_id | package_id | address_id | action |         timestamp          |
--+-------+-----------+------------+------------+--------+----------------------------+
--| 10432 | 11        | 9523       | 9873       | Pick   | 2023-08-16 21:41:43.219831 |
--| 10500 | 11        | 9523       | 7432       | Drop   | 2023-08-17 03:31:36.856889 |
--| 12432 | 17        | 9523       | 7432       | Pick   | 2023-08-23 19:41:47.913410 |
--+-------+-----------+------------+------------+--------+----------------------------+

SELECT * FROM drivers WHERE id = 17;

--+----+-------+
--| id | name  |
--+----+-------+
--| 17 | Mikel |
--+----+-------+
