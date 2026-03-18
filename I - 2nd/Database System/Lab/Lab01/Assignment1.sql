-- 24521943_Tran Anh 

DROP DATABASE Assignment_01;

-- DROP

DROP TABLE IF EXISTS Shipment_for_Project;
DROP TABLE IF EXISTS Shipment;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Part;
DROP TABLE IF EXISTS Supplier;

-- I.Data Definition Language
-- I.1

CREATE TABLE Supplier (
	SNO	   CHAR(2)      PRIMARY KEY,
	SName  VARCHAR(50)  NOT NULL,
	Status INTEGER      NOT NULL,
	City   VARCHAR(50)  NOT NULL
);

CREATE TABLE Part (
	PNO    CHAR(2)       PRIMARY KEY	,
	PName  VARCHAR(50)   NOT NULL,
	Color  VARCHAR(20)   NOT NULL,
	Weight DECIMAL(6,1)  NOT NULL,
	City   VARCHAR(50)   NOT NULL
);

CREATE TABLE Project (
	JNO   CHAR(2)       PRIMARY KEY,
	JName VARCHAR(100)  NOT NULL,
	City  VARCHAR(50)   NOT NULL
);

CREATE TABLE Shipment (
	SNO  CHAR(2)  NOT NULL,
	PNO  CHAR(2)  NOT NULL,
	Qty  INTEGER  NOT NULL,
	PRIMARY KEY (SNO, PNO),
	FOREIGN KEY (SNO) REFERENCES Supplier(SNO),
	FOREIGN KEY (PNO) REFERENCES Part(PNO)
);

CREATE TABLE Shipment_for_Project (
	SNO  CHAR(2)  NOT NULL,
	PNO  CHAR(2)  NOT NULL,
	JNO  CHAR(2)  NOT NULL,	
	Qty  INTEGER  NOT NULL,
	PRIMARY KEY (SNO, PNO, JNO),
	FOREIGN KEY (SNO, PNO) REFERENCES Shipment(SNO, PNO),
	FOREIGN KEY (JNO)      REFERENCES Project(JNO)
);

-- I.2
ALTER TABLE Shipment
	ADD CONSTRAINT check_shipment_qty_positive
	CHECK (Qty > 0);
-- I.3
ALTER TABLE Part
	ADD CONSTRAINT check_bolt_only_in_paris
	CHECK (PName <> 'Bolt' OR City = 'Paris');

-- II. Data Manipulation Language
-- II.1
		
INSERT INTO Supplier (SNO, SName, Status, City) VALUES
('S1', 'Smith', 20, 'London'),
('S2', 'Jones', 10, 'Paris'),
('S3', 'Blake', 30, 'Paris'),
('S4', 'Clark', 20, 'London'),
('S5', 'Adams', 30, 'Athens');
	
INSERT INTO Part (PNO, PName, Color, Weight, City) VALUES
('P1', 'Nut',   'Red',    12.0, 'London'),
('P2', 'Bolt',  'Green',  17.0, 'Paris'),
('P3', 'Screw', 'Blue',   17.0, 'Rome'),
('P4', 'Screw', 'Red',    14.0, 'London'),
('P5', 'Cam',   'Blue',   12.0, 'Paris'),
('P6', 'Cog',   'Red',    19.0, 'London');

INSERT INTO Shipment (SNO, PNO, Qty) VALUES
('S1', 'P1', 300),
('S1', 'P2', 200),
('S1', 'P3', 400),
('S1', 'P4', 200),
('S1', 'P5', 100),
('S1', 'P6', 100),
('S2', 'P1', 300),
('S2', 'P2', 400),
('S3', 'P2', 200),
('S4', 'P2', 200),
('S4', 'P4', 300),
('S4', 'P5', 400);

-- II.2,
INSERT INTO Supplier (SNO, SName, Status, City)
VALUES ('S6', 'Duncan', 30, 'Paris');

-- II.3
UPDATE Supplier
SET City = 'Sydney'
WHERE SNO = 'S6';

-- II.4
UPDATE Supplier
SET Status = Status + 10
WHERE City = 'London';

-- II.5
DELETE FROM Supplier
WHERE SNO = 'S6';

-- III.Data Query Language
-- III.1
SELECT *
FROM Supplier;

-- III.2
SELECT *
FROM Part;

-- III.3
SELECT *
FROM Supplier
WHERE City = 'London';

-- III.4
SELECT PNO, PName, Color
FROM Part
WHERE City = 'Paris';

-- III.5
SELECT PNO, PName
FROM Part
WHERE Weight > 15;

-- III.6
SELECT PNO, PName
FROM Part
WHERE Weight > 15 
	AND ColoR <> 'Red';

-- III.7
SELECT PNO, PName
FROM Part
WHERE Weight > 15 
	AND Color NOT IN ('Red', 'Green');

-- III.8
SELECT PNO, PName
FROM Part
WHERE Weight BETWEEN 15 AND 19
ORDER BY PName;

-- III.9
SELECT DISTINCT p.*
FROM Part p, Shipment s
WHERE p.PNO = s.PNO 
	AND s.SNO = 'S1';

-- III.10
SELECT DISTINCT sup.*
FROM Supplier sup,  Shipment s 
WHERE sup.SNO = s.SNO 
	AND s.PNO = 'P1';

-- III.11
SELECT DISTINCT sup.*
FROM Supplier sup, Shipment s, Part p
WHERE sup.SNO = s.SNO
	AND s.PNO = p.PNO
	AND sup.City = 'London'
	AND p.City = 'London';

-- III.12
SELECT *
FROM Part
WHERE PNO IN (
    SELECT PNO
    FROM Shipment
    WHERE SNO = 'S1'
);

-- III.13
SELECT *
FROM Supplier
WHERE SNO IN (
    SELECT SNO
    FROM Shipment
    WHERE PNO = 'P1'
);

-- III.14
SELECT *
FROM Part p
WHERE EXISTS (
    SELECT 1
    FROM Shipment s
    WHERE s.PNO = p.PNO AND s.SNO = 'S1'
);

-- III.15
SELECT *
FROM Supplier sup
WHERE EXISTS (
	SELECT 1
	FROM Shipment s
	WHERE sup.SNO = s.SNO AND s.PNO = 'P1'
);

-- III.16
SELECT *
FROM Supplier sup
WHERE sup.City = 'London'
	AND sup.SNO IN (
		SELECT s.SNO
		FROM Shipment s
		WHERE s.PNO IN (
			SELECT p.PNO
			FROM Part p
			WHERE p.City = 'London'
		)
	);

-- III.17
SELECT *
FROM Supplier sup
WHERE sup.City = 'London' 
	AND EXISTS (
		SELECT 1
		FROM Shipment s
		WHERE sup.SNO = s.SNO
			AND EXISTS (
				SELECT 1
				FROM Part p
				WHERE p.PNO = s.PNO AND p.City = 'London'
		)
	);

-- III.18
SELECT *
FROM Supplier
WHERE SNO NOT IN (SELECT SNO FROM Shipment);

-- III.19
SELECT *
FROM Supplier sup
WHERE NOT EXISTS (
  SELECT 1 FROM Shipment s WHERE s.SNO = sup.SNO
);

-- III.20
SELECT sup.*
FROM Supplier sup
LEFT JOIN Shipment s ON s.SNO = sup.SNO
WHERE s.SNO IS NULL;

-- III.21
SELECT COUNT(*) AS TotalSuppliers
FROM Supplier;

-- III.22
SELECT COUNT(*) AS SuppliersInLondon
FROM Supplier
WHERE City = 'London'

-- III.23
SELECT MAX(Status) AS MaxStatus, MIN(Status) AS MinStatus
FROM Supplier;

-- III.24
SELECT MAX(Status) AS MaxStatus, MIN(Status) AS MinStatus
FROM Supplier
WHERE City = 'London'

-- III.25
SELECT SNO, SUM(Qty) AS TotalShipped
FROM Shipment
GROUP BY SNO;

-- III.26
SELECT sup.SNO, sup.SName, sup.City, SUM(s.Qty) AS TotalShipped
FROM Supplier sup
JOIN Shipment s ON s.SNO = sup.SNO
GROUP BY sup.SNO, sup.SName, sup.City;

-- ANSWER FOR NOTE: In III.25 we only need sup.SNO only, 
-- but in III.26 we need sup.SNO, sup.SName and sup.City
-- so we need to group by 3 elements, not only sup.SNO

-- III.27
SELECT SNO
FROM Shipment
GROUP BY SNO
HAVING SUM(Qty) > 500;

-- III.28
SELECT s.SNO
FROM Shipment s
JOIN Part p ON p.PNO = s.PNO
WHERE p.Color = 'Red'
GROUP BY s.SNO
HAVING SUM(s.Qty) > 300;

-- III.29
SELECT sup.SNO, sup.SName, sup.City, SUM(s.Qty) AS RedPartsShipped
FROM Supplier sup
JOIN Shipment s ON s.SNO = sup.SNO
JOIN Part p ON s.PNO = p.PNO
WHERE p.Color = 'Red'
GROUP BY sup.SNO, sup.SName, sup.City
HAVING SUM(s.Qty) > 300;
-- ANSWER FOR NOTE: In III.28 we only need sup.SNO only, 
-- but in III.29 we need sup.SNO, sup.SName and sup.City
-- so we need to group by 3 elements, not only sup.SNO

-- III.30
SELECT City, COUNT(*) AS NumSuppliers
FROM Supplier
GROUP BY City;

-- III.31
SELECT TOP 1 WITH TIES 
	sup.SNO, 
	sup.SName, 
	SUM(s.Qty) AS TotalShipped
FROM Supplier sup
JOIN Shipment s ON s.SNO = sup.SNO
GROUP BY sup.SNO, sup.SName
ORDER BY SUM(s.Qty) DESC;

-- III.32
SELECT City
FROM Supplier
UNION
SELECT City
FROM Part
ORDER BY City;