-- Fix the bellow code to create the tables with the appropriate constraints
DROP TABLE IF EXISTS s_region;
DROP TABLE IF EXISTS s_dept;
DROP TABLE IF EXISTS s_emp;
DROP TABLE IF EXISTS s_product;
DROP TABLE IF EXISTS s_customer;
DROP TABLE IF EXISTS s_warehouse;
DROP TABLE IF EXISTS s_ord;
DROP TABLE IF EXISTS s_item;
DROP TABLE IF EXISTS s_inventory;

CREATE TABLE s_region
(
    id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE s_dept
(
    id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    region_id VARCHAR(255),
    PRIMARY KEY (id),
    UNIQUE (name, region_id),
    FOREIGN KEY (region_id) REFERENCES s_region (id)
);

CREATE TABLE s_emp
(
    id VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    userid VARCHAR(255) NOT NULL,
    start_date DATETIME NOT NULL,
    comments VARCHAR(255),
    title VARCHAR(255),
    salary NUMERIC(11, 2),
    commission_pct NUMERIC(4, 2),
    dept_id VARCHAR(255),
    manager_id VARCHAR(255),
    PRIMARY KEY (id),
    UNIQUE (userid),
    FOREIGN KEY (dept_id) REFERENCES s_dept (id),
    FOREIGN KEY (manager_id) REFERENCES s_emp (id)
);

CREATE TABLE s_product
(
    id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    short_desc VARCHAR(255),
    suggested_whlsl_price NUMERIC(11, 2),
    whlsl_units VARCHAR(255),
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE s_customer
(
    id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    zip_code VARCHAR(255),
    credit_rating VARCHAR(255),
    comments VARCHAR(255),
    region_id VARCHAR(255),
    sales_rep_id VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (region_id) REFERENCES s_region (id),
    FOREIGN KEY (sales_rep_id) REFERENCES s_emp (id)
);

CREATE TABLE s_warehouse
(
    id VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    zip_code VARCHAR(255),
    phone VARCHAR(255),
    region_id VARCHAR(255),
    manager_id VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (region_id) REFERENCES s_region (id),
    FOREIGN KEY (manager_id) REFERENCES s_emp (id)
);

CREATE TABLE s_ord
(
    id VARCHAR(255) NOT NULL,
    date_ordered DATETIME NOT NULL,
    date_shipped DATETIME,
    total NUMERIC(11, 2),
    payment_type VARCHAR(255) NOT NULL,
    order_filled VARCHAR(255),
    customer_id VARCHAR(255),
    sales_rep_id VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES s_customer (id),
    FOREIGN KEY (sales_rep_id) REFERENCES s_emp (id)
);

CREATE TABLE s_item
(
    item_id VARCHAR(255) NOT NULL,
    price NUMERIC(11, 2),
    quantity NUMERIC(9),
    quantity_shipped NUMERIC(9),
    ord_id VARCHAR(255) NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (item_id, ord_id),
    FOREIGN KEY (ord_id) REFERENCES s_ord (id),
    FOREIGN KEY (product_id) REFERENCES s_product (id)
);

CREATE TABLE s_inventory
(
    s_product_id VARCHAR(255) NOT NULL,
    s_warehouse_id VARCHAR(255) NOT NULL,
    amount_in_stock NUMERIC(9),
    reorder_point NUMERIC(9),
    max_in_stock NUMERIC(9),
    out_of_stock_explanation VARCHAR(255),
    restock_date DATETIME,
    PRIMARY KEY (s_product_id, s_warehouse_id),
    FOREIGN KEY (s_product_id) REFERENCES s_product (id),
    FOREIGN KEY (s_warehouse_id) REFERENCES s_warehouse (id)
);

INSERT INTO s_region
VALUES(3, 'Africa / Middle East')
INSERT INTO s_region
VALUES(4, 'Asia')
INSERT INTO s_region
VALUES(6, 'Central America /Caribbean')
INSERT INTO s_region
VALUES(5, 'Europe')
INSERT INTO s_region
VALUES(1, 'North America')
INSERT INTO s_region
VALUES(2, 'South America')

INSERT INTO s_dept
VALUES('50', 'Administration', 1)
INSERT INTO s_dept
VALUES('10', 'Finance', 1)
INSERT INTO s_dept
VALUES('41', 'Operations', 1)
INSERT INTO s_dept
VALUES('42', 'Operations', 2)
INSERT INTO s_dept
VALUES('43', 'Operations', 3)
INSERT INTO s_dept
VALUES('44', 'Operations', 4)
INSERT INTO s_dept
VALUES('45', 'Operations', 5)
INSERT INTO s_dept
VALUES('31', 'Sales', 1)
INSERT INTO s_dept
VALUES('32', 'Sales', 2)
INSERT INTO s_dept
VALUES('33', 'Sales', 3)
INSERT INTO s_dept
VALUES('34', 'Sales', 4)
INSERT INTO s_dept
VALUES('35', 'Sales', 5)

INSERT INTO s_emp
VALUES('1', 'Martin', 'Carmen', 'martincu', '1990-03-03', 'NULL', 'President', 4500, NULL, '50', NULL)
INSERT INTO s_emp
VALUES('2', 'Smith', 'Doris', 'smithdj', '1990-03-08', 'NULL', 'VP, Operations', 2450, NULL, '41', 1)
INSERT INTO s_emp
VALUES('3', 'Norton', 'Michael', 'nortonma', '1991-06-17 ', 'NULL', 'VP, Sales', 2400, NULL, '31', 1)
INSERT INTO s_emp
VALUES('4', 'Quentin', 'Mark', 'quentiml', '1990-04-07', 'NULL', 'VP, Finance', 2450, NULL, '10', 1)
INSERT INTO s_emp
VALUES('5', 'Roper', 'Joseph', 'roperjm', '1990-03-04 ', 'NULL', 'VP, Administration', 2550, NULL, '50', 1)
INSERT INTO s_emp
VALUES('6', 'Brown', 'Molly', 'brownmr', '1991-01-18', 'NULL', 'Warehouse Manager', 1600, NULL, '41', 2)
INSERT INTO s_emp
VALUES('7', 'Hawkins', 'Roberta', 'hawkinrt', '1990-05-14 ', 'NULL', 'Warehouse Manager', 1650, NULL, '42', 2)
INSERT INTO s_emp
VALUES('8', 'Burns', 'Ben', 'burnsba', '1990-04-07 ', 'NULL', 'Warehouse Manager', 1500, NULL, '43', 2)
INSERT INTO s_emp
VALUES('9', 'Catskill', 'Antoinette', 'catskiaw', '1992-02-09 ', 'NULL', 'Warehouse Manager', 1700, NULL, '44', 2)
INSERT INTO s_emp
VALUES('10', 'Jackson', 'Marta', 'jacksomt', '1991-02-27 ', 'NULL', 'Warehouse Manager', 1507, NULL, '45', 2)
INSERT INTO s_emp
VALUES('11', 'Henderson', 'Colin', 'hendercs', '1990-05-14', 'NULL', 'Sales Representative', 1400, 10.00, '31', 3)
INSERT INTO s_emp
VALUES('12', 'Gilson', 'Sam', 'gilsonsj', '1992-01-18 ', 'NULL', 'Sales Representative', 1490, 12.50, '32', 3)
INSERT INTO s_emp
VALUES('13', 'Sanders', 'Jason', 'sanderjk', '1991-02-18 ', 'NULL', 'Sales Representative', 1515, 10.00, '33', 3)
INSERT INTO s_emp
VALUES('14', 'Dameron', 'Andre', 'dameroap', '1991-10-09 ', 'NULL', 'Sales Representative', 1450, 17.50, '35', 3)
INSERT INTO s_emp
VALUES('15', 'Hardwick', 'Elaine', 'hardwiem', '1992-02-07 ', 'NULL', 'Stock Clerk', 1400, NULL, '41', 6)
INSERT INTO s_emp
VALUES('16', 'Brown', 'George', 'browngw', '1990-03-08 ', 'NULL', 'Stock Clerk', 940, NULL, '41', 6)
INSERT INTO s_emp
VALUES('17', 'Washington', 'Thomas', 'washintl', '1991-02-09 ', 'NULL', 'Stock Clerk', 1200, NULL, '42', 7)
INSERT INTO s_emp
VALUES('18', 'Patterson', 'Donald', 'patterdv', '1991-08-06 ', 'NULL', 'Stock Clerk', 795, NULL, '42', 7)
INSERT INTO s_emp
VALUES('19', 'Bell', 'Alexander', 'bellag', '1991-05-26', 'NULL', 'Stock Clerk', 850, NULL, '43', 8)
INSERT INTO s_emp
VALUES('20', 'Gantos', 'Eddie', 'gantosej', '1990-11-30', 'NULL', 'Stock Clerk', 800, NULL, '44', 9)
INSERT INTO s_emp
VALUES('21', 'Stephenson', 'Blaine', 'stephebs', '1991-03-17', 'NULL', 'Stock Clerk', 860, NULL, '45', 10)
INSERT INTO s_emp
VALUES('22', 'Chester', 'Eddie', 'chesteek', '1990-11-30 ', 'NULL', 'Stock Clerk', 800, NULL, '44', 9)
INSERT INTO s_emp
VALUES('23', 'Pearl', 'Roger', 'pearlrg', '1990-10-17', 'NULL', 'Stock Clerk', 795, NULL, '34', 9)
INSERT INTO s_emp
VALUES('24', 'Dancer', 'Bonnie', 'dancerbw', '1991-03-17 ', 'NULL', 'Stock Clerk', 860, NULL, '45', 7)
INSERT INTO s_emp
VALUES('25', 'Schmitt', 'Sandra', 'schmitss', '1991-05-09 ', 'NULL', 'Stock Clerk', 1100, NULL, '45', 8)

--insert to s_product table
INSERT INTO s_product
VALUES('10011', 'Bunny Boot', 'Beginner''s ski boot', 150.00, NULL);
INSERT INTO s_product
VALUES('10012', 'Ace Ski Boot', 'Intermediate ski boot', 200.00, NULL);
INSERT INTO s_product
VALUES('10013', 'Pro Ski Boot', 'Advanced ski boot', 410.00, NULL);
INSERT INTO s_product
VALUES('10021', 'Bunny Ski Pole', 'Beginner''s ski pole', 16.25, NULL);
INSERT INTO s_product
VALUES('10022', 'Ace Ski Pole', 'Intermediate ski pole', 21.95, NULL);
INSERT INTO s_product
VALUES('10023', 'Pro Ski Pole', 'Advanced ski pole', 40.95, NULL);
INSERT INTO s_product
VALUES('20106', 'Junior Soccer Ball', 'Junior soccer ball', 11.00, NULL);
INSERT INTO s_product
VALUES('20108', 'World Cup Soccer Ball', 'World cup soccer ball', 28.00, NULL);
INSERT INTO s_product
VALUES('20201', 'World Cup Net', 'World cup net', 123.00, NULL);
INSERT INTO s_product
VALUES('20510', 'Black Hawk Knee Pads', 'Knee pads, pair', 9.00, NULL);
INSERT INTO s_product
VALUES('20512', 'Black Hawk Elbow Pads', 'Elbow pads, pair', 8.00, NULL);
INSERT INTO s_product
VALUES('30321', 'Grand Prix Bicycle', 'Road bicycle', 1669.00, NULL);
INSERT INTO s_product
VALUES('30326', 'Himalaya Bicycle', 'Mountain bicycle', 582.00, NULL);
INSERT INTO s_product
VALUES('30421', 'Grand Prix Bicycle Tires', 'Road bicycle tires', 16.00, NULL);
INSERT INTO s_product
VALUES('30426', 'Himalaya Tires', 'Mountain bicycle tires', 18.25, NULL);
INSERT INTO s_product
VALUES('30433', 'New Air Pump', 'Tire pump', 20.00, NULL);
INSERT INTO s_product
VALUES('32779', 'Slaker Water Bottle', 'Water bottle', 7.00, NULL);
INSERT INTO s_product
VALUES('32861', 'Safe-T Helmet', 'Bicycle helmet', 60.00, NULL);
INSERT INTO s_product
VALUES('40421', 'Alexeyer Pro Lifting Bar', 'Straight bar', 65.00, NULL);
INSERT INTO s_product
VALUES('40422', 'Pro Curling Bar', 'Curling bar', 50.00, NULL);
INSERT INTO s_product
VALUES('41010', 'Prostar 10 Pound Weight', 'Ten pound weight', 8.00, NULL);
INSERT INTO s_product
VALUES('41020', 'Prostar 20 Pound Weight', 'Twenty pound weight', 12.00, NULL);
INSERT INTO s_product
VALUES('41050', 'Prostar 50 Pound Weight', 'Fifty pound weight', 25.00, NULL);
INSERT INTO s_product
VALUES('41080', 'Prostar 80 Pound Weight', 'Eighty pound weight', 35.00, NULL);
INSERT INTO s_product
VALUES('41100', 'Prostar 100 Pound Weight', 'One hundred pound weight', 45.00, NULL);
INSERT INTO s_product
VALUES('50169', 'Major League Baseball', 'Baseball', 4.29, NULL);
INSERT INTO s_product
VALUES('50273', 'Chapman Helmet', 'Batting helmet', 22.89, NULL);
INSERT INTO s_product
VALUES('50417', 'Griffey Glove', 'Outfielder''s glove', 80.00, NULL);
INSERT INTO s_product
VALUES('50418', 'Alomar Glove', 'Infielder''s glove', 75.00, NULL);
INSERT INTO s_product
VALUES('50419', 'Steinbach Glove', 'Catcher''s glove', 80.00, NULL);
INSERT INTO s_product
VALUES('50530', 'Cabrera Bat', 'Thirty inch bat', 45.00, NULL);
INSERT INTO s_product
VALUES('50532', 'Puckett Bat', 'Thirty-two inch bat', 47.00, NULL);
INSERT INTO s_product
VALUES('50536', 'Winfield Bat', 'Thirty-six inch bat', 50.00, NULL);

INSERT INTO s_customer
VALUES('201', 'One Sport', '55-112066222', '82 Via Bahia', 'Sao Paolo', 'NULL', 'Brazil', NULL, 'EXCELLENT', 'NULL', 2, 12)
INSERT INTO s_customer
VALUES('202', 'Deportivo Caracas', '58-28066222', '31 Sabana Grande', 'Caracas', 'NULL', 'Venezuela', NULL, 'EXCELLENT', 'NULL', 2, 12)
INSERT INTO s_customer
VALUES('203', 'New Delhi Sports', '91-11903338', '11368 Chanakya', 'New Delhi', 'NULL', 'India', NULL, 'GOOD', 'NULL', 4, 11)
INSERT INTO s_customer
VALUES('204', 'Ladysport', '1-206-104-0111', '281 Queen Street', 'Seattle', 'Washington', 'US', NULL, 'EXCELLENT', 'NULL', 1, 11)
INSERT INTO s_customer
VALUES('205', 'Kim''s Sporting Goods', '852-3693888', '15 Henessey Road', 'Hong Kong', NULL, NULL, NULL, 'EXCELLENT', NULL, 4, 11)
INSERT INTO s_customer
VALUES('206', 'Sportique', '33-93425722253', '172 Rue de Place', 'Cannes', NULL, 'France', NULL, 'EXCELLENT', NULL, 5, 13)
INSERT INTO s_customer
VALUES('207', 'Tall Rock Sports', '234-16036222', '10 Saint Antoine', 'Lagos', NULL, 'Nigeria', NULL, 'GOOD', NULL, 3, NULL)
INSERT INTO s_customer
VALUES('208', 'Muench Sports', '49-895274449', '435 Gruenestrasse', 'Munich', NULL, 'Germany', NULL, 'GOOD', NULL, 5, 13)
INSERT INTO s_customer
VALUES('209', 'Beisbol Si!', '809-352666', '415 Playa Del Mar', 'San Pedro de Macoris', NULL, 'Dominican Republic', NULL, 'EXCELLENT', NULL, 6, 11)
INSERT INTO s_customer
VALUES('210', 'Futbol Sonora', '52-404555', '5 Via Saguaro', 'Nogales', NULL, 'Mexico', NULL, 'EXCELLENT', NULL, 2, 12)
INSERT INTO s_customer
VALUES('211', 'Helmut''s Sports', '42-2111222', '45 Modrany', 'Prague', NULL, 'Czechoslovakia', NULL, 'EXCELLENT', NULL, 5, 11)
INSERT INTO s_customer
VALUES('212', 'Hamada Sport', '20-31209222', '47A Corniche', 'Alexandria', 'NULL', 'Egypt', NULL, 'EXCELLENT', 'NULL', 3, 13)
INSERT INTO s_customer
VALUES('213', 'Sports Emporium', '1-415-555-6281', '4783 168th Street', 'San Francisco', 'CA', 'US', NULL, 'EXCELLENT', 'NULL', 1, 11)
INSERT INTO s_customer
VALUES('214', 'Sports Retail', '1-716-555-7777', '115 Main Street', 'Buffalo', 'NY', 'US', NULL, 'POOR', 'NULL', 1, 11)
INSERT INTO s_customer
VALUES('215', 'Sports Russia', '7-0953892444', '7070 Yekatamina', 'Saint Petersburg', 'NULL', 'Russia', NULL, 'POOR', 'NULL', 5, 11)
INSERT INTO s_customer
VALUES('301', 'Sports,Inc', '540-123-4567', '72 High St', 'Harrisonburg', 'VA', 'US', 22809, 'EXCELLENT', 'NULL', 1, 12)
INSERT INTO s_customer
VALUES('302', 'Toms Sporting Goods', '540-987-6543', '6741 Main St', 'Harrisonburg', 'VA', 'US', 22809, 'POOR', 'NULL', 1, 14)
INSERT INTO s_customer
VALUES('303', 'Athletic Attire', '540-123-6789', '54 Market St', 'Harrisonburg', 'VA', 'US', 22808, 'GOOD', 'NULL', 1, 14)
INSERT INTO s_customer
VALUES('304', 'Athletics For All', '540-987-1234', '286 Main St', 'Harrisonburg', 'VA', 'US', 22808, 'EXCELLENT', 'NULL', 1, 12)
INSERT INTO s_customer
VALUES('305', 'Shoes for Sports', '540-123-9876', '538 High St', 'Harrisonburg', 'VA', 'US', 22809, 'EXCELLENT', 'NULL', 1, 14)
INSERT INTO s_customer
VALUES('306', 'BJ Athletics', '540-987-9999', '632 Water St', 'Harrisonburg', 'VA', 'US', 22810, 'POOR', 'NULL', 1, 12)
INSERT INTO s_customer
VALUES('403', 'Athletics One', '717-234-6786', '912 Columbia Rd', 'Lancaster', 'PA', 'US', 17601, 'GOOD', 'NULL', 1, 14)
INSERT INTO s_customer
VALUES('404', 'Great Athletes', '717-987-2341', '121 Litiz Pike', 'Lancaster', 'PA', 'US', 17602, 'EXCELLENT', 'NULL', 1, 12)
INSERT INTO s_customer
VALUES('405', 'Athletics Two', '717-987-9875', '435 High Rd', 'Lancaster', 'PA', 'US', 17602, 'EXCELLENT', 'NULL', 1, 14)
INSERT INTO s_customer
VALUES('406', 'Athletes Attic', '717-234-9888', '101 Greenfield Rd', 'Lancaster', 'PA', 'US', 17601, 'POOR', 'NULL', 1, 12)

INSERT INTO s_warehouse
VALUES('101', '283 King Street', 'Seattle', 'WA', 'US', NULL, NULL, 1, 6);
INSERT INTO s_warehouse
VALUES('10501', '5 Modrany', 'Bratislava', 'NULL', 'Czechozlovakia', NULL, NULL, 5, 10);
INSERT INTO s_warehouse
VALUES('201', '68 Via Centrale', 'Sao Paolo', 'NULL', 'Brazil', NULL, NULL, 2, 7);
INSERT INTO s_warehouse
VALUES('301', '6921 King Way', 'Lagos', 'NULL', 'Nigeria', NULL, NULL, 3, 8);
INSERT INTO s_warehouse
VALUES('401', '86 Chu Street', 'Hong Kong', 'NULL', 'NULL', NULL, NULL, 4, 9);


INSERT INTO s_ord
VALUES(100, '1992-08-31 ', '1992-09-10 ', 601100.00, 'CREDIT', 'Y', 204, 11);
INSERT INTO s_ord
VALUES(101, '1992-08-31 ', '1992-09-15 ', 8056.60, 'CREDIT', 'Y', 205, 14);
INSERT INTO s_ord
VALUES(102, '1992-09-01 ', '1992-09-08 ', 8335.00, 'CREDIT', 'Y', 206, 12);
INSERT INTO s_ord
VALUES(103, '1992-09-02 ', '1992-09-22 ', 377.00, 'CASH', 'Y', 208, 11);
INSERT INTO s_ord
VALUES(104, '1992-09-03 ', '1992-09-23 ', 32430.00, 'CREDIT', 'Y', 208, 13);
INSERT INTO s_ord
VALUES(105, '1992-09-04 ', '1992-09-18 ', 2722.24, 'CREDIT', 'Y', 209, 11);
INSERT INTO s_ord
VALUES(106, '1992-09-07 ', '1992-09-15 ', 15634.00, 'CREDIT', 'Y', 210, 12);
INSERT INTO s_ord
VALUES(107, '1992-09-07 ', '1992-09-21 ', 142171.00, 'CREDIT', 'Y', 211, 14);
INSERT INTO s_ord
VALUES(108, '1992-09-07 ', '1992-09-10 ', 149570.00, 'CREDIT', 'Y', 212, 13);
INSERT INTO s_ord
VALUES(109, '1992-09-08 ', '1992-09-28 ', 1020935.00, 'CREDIT', 'Y', 213, 11);
INSERT INTO s_ord
VALUES(110, '1992-09-09 ', '1992-09-21 ', 1539.13, 'CASH', 'Y', 214, 11);
INSERT INTO s_ord
VALUES(111, '1992-09-09 ', '1992-09-21 ', 2770.00, 'CASH', 'Y', 204, 11);
INSERT INTO s_ord
VALUES(112, '1992-08-31 ', '1992-09-10 ', 550.00, 'CREDIT', 'Y', 210, 12);
INSERT INTO s_ord
VALUES(97, '1992-08-28 ', '1992-09-17 ', 84000.00, 'CREDIT', 'Y', 201, 12);
INSERT INTO s_ord
VALUES(98, '1992-08-31 ', '1992-09-10 ', 595.00, 'CASH', 'Y', 202, 14);
INSERT INTO s_ord
VALUES(99, '1992-08-31 ', '1992-09-18 ', 7707.00, 'CREDIT', 'Y', 203, 14);

INSERT INTO s_item
VALUES('1', '135', '500', '500', '100', '10011');
INSERT INTO s_item
VALUES('1', '16', '15', '15', '101', '30421');
INSERT INTO s_item
VALUES('1', '28', '100', '100', '102', '20108');
INSERT INTO s_item
VALUES('1', '20', '15', '15', '103', '30433');
INSERT INTO s_item
VALUES('1', '9', '7', '7', '104', '20510');
INSERT INTO s_item
VALUES('1', '22.89', '16', '16', '105', '50273');
INSERT INTO s_item
VALUES('1', '28', '46', '46', '106', '20108');
INSERT INTO s_item
VALUES('1', '11', '50', '50', '107', '20106');
INSERT INTO s_item
VALUES('1', '9', '9', '9', '108', '20510');
INSERT INTO s_item
VALUES('1', '140', '150', '150', '109', '10011');
INSERT INTO s_item
VALUES('1', '22.89', '17', '17', '110', '50273');
INSERT INTO s_item
VALUES('1', '65', '27', '27', '111', '40421');
INSERT INTO s_item
VALUES('1', '11', '50', '50', '112', '20106');
INSERT INTO s_item
VALUES('1', '9', '1000', '1000', '97', '20106');
INSERT INTO s_item
VALUES('1', '85', '7', '7', '98', '40421');
INSERT INTO s_item
VALUES('1', '9', '18', '18', '99', '20510');
INSERT INTO s_item
VALUES('2', '380', '400', '400', '100', '10013');
INSERT INTO s_item
VALUES('2', '50', '30', '30', '101', '40422');
INSERT INTO s_item
VALUES('2', '123', '45', '45', '102', '20201');
INSERT INTO s_item
VALUES('2', '7', '11', '11', '103', '32779');
INSERT INTO s_item
VALUES('2', '8', '12', '12', '104', '20512');
INSERT INTO s_item
VALUES('2', '80', '13', '13', '105', '50419');
INSERT INTO s_item
VALUES('2', '123', '21', '21', '106', '20201');
INSERT INTO s_item
VALUES('2', '28', '22', '22', '107', '20108');
INSERT INTO s_item
VALUES('2', '8', '18', '18', '108', '20512');
INSERT INTO s_item
VALUES('2', '175', '600', '600', '109', '10012');
INSERT INTO s_item
VALUES('2', '50', '23', '23', '110', '50536');
INSERT INTO s_item
VALUES('2', '35', '29', '29', '111', '41080');
INSERT INTO s_item
VALUES('2', '1500', '50', '50', '97', '30321');
INSERT INTO s_item
VALUES('2', '8', '25', '25', '99', '20512');
INSERT INTO s_item
VALUES('3', '14', '500', '500', '100', '10021');
INSERT INTO s_item
VALUES('3', '8', '20', '20', '101', '41010');
INSERT INTO s_item
VALUES('3', '1669', '19', '19', '104', '30321');
INSERT INTO s_item
VALUES('3', '47', '28', '28', '105', '50532');
INSERT INTO s_item
VALUES('3', '4.29', '125', '125', '106', '50169');
INSERT INTO s_item
VALUES('3', '115', '130', '130', '107', '20201');
INSERT INTO s_item
VALUES('3', '1669', '85', '85', '108', '30321');
INSERT INTO s_item
VALUES('3', '21.95', '300', '300', '109', '10022');
INSERT INTO s_item
VALUES('3', '80', '53', '53', '99', '50417');
INSERT INTO s_item
VALUES('4', '36', '400', '400', '100', '10023');
INSERT INTO s_item
VALUES('4', '45', '35', '35', '101', '41100');
INSERT INTO s_item
VALUES('4', '16', '35', '35', '104', '30421');
INSERT INTO s_item
VALUES('4', '22.89', '75', '75', '106', '50273');
INSERT INTO s_item
VALUES('4', '1669', '75', '75', '107', '30321');
INSERT INTO s_item
VALUES('4', '7', '60', '60', '108', '32779');
INSERT INTO s_item
VALUES('4', '582', '1500', '1500', '109', '30326');
INSERT INTO s_item
VALUES('4', '45', '69', '69', '99', '50530');
INSERT INTO s_item
VALUES('5', '582', '600', '600', '100', '30326');
INSERT INTO s_item
VALUES('5', '4.29', '40', '40', '101', '50169');
INSERT INTO s_item
VALUES('5', '75', '98', '98', '106', '50418');
INSERT INTO s_item
VALUES('5', '16', '55', '55', '107', '30421');
INSERT INTO s_item
VALUES('5', '60', '57', '57', '108', '32861');
INSERT INTO s_item
VALUES('5', '18.25', '500', '500', '109', '30426');
INSERT INTO s_item
VALUES('6', '20', '450', '450', '100', '30433');
INSERT INTO s_item
VALUES('6', '80', '27', '27', '101', '50417');
INSERT INTO s_item
VALUES('6', '80', '27', '27', '106', '50419');
INSERT INTO s_item
VALUES('6', '35', '50', '50', '108', '41080');
INSERT INTO s_item
VALUES('6', '60', '50', '50', '109', '32861');
INSERT INTO s_item
VALUES('7', '8', '250', '250', '100', '41010');
INSERT INTO s_item
VALUES('7', '45', '50', '50', '101', '50530');
INSERT INTO s_item
VALUES('7', '45', '42', '42', '108', '41100');
INSERT INTO s_item
VALUES('7', '75', '43', '43', '109', '50418');

INSERT INTO s_inventory
VALUES('10011', '101', 650, 625, 1100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10012', '101', 600, 560, 1000, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10012', '10501', 300, 300, 525, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10013', '101', 400, 400, 700, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10013', '10501', 314, 300, 525, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10021', '101', 500, 425, 740, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10022', '101', 300, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10022', '10501', 502, 300, 525, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10023', '101', 400, 300, 525, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('10023', '10501', 500, 300, 525, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20106', '101', 993, 625, 1000, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20106', '10501', 150, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20106', '201', 220, 150, 260, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20108', '101', 700, 700, 1225, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20108', '10501', 222, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20108', '201', 166, 150, 260, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20201', '101', 802, 800, 1400, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20201', '10501', 275, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20201', '201', 320, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20510', '101', 1389, 850, 1400, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20510', '10501', 57, 50, 87, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20510', '201', 175, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20510', '301', 69, 40, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20510', '401', 88, 50, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20512', '101', 850, 850, 1450, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20512', '10501', 62, 50, 87, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20512', '201', 162, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20512', '301', 28, 20, 50, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('20512', '401', 75, 75, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30321', '101', 2000, 1500, 2500, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30321', '10501', 194, 150, 275, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30321', '201', 96, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30321', '301', 85, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30321', '401', 102, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30326', '101', 2100, 2000, 3500, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30326', '10501', 277, 250, 440, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30326', '201', 147, 120, 210, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30326', '401', 113, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30421', '101', 1822, 1800, 3150, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30421', '10501', 190, 150, 275, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30421', '201', 102, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30421', '301', 102, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30421', '401', 85, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30426', '101', 2250, 2000, 3500, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30426', '10501', 423, 250, 450, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30426', '201', 200, 120, 210, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30426', '401', 135, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30433', '101', 650, 600, 1050, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30433', '10501', 273, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30433', '201', 130, 130, 230, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30433', '301', 35, 20, 35, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('30433', '401', 0, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32779', '101', 2120, 1250, 2200, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32779', '10501', 280, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32779', '201', 180, 150, 260, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32779', '301', 102, 95, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32779', '401', 135, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32861', '101', 505, 500, 875, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32861', '10501', 288, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32861', '201', 132, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32861', '301', 57, 50, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('32861', '401', 250, 150, 250, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40421', '101', 578, 350, 600, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40421', '10501', 97, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40421', '301', 70, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40421', '401', 47, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40422', '101', 0, 350, 600, 'Phenomenal sales...', '1993-02-08 00:00:00.000');
INSERT INTO s_inventory
VALUES('40422', '10501', 90, 80, 140, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40422', '301', 65, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('40422', '401', 50, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41010', '101', 250, 250, 437, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41010', '10501', 151, 140, 245, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41010', '301', 59, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41010', '401', 80, 70, 220, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41020', '101', 471, 450, 750, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41020', '10501', 224, 140, 245, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41020', '301', 61, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41020', '401', 91, 70, 220, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41050', '101', 501, 450, 750, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41050', '10501', 157, 140, 245, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41050', '301', 49, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41050', '401', 169, 70, 220, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41080', '101', 400, 400, 700, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41080', '10501', 159, 140, 245, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41080', '301', 50, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41080', '401', 100, 70, 220, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41100', '101', 350, 350, 600, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41100', '10501', 141, 140, 245, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41100', '301', 42, 40, 70, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('41100', '401', 75, 70, 220, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50169', '101', 2530, 1500, 2600, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50169', '201', 225, 220, 385, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50169', '401', 240, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50273', '101', 233, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50273', '201', 75, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50273', '401', 224, 150, 280, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50417', '101', 518, 500, 875, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50417', '201', 82, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50417', '401', 130, 120, 210, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50418', '101', 244, 100, 275, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50418', '201', 98, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50418', '401', 156, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50419', '101', 230, 120, 310, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50419', '201', 77, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50419', '401', 151, 150, 280, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50530', '101', 669, 400, 700, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50530', '201', 62, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50530', '401', 119, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50532', '101', 0, 100, 175, 'Wait for Spring.', '1993-04-12 00:00:00.000');
INSERT INTO s_inventory
VALUES('50532', '201', 67, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50532', '401', 233, 200, 350, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50536', '101', 173, 100, 175, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50536', '201', 97, 60, 100, 'NULL', NULL);
INSERT INTO s_inventory
VALUES('50536', '401', 138, 100, 175, 'NULL', NULL);

SELECT *
FROM s_region;
SELECT *
FROM s_dept;
SELECT *
FROM s_emp;
SELECT *
FROM s_product;
SELECT *
FROM s_customer;
SELECT *
FROM s_warehouse;
SELECT *
FROM s_ord;
SELECT *
FROM s_item;
SELECT *
FROM s_inventory;

--1. Show the structure of the S_DEPT table. Select all information from the S_DEPT table and S_CUSTOMER table (hint: DESCRIBE s_customer,...).
EXEC sp_help 's_dept';
SELECT *
FROM s_dept;
EXEC sp_help 's_customer';
SELECT *
FROM s_customer;

--2. Display the name and phone number of each customer.
SELECT name, phone
FROM s_customer;

--3. Display the phone number and name of each customer, with the phone number appearing first.
SELECT phone, name
FROM s_customer;

--4. Display the user name for employee 23.
SELECT userid
FROM s_emp
WHERE id = 23;

--5. Display the first name, last name, and department number of the employees in departments 10 and 50 in alphabetical order of last name. Merge the first name and last name, and title the column Employees.
SELECT CONCAT(first_name, ' ', last_name) AS Employees, dept_id
FROM s_emp
WHERE dept_id IN ('10', '50')
ORDER BY last_name;

--6. Display all employees whose last names contain an "s".
SELECT *
FROM s_emp
WHERE last_name LIKE '%s%';

--7. Display the user names and start dates of employees hired between May 5, 1990, and May 26, 1991. Order the query results by start date in ascending order.
SELECT userid, start_date
FROM s_emp
WHERE start_date BETWEEN '1990-05-05' AND '1991-05-26'
ORDER BY start_date ASC;

--8. Write a query to show the last name and salary of all employees who are not making between 1000 and 2500 monthly.
SELECT last_name, salary
FROM s_emp
WHERE salary NOT BETWEEN 1000 AND 2500;

--9. List the last name and salary of employees who earn more than 1350 in departments 31, 42, or 50. Label the last name column Employee Name, and label the salary column Monthly Salary.
SELECT last_name AS "Employee Name", salary AS "Monthly Salary"
FROM s_emp
WHERE salary > 1350 AND dept_id IN (31, 42, 50);

--10. Display the last name and start date of every employee hired in 1991.
SELECT last_name, start_date
FROM s_emp
WHERE start_date BETWEEN '1991-01-01' AND '1991-12-31';

--11. Display the full name of all employees with no manager.
SELECT CONCAT(first_name, ' ', last_name) AS FullName
FROM s_emp
WHERE manager_id IS NULL;

--12. Display all products with a name beginning with Pro.
SELECT *
FROM s_product
WHERE name LIKE 'Pro%';

--13. Display all product names and short descriptions for all descriptions containing the word bicycle.
SELECT name, short_desc
FROM s_product
WHERE short_desc LIKE '%bicycle%';

--14. Display all short descriptions. Compare the results from question 13.
SELECT short_desc
FROM s_product;
--Did your response in question 13 return all descriptions containing "bicycle"?
--No, it returned only those with the exact word "bicycle".

--15. Display the employee number, last name, and salary increased by 15%.
SELECT id, last_name, salary * 1.15 AS increased_salary
FROM s_emp;

--16. Display the employee's last name and title in parentheses for all employees. The result should be similar to this form: Jonh Herry (Director).
SELECT last_name, CONCAT('(', title, ')') AS title
FROM s_emp;

--17. Display each employee's last name, hire date, and salary review date ( the first Monday after six months of service). Format the dates similarly to: Eighth of May 1992.
SELECT
    last_name,

    -- Hire Date
    DATENAME(DAY, start_date)
        + CASE DAY(start_date)
            WHEN 1 THEN 'st'
            WHEN 2 THEN 'nd'
            WHEN 3 THEN 'rd'
            WHEN 21 THEN 'st'
            WHEN 22 THEN 'nd'
            WHEN 23 THEN 'rd'
            WHEN 31 THEN 'st'
            ELSE 'th'
          END
        + ' of ' + DATENAME(MONTH, start_date)
        + ' ' + CAST(YEAR(start_date) AS varchar(4)) AS hire_date,

    -- Salary Review Date (first Monday after 6 months)
    DATENAME(DAY,
        DATEADD(
            DAY,
            (9 - DATEPART(WEEKDAY, DATEADD(MONTH, 6, start_date))) % 7,
            DATEADD(MONTH, 6, start_date)
        )
    )
    + CASE DAY(
        DATEADD(
            DAY,
            (9 - DATEPART(WEEKDAY, DATEADD(MONTH, 6, start_date))) % 7,
            DATEADD(MONTH, 6, start_date)
            )
        )
        WHEN 1 THEN 'st'
        WHEN 2 THEN 'nd'
        WHEN 3 THEN 'rd'
        WHEN 21 THEN 'st'
        WHEN 22 THEN 'nd'
        WHEN 23 THEN 'rd'
        WHEN 31 THEN 'st'
        ELSE 'th'
        END
        + ' of ' + DATENAME(MONTH,
            DATEADD(
                DAY,
                (9 - DATEPART(WEEKDAY, DATEADD(MONTH, 6, start_date))) % 7,
                DATEADD(MONTH, 6, start_date)
            )
        )
        + ' ' + CAST(YEAR(
            DATEADD(
                DAY,
                (9 - DATEPART(WEEKDAY, DATEADD(MONTH, 6, start_date))) % 7,
                DATEADD(MONTH, 6, start_date)
            )
        ) AS varchar(4)) AS salary_review_date
FROM s_emp;

--18. Display the product name for products that have "ski" in the name.
SELECT name
FROM s_product
WHERE name LIKE '%ski%';

--20. Display the last name of all employees and the day of the week they started.
SELECT last_name, DATENAME(WEEKDAY, start_date) AS start_day
FROM s_emp;

--21. Write a query that produces the following for each employee:
--<employee name> earns <salary> monthly but wants <3 times salary>.
SELECT CONCAT(last_name, ' earns ', salary, ' monthly but wants ', salary * 3, '.') AS employee_wants
FROM s_emp;

--22. Display each employee's last name, department number, and department name.
SELECT last_name, dept_id, d.name AS department_name
FROM s_emp e
    LEFT JOIN s_dept d ON e.dept_id = d.id;

--23. Write a query to display the last name, department name, and region name of all employees who earn a commission.
SELECT e.last_name, d.name AS department_name, r.name AS region_name
FROM s_emp e
    LEFT JOIN s_dept d ON e.dept_id = d.id
    LEFT JOIN s_region r ON d.region_id = r.id
WHERE e.commission_pct IS NOT NULL AND e.commission_pct > 0;

--25. Display the product name, product number, and ordered quantity of all items in order number 101. Label the quantity column ORDERED.
SELECT p.name AS product_name, i.product_id, i.quantity AS ORDERED
FROM s_item i
    JOIN s_product p ON i.product_id = p.id
WHERE i.ord_id = '101';

--26. Display the customer number and the last name of their sales representative. Order the list by last name.
SELECT c.id AS customer_id, e.last_name AS sales_rep_last_name
FROM s_customer c
    LEFT JOIN s_emp e ON c.sales_rep_id = e.id
ORDER BY sales_rep_last_name;

--27. Display the customer number, name, and order number of all customers and their orders. Display the customer number and name, even if they have not placed an order yet.
SELECT c.id AS customer_id, c.name AS customer_name, o.id AS order_id
FROM s_customer c
    LEFT JOIN s_ord o ON c.id = o.customer_id;

--28. Display all employees by last name and employee number along with their manager's last name and manager number.
SELECT e.last_name, e.id AS employee_id, m.last_name AS manager_last_name, m.id AS manager_id
FROM s_emp e
    LEFT JOIN s_emp m ON e.manager_id = m.id;

--29. Display all employees who have no manager.
SELECT last_name, id AS employee_id
FROM s_emp
WHERE manager_id IS NULL;

--30. Display all customers and the product numbers and quantities they ordered for those customers whose orders totaled more than 100,000.
SELECT c.id AS customer_id, c.name AS customer_name, i.product_id, i.quantity
FROM s_customer c
    JOIN s_ord o ON c.id = o.customer_id
    JOIN s_item i ON o.id = i.ord_id
WHERE o.total > 100000;

--31. Display the highest and lowest order totals in the S_ORD. Label the columns Highest and Lowest, respectively.
SELECT MAX(total) AS Highest, MIN(total) AS Lowest
FROM s_ord;

--32. Write a query to display the minimum and maximum salary for each job type ordered alphabetically.
SELECT title, MIN(salary) AS Min_Salary, MAX(salary) AS Max_Salary
FROM s_emp
GROUP BY title
ORDER BY title;

--33. Determine the number of managers without listing them.
SELECT COUNT(DISTINCT manager_id)
FROM s_emp
WHERE manager_id IS NOT NULL;

--34. Display the number of line items in each order under each order number, labeled "number of Items".
SELECT ord_id, COUNT(*) AS "number of Items"
FROM s_item
GROUP BY ord_id;

--35. Display the manager number and the salary of the lowest-paid employee for that manager. Exclude any groups where the minimum salary is less than 1000. Sort the output by salary.
SELECT manager_id, MIN(salary) AS Min_Salary
FROM s_emp
GROUP BY manager_id
HAVING MIN(salary) >= 1000
ORDER BY Min_Salary;

--36. Display the product number and the number of times it was ordered; label the second output column "Times Ordered". Only show those products that have been ordered at least three times. Order the data in descending by the number of products ordered.
SELECT product_id, COUNT(*) AS "Times Ordered"
FROM s_item
GROUP BY product_id
HAVING COUNT(*) >= 3
ORDER BY "Times Ordered" DESC;

--37. Retrieve the region number, region name, and the number of departments within each region.
SELECT r.id AS region_id, r.name AS region_name, COUNT(d.id) AS department_count
FROM s_region r
    LEFT JOIN s_dept d ON r.id = d.region_id
GROUP BY r.id, r.name;

--38. Display the order number and total item count for each order of 100 or more items. For example, if order number 99 contains quantity 30 of one item and quantity 75 of another item, then the total item count for that order is 105.
SELECT ord_id, SUM(quantity) AS total_items
FROM s_item
GROUP BY ord_id
HAVING SUM(quantity) >= 100;

--39. Display the customer name and the number of orders of each customer.
SELECT c.name AS customer_name, COUNT(o.id) AS order_count
FROM s_customer c
    LEFT JOIN s_ord o ON c.id = o.customer_id
GROUP BY c.name;

--40. Display the first name, last name, and start date for all employees in the same department as Magee.
SELECT first_name, last_name, start_date
FROM s_emp
WHERE dept_id = (SELECT dept_id
FROM s_emp
WHERE last_name = 'Magee');

--41. Display the employee number, first name, last name, and user name for all employees with salaries above the average salary.
SELECT id AS employee_id, first_name, last_name, userid
FROM s_emp
WHERE salary > (SELECT AVG(salary)
FROM s_emp);

--42. Display the name and short description for any product not appearing on an order in September 1992.
SELECT name, short_desc
FROM s_product
WHERE id NOT IN (
    SELECT product_id
FROM s_item
WHERE ord_id IN (
        SELECT id
FROM s_ord
WHERE date_ordered BETWEEN '1992-09-01' AND '1992-09-30'
    )
);

--43. Display each sales representative's last name in Region 1 and Region 2, their customer's names, and each customer's total sales orders. Round the number of months up to the closest whole number.
SELECT e.last_name AS sales_rep_last_name, c.name AS customer_name, COUNT(o.id) AS total_orders,
    CEILING(DATEDIFF(DAY, MIN(o.date_ordered), GETDATE()) / 30.0) AS months
FROM s_emp e
    JOIN s_customer c ON e.id = c.sales_rep_id
    LEFT JOIN s_ord o ON c.id = o.customer_id
WHERE c.region_id IN (1, 2)
GROUP BY e.last_name, c.name



-- END OF CODE 