-- ----------------------------------------------------------------------
-- Instructions:
-- ----------------------------------------------------------------------
-- The two scripts contain spooling commands, which is why there
-- isn't a spooling command in this script. When you run this file
-- you first connect to the Oracle database with this syntax:
--
--   sqlplus student/student@xe
--
-- Then, you call this script with the following syntax:
--
--   sql> @apply_oracle_lab6.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab5/apply_oracle_lab5.sql

SPOOL apply_oracle_lab6.log

--[2 points] This occurs by working with the, create_oracle_store.sql script. It creates the beginning data model. Change the RENTAL_ITEM table by adding the RENTAL_ITEM_TYPE and RENTAL_ITEM_PRICE columns. Both columns should use a NUMBER data type.

SELECT 'Step 1' AS CODE FROM dual;

ALTER TABLE rental_item
	ADD (rental_item_type 	NUMBER)
	ADD (rental_item_price 	NUMBER);
	
	
--[3 points] Create the following PRICE table as per the specification, like the description below.

SELECT 'Step 2' AS CODE FROM dual;

CREATE TABLE price
( price_id		INT
, item_id		INT		CONSTRAINT nn_price_1 NOT NULL
, price_type		INT
, active_flag		VARCHAR2(1)	CONSTRAINT nn_price_2 NOT NULL
, start_date		DATE		CONSTRAINT nn_price_3 NOT NULL
, end_date		DATE
, amount		INT		CONSTRAINT nn_price_4 NOT NULL
, created_by		INT		CONSTRAINT nn_price_5 NOT NULL
, creation_date 	DATE		CONSTRAINT nn_price_6 NOT NULL
, last_updated_by	INT		CONSTRAINT nn_price_7 NOT NULL
, last_updated_date	DATE		CONSTRAINT nn_price_8 NOT NULL
, CONSTRAINT price_id_pk PRIMARY KEY(price_id)
, CONSTRAINT item_id_fk FOREIGN KEY(item_id) REFERENCES item(item_id)
, CONSTRAINT price_type_fk FOREIGN KEY(price_type) REFERENCES common_lookup(common_lookup_id)
, CONSTRAINT created_by_fk FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)
, CONSTRAINT last_updated_by_fk FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id)
, CONSTRAINT yn_price CHECK (active_flag IN ('Y', 'N')));

--[10 points] Insert new data into the model (Check Step #03 on the referenced web page for details).

SELECT 'Step 3' AS CODE FROM dual;

--Part a
ALTER TABLE item
RENAME COLUMN item_release_date TO release_date;

--Part b
INSERT INTO item
VALUES
( item_s1.NEXTVAL
, '0000-0001'
, 1010
, 'Tron'
, NULL
, 'PG-13'
, SYSDATE
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO item
VALUES
( item_s1.NEXTVAL
, '0000-0002'
, 1010
, 'Enders Game'
, NULL
, 'PG-13'
, SYSDATE
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO item
VALUES
( item_s1.NEXTVAL
, '0000-0003'
, 1010
, 'Elysium'
, NULL
, 'PG-13'
, SYSDATE
, 1
, SYSDATE
, 1
, SYSDATE);

--Part c
INSERT INTO member
VALUES
( member_s1.NEXTVAL
, 1004
, '2983-49837'
, '3987-0987-0938-0984'
, 1005
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact
VALUES
( contact_s1.NEXTVAL
, member_s1.CURRVAL
, 1002
, 'Harry'
, NULL
, 'Potter'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address
VALUES
( address_s1.NEXTVAL
, contact_s1.CURRVAL
, 1008
, 'Provo'
, 'Utah'
, '29849'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address
VALUES
( street_address_s1.NEXTVAL
, address_s1.CURRVAL
, '1350 Fake Road'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone
VALUES
( telephone_s1.NEXTVAL
, contact_s1.CURRVAL
, address_s1.CURRVAL
, 1008
, '011'
, '801'
, '423-8475'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact
VALUES
( contact_s1.NEXTVAL
, member_s1.CURRVAL
, 1002
, 'Ginny'
, NULL
, 'Potter'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address
VALUES
( address_s1.NEXTVAL
, contact_s1.CURRVAL
, 1008
, 'Provo'
, 'Utah'
, '29849'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address
VALUES
( street_address_s1.NEXTVAL
, address_s1.CURRVAL
, '1350 Fake Road'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone
VALUES
( telephone_s1.NEXTVAL
, contact_s1.CURRVAL
, address_s1.CURRVAL
, 1008
, '011'
, '801'
, '423-8475'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact
VALUES
( contact_s1.NEXTVAL
, member_s1.CURRVAL
, 1002
, 'Lily'
, 'Luna'
, 'Potter'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address
VALUES
( address_s1.NEXTVAL
, contact_s1.CURRVAL
, 1008
, 'Provo'
, 'Utah'
, '29849'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address
VALUES
( street_address_s1.NEXTVAL
, address_s1.CURRVAL
, '1350 Fake Road'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone
VALUES
( telephone_s1.NEXTVAL
, contact_s1.CURRVAL
, address_s1.CURRVAL
, 1008
, '011'
, '801'
, '423-8475'
, 1
, SYSDATE
, 1
, SYSDATE);

--Part d
INSERT INTO rental
VALUES
( rental_s1.NEXTVAL
, 1013
, SYSDATE
, (SYSDATE + 1)
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
VALUES
( rental_item_s1.NEXTVAL
, rental_s1.CURRVAL
, (SELECT item_id FROM item WHERE item_title = 'Tron')
, 1
, SYSDATE
, 1
, SYSDATE
, NULL
, NULL);

INSERT INTO rental_item
VALUES
( rental_item_s1.NEXTVAL
, rental_s1.CURRVAL
, (SELECT item_id FROM item WHERE item_title = 'Enders Game')
, 1
, SYSDATE
, 1
, SYSDATE
, NULL
, NULL);

INSERT INTO rental
VALUES
( rental_s1.NEXTVAL
, 1014
, SYSDATE
, (SYSDATE + 3)
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
VALUES
( rental_item_s1.NEXTVAL
, rental_s1.CURRVAL
, (SELECT item_id FROM item WHERE item_title = 'Enders Game')
, 1
, SYSDATE
, 1
, SYSDATE
, NULL
, NULL);

INSERT INTO rental
VALUES
( rental_s1.NEXTVAL
, 1015
, SYSDATE
, (SYSDATE + 5)
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item
VALUES
( rental_item_s1.NEXTVAL
, rental_s1.CURRVAL
, (SELECT item_id FROM item WHERE item_title = 'Elysium')
, 1
, SYSDATE
, 1
, SYSDATE
, NULL
, NULL);


--INSERT INTO rental VALUES ( rental_s1.nextval ,(SELECT   contact_id  FROM     contact  WHERE    last_name = 'Potter'  AND      first_name = 'Ginny') , TRUNC(SYSDATE), TRUNC(SYSDATE) + 3 , 3, SYSDATE, 3, SYSDATE);

--[20 points] Modify the design of the COMMON_LOOKUP table following the definitions below, insert new data into the model, and update old non-compliant design data in the model (Check Step #4 on the referenced web page for details).

SELECT 'Step 4' AS CODE FROM dual;

--Part a
DROP INDEX common_lookup_n1;
DROP INDEX common_lookup_u2;

--Part b
ALTER TABLE common_lookup
	ADD (common_lookup_table	VARCHAR2(30))
	ADD (common_lookup_column	VARCHAR2(30))
	ADD (common_lookup_code		VARCHAR2(30));

--Part c
UPDATE 	common_lookup
SET	common_lookup_table = 
	CASE
		WHEN common_lookup_context = 'MULTIPLE' THEN 'ADDRESS'
		ELSE common_lookup_context
	END;

UPDATE 	common_lookup
SET 	common_lookup_column = common_lookup_context || '_TYPE'
		WHERE common_lookup_table = 'MEMBER' 
		AND common_lookup_type = 'INDIVIDUAL' 
		OR common_lookup_type = 'GROUP';

UPDATE 	common_lookup
SET	common_lookup_column = 'CREDIT_CARD_TYPE'
		WHERE common_lookup_type = 'VISA_CARD'  
		OR common_lookup_type = 'MASTER_CARD'
		OR common_lookup_type = 'DISCOVER_CARD';

UPDATE 	common_lookup
SET	common_lookup_column = 'ADDRESS_TYPE'
		WHERE common_lookup_context = 'MULTIPLE';

UPDATE 	common_lookup
SET	common_lookup_column = common_lookup_context || '_TYPE'
		WHERE common_lookup_context != 'MEMBER' 
		OR common_lookup_context != 'MULTIPLE';
	
INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'Phone'
, 'HOME'
, 'Home'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TELEPHONE'
, 'TELEPHONE_TYPE'
, NULL);

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'Phone'
, 'WORK'
, 'Work'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TELEPHONE'
, 'TELEPHONE_TYPE'
, NULL);

UPDATE telephone
SET telephone_type = 
	(SELECT common_lookup_id
	 FROM common_lookup
	 WHERE common_lookup_table = 'TELEPHONE'
	 AND common_lookup_type = 'HOME')
WHERE telephone_type = 
	(SELECT common_lookup_id
	 FROM 	common_lookup
	 WHERE common_lookup_table = 'ADDRESS'
	 AND common_lookup_type = 'HOME');

UPDATE telephone
SET telephone_type = 
	(SELECT common_lookup_id
	 FROM common_lookup
	 WHERE common_lookup_table = 'TELEPHONE'
	 AND common_lookup_type = 'WORK')
WHERE telephone_type = 
	(SELECT common_lookup_id
	 FROM 	common_lookup
	 WHERE common_lookup_table = 'ADDRESS'
	 AND common_lookup_type = 'WORK');
	

--Part d
ALTER TABLE common_lookup
DROP COLUMN common_lookup_context;

ALTER TABLE common_lookup
MODIFY (common_lookup_table VARCHAR2(30) NOT NULL);

ALTER TABLE common_lookup
MODIFY (common_lookup_column VARCHAR2(30) NOT NULL);

CREATE UNIQUE INDEX common_lookup_u2
ON common_lookup (common_lookup_table, common_lookup_column, common_lookup_type);


--Verification:
--NVL oracle function

--Step 1
SELECT 'Step 1' AS VERIFY FROM dual;

SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'RENTAL_ITEM'
ORDER BY 2;

--Step 2
SELECT 'Step 2' AS VERIFY FROM dual;

SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'PRICE'
ORDER BY 2;

SELECT 'Step 2-Constraint' AS VERIFY FROM dual;

COLUMN constraint_name   FORMAT A16
COLUMN search_condition  FORMAT A30
SELECT   uc.constraint_name
,        uc.search_condition
FROM     user_constraints uc INNER JOIN user_cons_columns ucc
ON       uc.table_name = ucc.table_name
AND      uc.constraint_name = ucc.constraint_name
WHERE    uc.table_name = UPPER('price')
AND      ucc.column_name = UPPER('active_flag')
AND      uc.constraint_name = UPPER('yn_price')
AND      uc.constraint_type = 'C';

--Step 3
SELECT 'Step 3' AS VERIFY FROM dual;

--Step 3.a
SET NULL ''
COLUMN TABLE_NAME   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   TABLE_NAME
,        column_id
,        column_name
,        CASE
           WHEN NULLABLE = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS NULLABLE
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    TABLE_NAME = 'ITEM'
ORDER BY 2;

--Step 3.b
SELECT   i.item_title
,        SYSDATE AS today
,        i.release_date
FROM     item i
WHERE   (SYSDATE - i.release_date) < 31;

--Step 3.c
COLUMN full_name FORMAT A20
COLUMN city      FORMAT A10
COLUMN state     FORMAT A10
SELECT   c.last_name || ', ' || c.first_name AS full_name
,        a.city
,        a.state_province AS state
FROM     member m INNER JOIN contact c
ON       m.member_id = c.member_id INNER JOIN address a
ON       c.contact_id = a.contact_id INNER JOIN street_address sa
ON       a.address_id = sa.address_id INNER JOIN telephone t
ON       c.contact_id = t.contact_id
WHERE    c.last_name = 'Potter';

--Step 3.d
COLUMN full_name   FORMAT A18
COLUMN rental_id   FORMAT 9999
COLUMN rental_days FORMAT A14
COLUMN rentals     FORMAT 9999
COLUMN items       FORMAT 9999
SELECT   c.last_name||', '||c.first_name||' '||c.middle_name AS full_name
,        r.rental_id
,       (r.return_date - r.check_out_date) || '-DAY RENTAL' AS rental_days
,        COUNT(DISTINCT r.rental_id) AS rentals
,        COUNT(ri.rental_item_id) AS items
FROM     rental r INNER JOIN rental_item ri
ON       r.rental_id = ri.rental_id INNER JOIN contact c
ON       r.customer_id = c.contact_id
WHERE   (SYSDATE - r.check_out_date) < 15
AND      c.last_name = 'Potter'
GROUP BY c.last_name||', '||c.first_name||' '||c.middle_name
,        r.rental_id
,       (r.return_date - r.check_out_date) || '-DAY RENTAL'
ORDER BY 2;

--Step 4
SELECT 'Step 4' AS VERIFY FROM dual;

--Step 4.a
COLUMN table_name FORMAT A14
COLUMN index_name FORMAT A20
SELECT   table_name
,        index_name
FROM     user_indexes
WHERE    table_name = 'COMMON_LOOKUP';

--Step 4.b
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'COMMON_LOOKUP'
ORDER BY 2;

--Step 4.c
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'COMMON_LOOKUP'
ORDER BY 2;

COLUMN common_lookup_table  FORMAT A20
COLUMN common_lookup_column FORMAT A20
COLUMN common_lookup_type   FORMAT A20
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
ORDER BY 1, 2, 3;

COLUMN common_lookup_table  FORMAT A14 HEADING "Common|Lookup Table"
COLUMN common_lookup_column FORMAT A14 HEADING "Common|Lookup Column"
COLUMN common_lookup_type   FORMAT A8  HEADING "Common|Lookup|Type"
COLUMN count_dependent      FORMAT 999 HEADING "Count of|Foreign|Keys"
COLUMN count_lookup         FORMAT 999 HEADING "Count of|Primary|Keys"
SELECT   cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type
,        COUNT(a.address_id) AS count_dependent
,        COUNT(DISTINCT cl.common_lookup_table) AS count_lookup
FROM     address a RIGHT JOIN common_lookup cl
ON       a.address_type = cl.common_lookup_id
WHERE    cl.common_lookup_table = 'ADDRESS'
AND      cl.common_lookup_column = 'ADDRESS_TYPE'
AND      cl.common_lookup_type IN ('HOME','WORK')
GROUP BY cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type
UNION
SELECT   cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type
,        COUNT(t.telephone_id) AS count_dependent
,        COUNT(DISTINCT cl.common_lookup_table) AS count_lookup
FROM     telephone t RIGHT JOIN common_lookup cl
ON       t.telephone_type = cl.common_lookup_id
WHERE    cl.common_lookup_table = 'TELEPHONE'
AND      cl.common_lookup_column = 'TELEPHONE_TYPE'
AND      cl.common_lookup_type IN ('HOME','WORK')
GROUP BY cl.common_lookup_table
,        cl.common_lookup_column
,        cl.common_lookup_type;

--Step 4.d
SET NULL ''
COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'COMMON_LOOKUP'
ORDER BY 2;

COLUMN table_name FORMAT A14
COLUMN index_name FORMAT A20
SELECT   table_name
,        index_name
FROM     user_indexes
WHERE    table_name = 'COMMON_LOOKUP';

SPOOL OFF
