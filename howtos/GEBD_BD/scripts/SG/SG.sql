#   Sporting_Goods Database
#
# 
#  SCRIPT - FUNCTION
#   Create and populate tables and sequences to support the Sporting Goods business scenario.
#   This database is a modified version of the database used in some of the classes of
#   the ORACLE Corporation.
# 
# NOTES
# 
# MODIFIED
# Originally created:  GDURHAM  Mar 15, 1993  -- ORACLE Corporation
#
# Modified and reprinted with permission from The ORACLE Corporation
# by Drs. Ramon A. Mata-Toledo and Pauline K. Cushman on Dec 15, 1999.


# ************** S_CUSTOMER TABLE *********************************
#	*****************************************************************
CREATE SCHEMA IF NOT EXISTS SG;
USE SG;

DROP TABLE IF EXISTS s_customer;
CREATE TABLE s_customer 
 (id                         VARCHAR(3)  NOT NULL,
  name                       VARCHAR(20) NOT NULL,
  phone                      VARCHAR(20) NOT NULL,
  address                    VARCHAR(20),
  city                       VARCHAR(20),
  state                      VARCHAR(15),
  country                    VARCHAR(20),
  zip_code                   VARCHAR(15),
  credit_rating              VARCHAR(9),
  sales_rep_id               VARCHAR(3),
  region_id                  VARCHAR(3),
  comments                   VARCHAR(255),
  CONSTRAINT s_customer_id_pk PRIMARY KEY (id),
  CONSTRAINT s_customer_credit_rating_ck
  CHECK (credit_rating IN ('EXCELLENT', 'GOOD', 'POOR'))
 );


INSERT INTO s_customer VALUES ('301', 'Sports,Inc', '540-123-4567','72 High St',
'Harrisonburg', 'VA','US', '22809','EXCELLENT', '12', '1', NULL);
INSERT INTO s_customer VALUES ('302', 'Toms Sporting Goods', '540-987-6543','6741 Main St',
'Harrisonburg', 'VA','US', '22809','POOR', '14', '1', NULL);
INSERT INTO s_customer VALUES ('303', 'Athletic Attire', '540-123-6789','54 Market St',
'Harrisonburg', 'VA','US', '22808','GOOD', '14', '1', NULL);
INSERT INTO s_customer 
VALUES ('304', 'Athletics For All', '540-987-1234','286 Main St', 'Harrisonburg', 'VA',
'US', '22808','EXCELLENT', '12', '1', NULL);
INSERT INTO s_customer VALUES ('305', 'Shoes for Sports', '540-123-9876','538 High St',
'Harrisonburg', 'VA','US', '22809','EXCELLENT', '14', '1', NULL);
INSERT INTO s_customer VALUES ('306', 'BJ Athletics', '540-987-9999','632 Water St',
'Harrisonburg', 'VA','US', '22810','POOR', '12', '1', NULL);

INSERT INTO s_customer VALUES ('403', 'Athletics One', '717-234-6786','912 Columbia Rd',
'Lancaster', 'PA','US', '17601','GOOD', '14', '1', NULL);
INSERT INTO s_customer VALUES ('404', 'Great Athletes', '717-987-2341','121 Litiz Pike',
'Lancaster', 'PA','US', '17602','EXCELLENT', '12', '1', NULL);
INSERT INTO s_customer VALUES ('405', 'Athletics Two', '717-987-9875','435 High Rd',
'Lancaster', 'PA','US', '17602','EXCELLENT', '14', '1', NULL);
INSERT INTO s_customer VALUES ('406', 'Athletes Attic', '717-234-9888','101 Greenfield Rd',
'Lancaster', 'PA','US', '17601','POOR', '12', '1', NULL);

INSERT INTO s_customer VALUES ('201', 'One Sport', '55-112066222','82 Via Bahia', 'Sao Paolo',
NULL, 'Brazil', NULL,'EXCELLENT', '12', '2', NULL);
INSERT INTO s_customer VALUES ('202', 'Deportivo Caracas', '58-28066222','31 Sabana Grande',
'Caracas', NULL, 'Venezuela', NULL,'EXCELLENT', '12', '2', NULL);
INSERT INTO s_customer VALUES ('203', 'New Delhi Sports', '91-11903338','11368 Chanakya',
'New Delhi', NULL, 'India', NULL,'GOOD', '11', '4', NULL);
INSERT INTO s_customer VALUES ('204', 'Ladysport', '1-206-104-0111','281 Queen Street',
'Seattle', 'Washington', 'US', NULL,'EXCELLENT', '11', '1', NULL);
INSERT INTO s_customer VALUES ('205', 'Kim''s Sporting Goods', '852-3693888','15 Henessey Road',
'Hong Kong', NULL, NULL, NULL,'EXCELLENT', '11', '4', NULL);
INSERT INTO s_customer VALUES ('206', 'Sportique', '33-93425722253','172 Rue de Place',
'Cannes', NULL, 'France', NULL,'EXCELLENT', '13', '5', NULL);
INSERT INTO s_customer VALUES ('207', 'Tall Rock Sports', '234-16036222','10 Saint Antoine',
'Lagos', NULL, 'Nigeria', NULL,'GOOD', NULL, '3', NULL);
INSERT INTO s_customer VALUES ('208', 'Muench Sports', '49-895274449','435 Gruenestrasse',
'Munich', NULL, 'Germany', NULL,'GOOD', '13', '5', NULL);

INSERT INTO s_customer VALUES ('209', 'Beisbol Si!', '809-352666','415 Playa Del Mar',
 'San Pedro de Macoris', NULL, 'Dominican Republic', NULL, 'EXCELLENT', '11', '6', NULL);
INSERT INTO s_customer VALUES ('210', 'Futbol Sonora', '52-404555','5 Via Saguaro', 'Nogales',
NULL, 'Mexico', NULL,'EXCELLENT', '12', '2', NULL);
INSERT INTO s_customer VALUES ('211', 'Helmut''s Sports', '42-2111222','45 Modrany', 'Prague',
NULL, 'Czechoslovakia', NULL,'EXCELLENT', '11', '5', NULL);
INSERT INTO s_customer VALUES ('212', 'Hamada Sport', '20-31209222','47A Corniche', 
'Alexandria', NULL, 'Egypt', NULL,'EXCELLENT', '13', '3', NULL);
INSERT INTO s_customer VALUES ('213', 'Sports Emporium', '1-415-555-6281','4783 168th Street',
'San Francisco', 'CA', 'US', NULL,'EXCELLENT', '11', '1', NULL);
INSERT INTO s_customer VALUES ('214', 'Sports Retail', '1-716-555-7777','115 Main Street',
'Buffalo', 'NY', 'US', NULL, 'POOR', '11', '1', NULL);
INSERT INTO s_customer VALUES ('215', 'Sports Russia', '7-0953892444','7070 Yekatamina',
'Saint Petersburg', NULL, 'Russia', NULL,'POOR', '11', '5', NULL);
COMMIT;


#	************** S_CUSTOMER TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_dept;
CREATE TABLE s_dept 
(id         VARCHAR(3)  NOT NULL,
 name       VARCHAR(20) NOT NULL,
 region_id  VARCHAR(3),  
 CONSTRAINT s_dept_id_pk PRIMARY KEY (id),
 CONSTRAINT s_dept_name_region_id_uk UNIQUE (name, region_id)
);

INSERT INTO s_dept VALUES ('10', 'Finance', '1');
INSERT INTO s_dept VALUES ('31', 'Sales', '1');
INSERT INTO s_dept VALUES ('32', 'Sales', '2');
INSERT INTO s_dept VALUES ('33', 'Sales', '3');
INSERT INTO s_dept VALUES ('34', 'Sales', '4');
INSERT INTO s_dept VALUES ('35', 'Sales', '5');
INSERT INTO s_dept VALUES ('41', 'Operations', '1');
INSERT INTO s_dept VALUES ('42', 'Operations', '2');
INSERT INTO s_dept VALUES ('43', 'Operations', '3');
INSERT INTO s_dept VALUES ('44', 'Operations', '4');
INSERT INTO s_dept VALUES ('45', 'Operations', '5');
INSERT INTO s_dept VALUES ('50', 'Administration', '1');
COMMIT;

# ************** S_TEMP TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_emp;
CREATE TABLE s_emp 
(id              VARCHAR(3)  NOT NULL,
 last_name       VARCHAR(20)  NOT NULL,
 first_name      VARCHAR(20),
 userid          VARCHAR(8) NOT NULL,
 start_date      DATE NOT NULL,
 comments        VARCHAR(255),
 manager_id      VARCHAR(3),
 title           VARCHAR(25),
 dept_id         VARCHAR(3),
 salary          DECIMAL(11, 2),
 commission_pct  DECIMAL(4, 2),
 CONSTRAINT s_emp_id_pk PRIMARY KEY (id),
 CONSTRAINT s_emp_userid_uk UNIQUE (userid),
 CONSTRAINT s_emp_commission_pct_ck CHECK (commission_pct IN (10, 12.5, 15, 17.5, 20))
);


INSERT INTO s_emp VALUES ('1', 'Martin','Carmen','martincu',STR_TO_DATE('03-MAR-1990','%d-%b-%Y'), NULL,NULL, 'President', '50', 4500, NULL);
INSERT INTO s_emp VALUES ('2','Smith','Doris','smithdj',STR_TO_DATE('08-MAR-1990','%d-%b-%Y'),NULL,'1', 'VP, Operations','41', 2450,NULL);
INSERT INTO s_emp VALUES ('3', 'Norton','Michael','nortonma',STR_TO_DATE('17-JUN-1991','%d-%b-%Y'),NULL,'1', 'VP, Sales', '31', 2400,NULL);
INSERT INTO s_emp VALUES ('4', 'Quentin', 'Mark','quentiml',STR_TO_DATE('07-APR-1990','%d-%b-%Y'),NULL,'1', 'VP, Finance', '10', 2450, NULL);
INSERT INTO s_emp VALUES ('5', 'Roper', 'Joseph','roperjm',STR_TO_DATE('04-MAR-1990','%d-%b-%Y'),NULL,'1', 'VP, Administration', '50', 2550, NULL);
INSERT INTO s_emp VALUES ('6', 'Brown', 'Molly','brownmr',STR_TO_DATE('18-JAN-1991','%d-%b-%Y'),NULL,'2', 'Warehouse Manager', '41', 1600, NULL);
INSERT INTO s_emp  VALUES ('7', 'Hawkins', 'Roberta','hawkinrt',STR_TO_DATE('14-MAY-1990','%d-%b-%Y'),NULL,'2', 'Warehouse Manager','42', 1650, NULL);
INSERT INTO s_emp VALUES ('8', 'Burns', 'Ben','burnsba',STR_TO_DATE('07-APR-1990','%d-%b-%Y'),NULL,'2', 'Warehouse Manager','43', 1500, NULL);

INSERT INTO s_emp  VALUES ('9', 'Catskill', 'Antoinette','catskiaw',STR_TO_DATE('09-FEB-1992','%d-%b-%Y'),NULL,'2', 'Warehouse Manager','44', 1700,NULL);
INSERT INTO s_emp  VALUES ('10', 'Jackson', 'Marta','jacksomt',STR_TO_DATE('27-FEB-1991','%d-%b-%Y'),NULL,'2', 'Warehouse Manager','45', 1507,NULL);
INSERT INTO s_emp VALUES ('11', 'Henderson', 'Colin','hendercs',STR_TO_DATE('14-MAY-1990','%d-%b-%Y'),NULL,'3', 'Sales Representative', '31', 1400, 10);
INSERT INTO s_emp  VALUES ('12', 'Gilson', 'Sam', 'gilsonsj',STR_TO_DATE('18-JAN-1992','%d-%b-%Y'),NULL,'3', 'Sales Representative','32', 1490, 12.5);
INSERT INTO s_emp  VALUES ('13', 'Sanders', 'Jason', 'sanderjk',STR_TO_DATE('18-FEB-1991','%d-%b-%Y'),NULL,'3', 'Sales Representative','33', 1515, 10);
INSERT INTO s_emp  VALUES ('14', 'Dameron', 'Andre', 'dameroap',STR_TO_DATE('09-OCT-1991','%d-%b-%Y'),NULL,'3', 'Sales Representative','35', 1450, 17.5);
INSERT INTO s_emp  VALUES ('15', 'Hardwick', 'Elaine', 'hardwiem',STR_TO_DATE('07-FEB-1992','%d-%b-%Y'),NULL,'6', 'Stock Clerk','41', 1400, NULL);
INSERT INTO s_emp  VALUES ('16', 'Brown', 'George', 'browngw',STR_TO_DATE('08-MAR-1990','%d-%b-%Y'),NULL,'6', 'Stock Clerk','41', 940, NULL);

INSERT INTO s_emp  VALUES ('17', 'Washington', 'Thomas', 'washintl',STR_TO_DATE('09-FEB-1991','%d-%b-%Y'),NULL,'7', 'Stock Clerk', '42', 1200, NULL);
INSERT INTO s_emp  VALUES ('18', 'Patterson', 'Donald', 'patterdv',STR_TO_DATE('06-AUG-1991','%d-%b-%Y'),NULL,'7', 'Stock Clerk','42', 795, NULL);
INSERT INTO s_emp VALUES ('19', 'Bell', 'Alexander', 'bellag',STR_TO_DATE('26-MAY-1991','%d-%b-%Y'),NULL,'8', 'Stock Clerk','43', 850, NULL);
INSERT INTO s_emp VALUES ('20', 'Gantos', 'Eddie', 'gantosej',STR_TO_DATE('30-NOV-1990','%d-%b-%Y'),NULL,'9', 'Stock Clerk','44', 800, NULL);
INSERT INTO s_emp  VALUES ('21', 'Stephenson', 'Blaine', 'stephebs',STR_TO_DATE('17-MAR-1991','%d-%b-%Y'),NULL,'10', 'Stock Clerk','45', 860, NULL);

INSERT INTO s_emp VALUES ('22', 'Chester', 'Eddie', 'chesteek',STR_TO_DATE('30-NOV-1990','%d-%b-%Y'), NULL, '9', 'Stock Clerk','44', 800, NULL);
INSERT INTO s_emp VALUES ('23', 'Pearl', 'Roger', 'pearlrg',STR_TO_DATE('17-OCT-1990','%d-%b-%Y'), NULL, '9', 'Stock Clerk','34', 795, NULL);
INSERT INTO s_emp VALUES ('24', 'Dancer', 'Bonnie', 'dancerbw',STR_TO_DATE('17-MAR-1991','%d-%b-%Y'), NULL, '7', 'Stock Clerk','45', 860, NULL);
INSERT INTO s_emp VALUES ('25', 'Schmitt', 'Sandra', 'schmitss',STR_TO_DATE('09-MAY-1991','%d-%b-%Y'), NULL, '8', 'Stock Clerk','45', 1100, NULL);
COMMIT;

#	************** S_INVENTORY TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_inventory;
CREATE TABLE s_inventory 
(product_id               VARCHAR(7) NOT NULL,
 warehouse_id             VARCHAR(7) NOT NULL,
 amount_in_stock          DECIMAL(9),
 reorder_point            DECIMAL(9),
 max_in_stock             DECIMAL(9),
 out_of_stock_explanation VARCHAR(255),
 restock_date             DATE,
 CONSTRAINT s_inventory_prodid_warid_pk PRIMARY KEY (product_id, warehouse_id)
);


INSERT INTO s_inventory VALUES ('10011', '101', 650, 625, 1100, NULL, NULL);
INSERT INTO s_inventory VALUES ('10012', '101', 600, 560, 1000, NULL, NULL);
INSERT INTO s_inventory VALUES ('10013', '101', 400, 400, 700, NULL, NULL);
INSERT INTO s_inventory VALUES ('10021', '101', 500, 425, 740, NULL, NULL);
INSERT INTO s_inventory VALUES ('10022', '101', 300, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('10023', '101', 400, 300, 525, NULL, NULL);
INSERT INTO s_inventory VALUES ('20106', '101', 993, 625, 1000, NULL, NULL);
INSERT INTO s_inventory VALUES ('20108', '101', 700, 700, 1225, NULL, NULL);
INSERT INTO s_inventory VALUES ('20201', '101', 802, 800, 1400, NULL, NULL);
INSERT INTO s_inventory VALUES ('20510', '101', 1389, 850, 1400, NULL, NULL);
INSERT INTO s_inventory VALUES ('20512', '101', 850, 850, 1450, NULL, NULL);
INSERT INTO s_inventory VALUES ('30321', '101', 2000, 1500, 2500, NULL, NULL);
INSERT INTO s_inventory VALUES ('30326', '101', 2100, 2000, 3500, NULL, NULL);
INSERT INTO s_inventory VALUES ('30421', '101', 1822, 1800, 3150, NULL, NULL);
INSERT INTO s_inventory VALUES ('30426', '101', 2250, 2000, 3500, NULL, NULL);
INSERT INTO s_inventory VALUES ('30433', '101', 650, 600, 1050, NULL, NULL);
INSERT INTO s_inventory VALUES ('32779', '101', 2120, 1250, 2200, NULL, NULL);
INSERT INTO s_inventory VALUES ('32861', '101', 505, 500, 875, NULL, NULL);
INSERT INTO s_inventory VALUES ('40421', '101', 578, 350, 600, NULL, NULL);
INSERT INTO s_inventory VALUES ('40422', '101', 0, 350, 600, 'Phenomenal sales...', STR_TO_DATE('08-FEB-1993','%d-%b-%Y'));
INSERT INTO s_inventory VALUES ('41010', '101', 250, 250, 437, NULL, NULL);
INSERT INTO s_inventory VALUES ('41020', '101', 471, 450, 750, NULL, NULL);
INSERT INTO s_inventory VALUES ('41050', '101', 501, 450, 750, NULL, NULL);
INSERT INTO s_inventory VALUES ('41080', '101', 400, 400, 700, NULL, NULL);
INSERT INTO s_inventory VALUES ('41100', '101', 350, 350, 600, NULL, NULL);
INSERT INTO s_inventory VALUES ('50169', '101', 2530, 1500, 2600, NULL, NULL);
INSERT INTO s_inventory VALUES ('50273', '101', 233, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('50417', '101', 518, 500, 875, NULL, NULL);
INSERT INTO s_inventory VALUES ('50418', '101', 244, 100, 275, NULL, NULL);
INSERT INTO s_inventory VALUES ('50419', '101', 230, 120, 310, NULL, NULL);
INSERT INTO s_inventory VALUES ('50530', '101', 669, 400, 700, NULL, NULL);
INSERT INTO s_inventory VALUES ('50532', '101', 0, 100, 175, 'Wait for Spring.', STR_TO_DATE('12-APR-1993','%d-%b-%Y'));
INSERT INTO s_inventory VALUES ('50536', '101', 173, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('20106', '201', 220, 150, 260, NULL, NULL);
INSERT INTO s_inventory VALUES ('20108', '201', 166, 150, 260, NULL, NULL);
INSERT INTO s_inventory VALUES ('20201', '201', 320, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('20510', '201', 175, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('20512', '201', 162, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('30321', '201', 96, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30326', '201', 147, 120, 210, NULL, NULL);
INSERT INTO s_inventory VALUES ('30421', '201', 102, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30426', '201', 200, 120, 210, NULL, NULL);
INSERT INTO s_inventory VALUES ('30433', '201', 130, 130, 230, NULL, NULL);
INSERT INTO s_inventory VALUES ('32779', '201', 180, 150, 260, NULL, NULL);
INSERT INTO s_inventory VALUES ('32861', '201', 132, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('50169', '201', 225, 220, 385, NULL, NULL);
INSERT INTO s_inventory VALUES ('50273', '201', 75, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('50417', '201', 82, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('50418', '201', 98, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('50419', '201', 77, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('50530', '201', 62, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('50532', '201', 67, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('50536', '201', 97, 60, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('20510', '301', 69, 40, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('20512', '301', 28, 20, 50, NULL, NULL);
INSERT INTO s_inventory VALUES ('30321', '301', 85, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30421', '301', 102, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30433', '301', 35, 20, 35, NULL, NULL);
INSERT INTO s_inventory VALUES ('32779', '301', 102, 95, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('32861', '301', 57, 50, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('40421', '301', 70, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('40422', '301', 65, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('41010', '301', 59, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('41020', '301', 61, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('41050', '301', 49, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('41080', '301', 50, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('41100', '301', 42, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('20510', '401', 88, 50, 100, NULL, NULL);
INSERT INTO s_inventory VALUES ('20512', '401', 75, 75, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30321', '401', 102, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30326', '401', 113, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30421', '401', 85, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30426', '401', 135, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('30433', '401', 0, 100, 175, NULL, NULL );
INSERT INTO s_inventory VALUES ('32779', '401', 135, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('32861', '401', 250, 150, 250, NULL, NULL);
INSERT INTO s_inventory VALUES ('40421', '401', 47, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('40422', '401', 50, 40, 70, NULL, NULL);
INSERT INTO s_inventory VALUES ('41010', '401', 80, 70, 220, NULL, NULL);
INSERT INTO s_inventory VALUES ('41020', '401', 91, 70, 220, NULL, NULL);
INSERT INTO s_inventory VALUES ('41050', '401', 169, 70, 220, NULL, NULL);
INSERT INTO s_inventory VALUES ('41080', '401', 100, 70, 220, NULL, NULL);
INSERT INTO s_inventory VALUES ('41100', '401', 75, 70, 220, NULL, NULL);
INSERT INTO s_inventory VALUES ('50169', '401', 240, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('50273', '401', 224, 150, 280, NULL, NULL);
INSERT INTO s_inventory VALUES ('50417', '401', 130, 120, 210, NULL, NULL);
INSERT INTO s_inventory VALUES ('50418', '401', 156, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('50419', '401', 151, 150, 280, NULL, NULL);
INSERT INTO s_inventory VALUES ('50530', '401', 119, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('50532', '401', 233, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('50536', '401', 138, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('10012', '10501', 300, 300, 525, NULL, NULL);
INSERT INTO s_inventory VALUES ('10013', '10501', 314, 300, 525, NULL, NULL);
INSERT INTO s_inventory VALUES ('10022', '10501', 502, 300, 525, NULL, NULL);
INSERT INTO s_inventory VALUES ('10023', '10501', 500, 300, 525, NULL, NULL);
INSERT INTO s_inventory VALUES ('20106', '10501', 150, 100, 175, NULL, NULL);
INSERT INTO s_inventory VALUES ('20108', '10501', 222, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('20201', '10501', 275, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('20510', '10501', 57, 50, 87, NULL, NULL);
INSERT INTO s_inventory VALUES ('20512', '10501', 62, 50, 87, NULL, NULL);
INSERT INTO s_inventory VALUES ('30321', '10501', 194, 150, 275, NULL, NULL);
INSERT INTO s_inventory VALUES ('30326', '10501', 277, 250, 440, NULL, NULL);
INSERT INTO s_inventory VALUES ('30421', '10501', 190, 150, 275, NULL, NULL);
INSERT INTO s_inventory VALUES ('30426', '10501', 423, 250, 450, NULL, NULL);
INSERT INTO s_inventory VALUES ('30433', '10501', 273, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('32779', '10501', 280, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('32861', '10501', 288, 200, 350, NULL, NULL);
INSERT INTO s_inventory VALUES ('40421', '10501', 97, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('40422', '10501', 90, 80, 140, NULL, NULL);
INSERT INTO s_inventory VALUES ('41010', '10501', 151, 140, 245, NULL, NULL);
INSERT INTO s_inventory VALUES ('41020', '10501', 224, 140, 245, NULL, NULL);
INSERT INTO s_inventory VALUES ('41050', '10501', 157, 140, 245, NULL, NULL);
INSERT INTO s_inventory VALUES ('41080', '10501', 159, 140, 245, NULL, NULL);
INSERT INTO s_inventory VALUES ('41100', '10501', 141, 140, 245, NULL, NULL);
COMMIT;


#	************** S_ITEM TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_item;
CREATE TABLE s_item 
(ord_id               VARCHAR(3) NOT NULL,
 item_id              VARCHAR(7) NOT NULL,
 product_id           VARCHAR(7) NOT NULL,
 price                DECIMAL(11, 2),
 quantity             DECIMAL(9),
 quantity_shipped     DECIMAL(9),
 CONSTRAINT s_item_ordid_itemid_pk PRIMARY KEY (ord_id, item_id),
 CONSTRAINT s_item_ordid_prodid_uk UNIQUE (ord_id, product_id)
);


INSERT INTO s_item VALUES ('100', '1', '10011', 135, 500, 500);
INSERT INTO s_item VALUES ('100', '2', '10013', 380, 400, 400);
INSERT INTO s_item VALUES ('100', '3', '10021', 14, 500, 500);
INSERT INTO s_item VALUES ('100', '5', '30326', 582, 600, 600);
INSERT INTO s_item VALUES ('100', '7', '41010', 8, 250, 250);
INSERT INTO s_item VALUES ('100', '6', '30433', 20, 450, 450);
INSERT INTO s_item VALUES ('100', '4', '10023', 36, 400, 400);
INSERT INTO s_item VALUES ('101', '1', '30421', 16, 15, 15);
INSERT INTO s_item VALUES ('101', '3', '41010', 8, 20, 20);
INSERT INTO s_item VALUES ('101', '5', '50169', 4.29, 40, 40);
INSERT INTO s_item VALUES ('101', '6', '50417', 80, 27, 27);
INSERT INTO s_item VALUES ('101', '7', '50530', 45, 50, 50);
INSERT INTO s_item VALUES ('101', '4', '41100', 45, 35, 35);
INSERT INTO s_item VALUES ('101', '2', '40422', 50, 30, 30);
INSERT INTO s_item VALUES ('102', '1', '20108', 28, 100, 100);
INSERT INTO s_item VALUES ('102', '2', '20201', 123, 45, 45);
INSERT INTO s_item VALUES ('103', '1', '30433', 20, 15, 15);
INSERT INTO s_item VALUES ('103', '2', '32779', 7, 11, 11);
INSERT INTO s_item VALUES ('104', '1', '20510', 9, 7, 7);
INSERT INTO s_item VALUES ('104', '4', '30421', 16, 35, 35);
INSERT INTO s_item VALUES ('104', '2', '20512', 8, 12, 12);
INSERT INTO s_item VALUES ('104', '3', '30321', 1669, 19, 19);
INSERT INTO s_item VALUES ('105', '1', '50273', 22.89, 16, 16);
INSERT INTO s_item VALUES ('105', '3', '50532', 47, 28, 28);
INSERT INTO s_item VALUES ('105', '2', '50419', 80, 13, 13);
INSERT INTO s_item VALUES ('106', '1', '20108', 28, 46, 46);
INSERT INTO s_item VALUES ('106', '4', '50273', 22.89, 75, 75);
INSERT INTO s_item VALUES ('106', '5', '50418', 75, 98, 98);
INSERT INTO s_item VALUES ('106', '6', '50419', 80, 27, 27);
INSERT INTO s_item VALUES ('106', '2', '20201', 123, 21, 21);
INSERT INTO s_item VALUES ('106', '3', '50169', 4.29, 125, 125);
INSERT INTO s_item VALUES ('107', '1', '20106', 11, 50, 50);
INSERT INTO s_item VALUES ('107', '3', '20201', 115, 130, 130);
INSERT INTO s_item VALUES ('107', '5', '30421', 16, 55, 55);
INSERT INTO s_item VALUES ('107', '4', '30321', 1669, 75, 75);
INSERT INTO s_item VALUES ('107', '2', '20108', 28, 22, 22);
INSERT INTO s_item VALUES ('108', '1', '20510', 9, 9, 9);
INSERT INTO s_item VALUES ('108', '6', '41080', 35, 50, 50);
INSERT INTO s_item VALUES ('108', '7', '41100', 45, 42, 42);
INSERT INTO s_item VALUES ('108', '5', '32861', 60, 57, 57);
INSERT INTO s_item VALUES ('108', '2', '20512', 8, 18, 18);
INSERT INTO s_item VALUES ('108', '4', '32779', 7, 60, 60);
INSERT INTO s_item VALUES ('108', '3', '30321', 1669, 85, 85);
INSERT INTO s_item VALUES ('109', '1', '10011', 140, 150, 150);
INSERT INTO s_item VALUES ('109', '5', '30426', 18.25, 500, 500);
INSERT INTO s_item VALUES ('109', '7', '50418', 75, 43, 43);
INSERT INTO s_item VALUES ('109', '6', '32861', 60, 50, 50);
INSERT INTO s_item VALUES ('109', '4', '30326', 582, 1500, 1500);
INSERT INTO s_item VALUES ('109', '2', '10012', 175, 600, 600);
INSERT INTO s_item VALUES ('109', '3', '10022', 21.95, 300, 300);
INSERT INTO s_item VALUES ('110', '1', '50273', 22.89, 17, 17);
INSERT INTO s_item VALUES ('110', '2', '50536', 50, 23, 23);
INSERT INTO s_item VALUES ('111', '1', '40421', 65, 27, 27);
INSERT INTO s_item VALUES ('111', '2', '41080', 35, 29, 29);
INSERT INTO s_item VALUES ('97', '1', '20106', 9, 1000, 1000);
INSERT INTO s_item VALUES ('97', '2', '30321', 1500, 50, 50);
INSERT INTO s_item VALUES ('98', '1', '40421', 85, 7, 7);
INSERT INTO s_item VALUES ('99', '1', '20510', 9, 18, 18);
INSERT INTO s_item VALUES ('99', '2', '20512', 8, 25, 25);
INSERT INTO s_item VALUES ('99', '3', '50417', 80, 53, 53);
INSERT INTO s_item VALUES ('99', '4', '50530', 45, 69, 69);
INSERT INTO s_item VALUES ('112', '1', '20106', 11, 50, 50);
COMMIT;


#	************** S_ORD TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_ord;
CREATE TABLE s_ord 
(id                         VARCHAR(3) NOT NULL,
 customer_id                VARCHAR(3) NOT NULL,
 date_ordered               DATE NOT NULL,
 date_shipped               DATE,
 sales_rep_id               VARCHAR(3),
 total                      DECIMAL(11, 2),
 payment_type               VARCHAR(6) NOT NULL,
 order_filled               VARCHAR(1),
 CONSTRAINT s_ord_id_pk PRIMARY KEY (id),
 CONSTRAINT s_ord_payment_type_ck CHECK (payment_type in ('CASH', 'CREDIT')),
 CONSTRAINT s_ord_order_filled_ck CHECK (order_filled in ('Y', 'N'))
);


INSERT INTO s_ord VALUES ('100', '204', STR_TO_DATE('31-AUG-1992','%d-%b-%Y'),
STR_TO_DATE('10-SEP-1992','%d-%b-%Y'),'11', 601100, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('101', '205', STR_TO_DATE('31-AUG-1992','%d-%b-%Y'),
STR_TO_DATE('15-SEP-1992','%d-%b-%Y'),'14', 8056.6, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('102', '206', STR_TO_DATE('01-SEP-1992','%d-%b-%Y'),
STR_TO_DATE('08-SEP-1992','%d-%b-%Y'),'12', 8335, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('103', '208', STR_TO_DATE('02-SEP-1992', '%d-%b-%Y'),
STR_TO_DATE('22-SEP-1992','%d-%b-%Y'),'11', 377, 'CASH', 'Y');
INSERT INTO s_ord VALUES ('104', '208', STR_TO_DATE('03-SEP-1992','%d-%b-%Y'),
STR_TO_DATE('23-SEP-1992','%d-%b-%Y'),'13', 32430, 'CREDIT', 'Y');

INSERT INTO s_ord VALUES ('105', '209', STR_TO_DATE('04-SEP-1992','%d-%b-%Y'),
STR_TO_DATE( '18-SEP-1992','%d-%b-%Y'),'11', 2722.24, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('106', '210', STR_TO_DATE('07-SEP-1992','%d-%b-%Y'),
STR_TO_DATE('15-SEP-1992','%d-%b-%Y'),'12', 15634, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('107', '211', STR_TO_DATE('07-SEP-1992','%d-%b-%Y'),
STR_TO_DATE('21-SEP-1992','%d-%b-%Y'),'14', 142171, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('108', '212', STR_TO_DATE('07-SEP-1992','%d-%b-%Y'),
STR_TO_DATE('10-SEP-1992','%d-%b-%Y'),'13', 149570, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('109', '213', STR_TO_DATE('08-SEP-1992','%d-%b-%Y'),
STR_TO_DATE('28-SEP-1992','%d-%b-%Y'),'11', 1020935, 'CREDIT', 'Y');

INSERT INTO s_ord VALUES ('110', '214', STR_TO_DATE('09-SEP-1992', '%d-%b-%Y'),
STR_TO_DATE('21-SEP-1992','%d-%b-%Y'),'11', 1539.13, 'CASH', 'Y');
INSERT INTO s_ord VALUES ('111', '204', STR_TO_DATE('09-SEP-1992', '%d-%b-%Y'),
STR_TO_DATE('21-SEP-1992','%d-%b-%Y'),'11', 2770, 'CASH', 'Y');
INSERT INTO s_ord VALUES ('97', '201', STR_TO_DATE('28-AUG-1992','%d-%b-%Y'),
STR_TO_DATE('17-SEP-1992','%d-%b-%Y'),'12', 84000, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('98', '202', STR_TO_DATE('31-AUG-1992','%d-%b-%Y'),
STR_TO_DATE('10-SEP-1992','%d-%b-%Y'),'14', 595, 'CASH', 'Y');
INSERT INTO s_ord VALUES ('99', '203', STR_TO_DATE('31-AUG-1992','%d-%b-%Y'),
STR_TO_DATE('18-SEP-1992','%d-%b-%Y'),'14', 7707, 'CREDIT', 'Y');
INSERT INTO s_ord VALUES ('112', '210', STR_TO_DATE('31-AUG-1992','%d-%b-%Y'),
STR_TO_DATE('10-SEP-1992','%d-%b-%Y'),'12', 550, 'CREDIT', 'Y');
COMMIT;

#	************** S_PRODUCT TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_product;
CREATE TABLE s_product 
(id                        VARCHAR(7)  NOT NULL,
 name                      VARCHAR(25) NOT NULL,
 short_desc                VARCHAR(255),
 suggested_whlsl_price     DECIMAL(11, 2),
 whlsl_units               VARCHAR(10),
 CONSTRAINT s_product_id_pk PRIMARY KEY (id),
 CONSTRAINT s_product_name_uk UNIQUE (name)
);

INSERT INTO s_product VALUES ('10011', 'Bunny Boot','Beginner''s ski boot',150, NULL);
INSERT INTO s_product VALUES ('10012', 'Ace Ski Boot','Intermediate ski boot',200, NULL);
INSERT INTO s_product VALUES ('10013', 'Pro Ski Boot','Advanced ski boot',410, NULL);
INSERT INTO s_product VALUES ('10021', 'Bunny Ski Pole','Beginner''s ski pole',16.25, NULL);
INSERT INTO s_product VALUES ('10022', 'Ace Ski Pole','Intermediate ski pole',21.95, NULL);
INSERT INTO s_product VALUES ('10023', 'Pro Ski Pole','Advanced ski pole',40.95, NULL);
INSERT INTO s_product VALUES ('20106', 'Junior Soccer Ball','Junior soccer ball',11, NULL);
INSERT INTO s_product VALUES ('20108', 'World Cup Soccer Ball','World cup soccer ball',28, NULL);
INSERT INTO s_product VALUES ('20201', 'World Cup Net','World cup net',123, NULL);
INSERT INTO s_product VALUES ('20510', 'Black Hawk Knee Pads','Knee pads, pair',9, NULL);
INSERT INTO s_product VALUES ('20512', 'Black Hawk Elbow Pads','Elbow pads, pair',8, NULL);
INSERT INTO s_product VALUES ('30321', 'Grand Prix Bicycle','Road bicycle',1669, NULL);
INSERT INTO s_product VALUES ('30326', 'Himalaya Bicycle','Mountain bicycle',582, NULL);
INSERT INTO s_product VALUES ('30421', 'Grand Prix Bicycle Tires','Road bicycle tires',16, NULL);
INSERT INTO s_product VALUES ('30426', 'Himalaya Tires','Mountain bicycle tires',18.25, NULL);
INSERT INTO s_product VALUES ('30433', 'New Air Pump','Tire pump',20, NULL);
INSERT INTO s_product VALUES ('32779', 'Slaker Water Bottle','Water bottle',7, NULL);
INSERT INTO s_product VALUES ('32861', 'Safe-T Helmet','Bicycle helmet',60, NULL);
INSERT INTO s_product VALUES ('40421', 'Alexeyer Pro Lifting Bar','Straight bar',65, NULL);
INSERT INTO s_product VALUES ('40422', 'Pro Curling Bar','Curling bar',50, NULL);
INSERT INTO s_product VALUES ('41010', 'Prostar 10 Pound Weight','Ten pound weight',8, NULL);
INSERT INTO s_product VALUES ('41020', 'Prostar 20 Pound Weight','Twenty pound weight',12, NULL);
INSERT INTO s_product VALUES ('41050', 'Prostar 50 Pound Weight','Fifty pound weight',25, NULL);
INSERT INTO s_product VALUES ('41080', 'Prostar 80 Pound Weight','Eighty pound weight',35, NULL);
INSERT INTO s_product VALUES ('41100', 'Prostar 100 Pound Weight','One hundred pound weight',45, NULL);
INSERT INTO s_product VALUES ('50169', 'Major League Baseball','Baseball',4.29, NULL);
INSERT INTO s_product VALUES ('50273', 'Chapman Helmet','Batting helmet',22.89, NULL);
INSERT INTO s_product VALUES ('50417', 'Griffey Glove','Outfielder''s glove',80, NULL);
INSERT INTO s_product VALUES ('50418', 'Alomar Glove','Infielder''s glove',75, NULL);
INSERT INTO s_product VALUES ('50419', 'Steinbach Glove','Catcher''s glove',80, NULL);
INSERT INTO s_product VALUES ('50530', 'Cabrera Bat','Thirty inch bat',45, NULL);
INSERT INTO s_product VALUES ('50532', 'Puckett Bat','Thirty-two inch bat',47, NULL);
INSERT INTO s_product VALUES ('50536', 'Winfield Bat','Thirty-six inch bat',50, NULL);
COMMIT;


#	************** S_REGION TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_region;
CREATE TABLE s_region 
(id          VARCHAR(3)  NOT NULL,
 name        VARCHAR(26)  NOT NULL,
 CONSTRAINT s_region_id_pk PRIMARY KEY (id),
 CONSTRAINT s_region_name_uk UNIQUE (name)
);


INSERT INTO s_region VALUES ('1', 'North America');
INSERT INTO s_region VALUES ('2', 'South America');
INSERT INTO s_region VALUES ('3', 'Africa / Middle East');
INSERT INTO s_region VALUES ('4', 'Asia');
INSERT INTO s_region VALUES ('5', 'Europe');
INSERT INTO s_region VALUES ('6', 'Central America /Caribbean');
COMMIT;


#	************** S_TITLE TABLE ********************************
#	*****************************************************************

DROP TABLE IF EXISTS s_title;
CREATE TABLE s_title
(title       VARCHAR(25) NOT NULL,
 CONSTRAINT s_title_title_pk PRIMARY KEY (title)
);

INSERT INTO s_title VALUES ('President');
INSERT INTO s_title VALUES ('Sales Representative');
INSERT INTO s_title VALUES ('Stock Clerk');
INSERT INTO s_title VALUES ('VP, Administration');
INSERT INTO s_title VALUES ('VP, Finance');
INSERT INTO s_title VALUES ('VP, Operations');
INSERT INTO s_title VALUES ('VP, Sales');
INSERT INTO s_title VALUES ('Warehouse Manager');
COMMIT;

#	************** S_WAREHOUSE TABLE ********************************
#	*****************************************************************


DROP TABLE IF EXISTS s_warehouse;
CREATE TABLE s_warehouse 
(id             VARCHAR(7) NOT NULL,
 region_id      VARCHAR(3) NOT NULL,
 address        VARCHAR(20),
 city           VARCHAR(20),
 state          VARCHAR(15),
 country        VARCHAR(20),
 zip_code       VARCHAR(15),
 phone          VARCHAR(20),
 manager_id     VARCHAR(3),
 CONSTRAINT s_warehouse_id_pk PRIMARY KEY (id)
);


INSERT INTO s_warehouse VALUES ('101', '1','283 King Street','Seattle', 'WA', 'US', NULL, 
NULL, '6');
INSERT INTO s_warehouse VALUES ('10501', '5','5 Modrany','Bratislava', NULL, 'Czechozlovakia',
NULL, NULL, '10');
INSERT INTO s_warehouse VALUES ('201', '2','68 Via Centrale','Sao Paolo', NULL, 'Brazil',NULL,
NULL, '7');
INSERT INTO s_warehouse VALUES ('301', '3','6921 King Way','Lagos', NULL, 'Nigeria',NULL,
NULL, '8');
INSERT INTO s_warehouse VALUES ('401', '4','86 Chu Street','Hong Kong', NULL, NULL,NULL,
NULL, '9');
COMMIT;

# AÑADIR FOREIGN KEYS Y CONSTRAINTS.

#	**********************************************************
#	**********************************************************
#	THE FOLLOWING CONSTRAINTS SHOULD BE INCLUDED
#	AS PART OF THE SPORTING GOODS (SG)SCRIPT. THEY SHOULD
#	NOT BE PART OF THE SG_NO_CONSTRAINTS.
# 	**********************************************************
#	*********************** CONSTRAINTS **********************

ALTER TABLE s_dept 
   ADD CONSTRAINT s_dept_region_id_fk
   FOREIGN KEY (region_id) REFERENCES s_region (id);
ALTER TABLE s_emp 
   ADD CONSTRAINT s_emp_manager_id_fk
   FOREIGN KEY (manager_id) REFERENCES s_emp (id);
ALTER TABLE s_emp 
   ADD CONSTRAINT s_emp_dept_id_fk
   FOREIGN KEY (dept_id) REFERENCES s_dept (id);
ALTER TABLE s_emp 
   ADD CONSTRAINT s_emp_title_fk
   FOREIGN KEY (title) REFERENCES s_title (title);
ALTER TABLE s_customer 
   ADD CONSTRAINT s_sales_rep_id_fk
   FOREIGN KEY (sales_rep_id) REFERENCES s_emp (id);
ALTER TABLE s_customer 
   ADD CONSTRAINT s_customer_region_id_fk
   FOREIGN KEY (region_id) REFERENCES s_region (id);
ALTER TABLE s_ord ADD CONSTRAINT s_ord_customer_id_fk
FOREIGN KEY (customer_id) REFERENCES s_customer (id);
ALTER TABLE s_ord 
   ADD CONSTRAINT s_ord_sales_rep_id_fk
   FOREIGN KEY (sales_rep_id) REFERENCES s_emp (id);
ALTER TABLE s_item 
   ADD CONSTRAINT s_item_ord_id_fk
   FOREIGN KEY (ord_id) REFERENCES s_ord (id);
ALTER TABLE s_item 
   ADD CONSTRAINT s_item_product_id_fk
   FOREIGN KEY (product_id) REFERENCES s_product (id);
ALTER TABLE s_warehouse 
   ADD CONSTRAINT s_warehouse_manager_id_fk
   FOREIGN KEY (manager_id) REFERENCES s_emp (id);
ALTER TABLE s_warehouse 
   ADD CONSTRAINT s_warehouse_region_id_fk
   FOREIGN KEY (region_id) REFERENCES s_region (id);
ALTER TABLE s_inventory 
   ADD CONSTRAINT s_inventory_product_id_fk
   FOREIGN KEY (product_id) REFERENCES s_product (id);
ALTER TABLE s_inventory 
   ADD CONSTRAINT s_inventory_warehouse_id_fk
   FOREIGN KEY (warehouse_id) REFERENCES s_warehouse (id);


