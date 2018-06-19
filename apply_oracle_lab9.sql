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
--   sql> @apply_oracle_lab9.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab8/apply_oracle_lab8.sql

SPOOL apply_oracle_lab9.log



--Step 1:  [4 points] Includes a TRANSACTION table as per the specification that uses the business logic of the model.
CREATE TABLE transaction
( transaction_id		INT		CONSTRAINT nn_transaction_1 NOT NULL
, transaction_account		VARCHAR2(15)	CONSTRAINT nn_transaction_2 NOT NULL
, transaction_type		INT		CONSTRAINT nn_transaction_3 NOT NULL
, transaction_date		DATE		CONSTRAINT nn_transaction_4 NOT NULL
, transaction_amount		FLOAT		CONSTRAINT nn_transaction_5 NOT NULL
, rental_id			INT		CONSTRAINT nn_transaction_6 NOT NULL
, payment_method_type		INT		CONSTRAINT nn_transaction_7 NOT NULL
, payment_account_number	VARCHAR2(19)	CONSTRAINT nn_transaction_8 NOT NULL
, created_by			INT		CONSTRAINT nn_transaction_9 NOT NULL
, creation_date			DATE		CONSTRAINT nn_transaction_10 NOT NULL
, last_updated_by		INT		CONSTRAINT nn_transaction_11 NOT NULL
, last_update_date		DATE		CONSTRAINT nn_transaction_12 NOT NULL
, CONSTRAINT transaction_id_pk PRIMARY KEY(transaction_id)
, CONSTRAINT transaction_type_fk FOREIGN KEY(transaction_type) REFERENCES common_lookup(common_lookup_id)
, CONSTRAINT rental_id_fk FOREIGN KEY(rental_id) REFERENCES rental(rental_id)
, CONSTRAINT payment_method_type_fk FOREIGN KEY(payment_method_type) REFERENCES common_lookup(common_lookup_id)
, CONSTRAINT created_by_2_fk FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)
, CONSTRAINT last_updated_by_2_fk FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id));

--SEQUENCE:
CREATE SEQUENCE transaction_s1 START WITH 1;

--NATURAL KEY UNIQUE INDEX:
CREATE UNIQUE INDEX natural_key
ON transaction (rental_id, transaction_type, transaction_date, payment_method_type, payment_account_number, transaction_account);



--Step 2:  [2 points] Insert the following nine rows into the COMMON_LOOKUP table with valid who-audit column data. After you insert the RENTAL_ITEM_TYPE column values, update the existing values in the RENTAL_ITEM_TYPE column of the RENTAL_ITEM table to point to the new COMMON_LOOKUP_ID column value.

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'CREDIT'
, 'Credit'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TRANSACTION'
, 'TRANSACTION_TYPE'
, 'CR');

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'DEBIT'
, 'Debit'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TRANSACTION'
, 'TRANSACTION_TYPE'
, 'DR');

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'DISCOVER_CARD'
, 'Discover card'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TRANSACTION'
, 'PAYMENT_METHOD_TYPE'
, NULL);

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'VISA_CARD'
, 'Visa card'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TRANSACTION'
, 'PAYMENT_METHOD_TYPE'
, NULL);

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'MASTER_CARD'
, 'Master card'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TRANSACTION'
, 'PAYMENT_METHOD_TYPE'
, NULL);

INSERT INTO common_lookup
VALUES
( common_lookup_s1.NEXTVAL
, 'CASH'
, 'Cash'
, 1
, SYSDATE
, 1
, SYSDATE
, 'TRANSACTION'
, 'PAYMENT_METHOD_TYPE'
, NULL);




--Step 3:  [14 points] Create the following AIRPORT and ACCOUNT_LIST tables as per the specification, but do so understanding the business logic of the model.

CREATE TABLE airport
( airport_id		INT		CONSTRAINT nn_airport_1 NOT NULL
, airport_code		VARCHAR2(3)	CONSTRAINT nn_airport_2 NOT NULL
, airport_city		VARCHAR2(30)	CONSTRAINT nn_airport_3 NOT NULL
, city			VARCHAR2(30)	CONSTRAINT nn_airport_4 NOT NULL
, state_province	VARCHAR2(30)	CONSTRAINT nn_airport_5 NOT NULL
, created_by		INT		CONSTRAINT nn_airport_6 NOT NULL
, creation_date		DATE		CONSTRAINT nn_airport_7 NOT NULL
, last_updated_by	INT		CONSTRAINT nn_airport_8 NOT NULL
, last_update_date	DATE		CONSTRAINT nn_airport_9 NOT NULL
, CONSTRAINT airport_id_pk PRIMARY KEY(airport_id)
, CONSTRAINT created_by_3_fk FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)
, CONSTRAINT last_updated_by_3_fk FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id));

--SEQUENCE:
CREATE SEQUENCE airport_s1;

--UNIQUE NATURAL KEY INDEX:
CREATE UNIQUE INDEX nk_airport
ON airport (airport_code, airport_city, city, state_province);

INSERT INTO airport
VALUES
( airport_s1.NEXTVAL
, 'LAX'
, 'Los Angeles'
, 'Los Angeles'
, 'California'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO airport
VALUES
( airport_s1.NEXTVAL
, 'SLC'
, 'Salt Lake City'
, 'Provo'
, 'Utah'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO airport
VALUES
( airport_s1.NEXTVAL
, 'SLC'
, 'Salt Lake City'
, 'Spanish Fork'
, 'Utah'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO airport
VALUES
( airport_s1.NEXTVAL
, 'SFO'
, 'San Francisco'
, 'San Francisco'
, 'California'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO airport
VALUES
( airport_s1.NEXTVAL
, 'SJC'
, 'San Jose'
, 'San Jose'
, 'California'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO airport
VALUES
( airport_s1.NEXTVAL
, 'SJC'
, 'San Jose'
, 'San Carlos'
, 'California'
, 1
, SYSDATE
, 1
, SYSDATE);

CREATE TABLE account_list
( account_list_id		INT		CONSTRAINT nn_account_list_1 NOT NULL
, account_number		VARCHAR2(10)	CONSTRAINT nn_account_list_2 NOT NULL
, consumed_date			DATE		
, consumed_by			INT
, created_by			INT		CONSTRAINT nn_account_list_3 NOT NULL
, creation_date			DATE		CONSTRAINT nn_account_list_4 NOT NULL
, last_updated_by		INT		CONSTRAINT nn_account_list_5 NOT NULL
, last_update_date		DATE		CONSTRAINT nn_account_list_6 NOT NULL
, CONSTRAINT account_list_id_pk PRIMARY KEY(account_list_id)
, CONSTRAINT consumed_by_fk FOREIGN KEY(consumed_by) REFERENCES system_user(system_user_id)
, CONSTRAINT created_by_4_fk FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)
, CONSTRAINT last_updated_by_4_fk FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id));

--SEQUENCE:
CREATE SEQUENCE account_list_s1;

-- Create or replace seeding procedure.
CREATE OR REPLACE PROCEDURE seed_account_list IS
BEGIN
  /* Set savepoint. */
  SAVEPOINT all_or_none;
 
  FOR i IN (SELECT DISTINCT airport_code FROM airport) LOOP
    FOR j IN 1..50 LOOP
 
      INSERT INTO account_list
      VALUES
      ( account_list_s1.NEXTVAL
      , i.airport_code||'-'||LPAD(j,6,'0')
      , NULL
      , NULL
      , 2
      , SYSDATE
      , 2
      , SYSDATE);
    END LOOP;
  END LOOP;
 
  /* Commit the writes as a group. */
  COMMIT;
 
EXCEPTION
  WHEN OTHERS THEN
    /* This undoes all DML statements to this point in the procedure. */
    ROLLBACK TO SAVEPOINT all_or_none;
END;
/

--CALL PROCEDURE:
EXECUTE seed_account_list();

--UPDATE STATE ABBREVIATIONS TO FULL NAMES:
UPDATE address
SET    state_province = 'California'
WHERE  state_province = 'CA';

--CREATE OR REPLACE PROCEDURE:
CREATE OR REPLACE PROCEDURE update_member_account IS
 
  /* Declare a local variable. */
  lv_account_number VARCHAR2(10);
 
  /* Declare a SQL cursor fabricated from local variables. */  
  CURSOR member_cursor IS
    SELECT   DISTINCT
             m.member_id
    ,        a.city
    ,        a.state_province
    FROM     member m INNER JOIN contact c
    ON       m.member_id = c.member_id INNER JOIN address a
    ON       c.contact_id = a.contact_id
    ORDER BY m.member_id;
 
BEGIN
 
  /* Set savepoint. */  
  SAVEPOINT all_or_none;
 
  /* Open a local cursor. */  
  FOR i IN member_cursor LOOP
 
      /* Secure a unique account number as they're consumed from the list. */
      SELECT al.account_number
      INTO   lv_account_number
      FROM   account_list al INNER JOIN airport ap
      ON     SUBSTR(al.account_number,1,3) = ap.airport_code
      WHERE  ap.city = i.city
      AND    ap.state_province = i.state_province
      AND    consumed_by IS NULL
      AND    consumed_date IS NULL
      AND    ROWNUM < 2;
 
      /* Update a member with a unique account number linked to their nearest airport. */
      UPDATE member
      SET    account_number = lv_account_number
      WHERE  member_id = i.member_id;
 
      /* Mark consumed the last used account number. */      
      UPDATE account_list
      SET    consumed_by = 2
      ,      consumed_date = SYSDATE
      WHERE  account_number = lv_account_number;
 
  END LOOP;
 
  /* Commit the writes as a group. */
  COMMIT;
 
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('You have an error in your AIRPORT table inserts.');
 
    /* This undoes all DML statements to this point in the procedure. */
    ROLLBACK TO SAVEPOINT all_or_none;
  WHEN OTHERS THEN
    /* This undoes all DML statements to this point in the procedure. */
    ROLLBACK TO SAVEPOINT all_or_none;
END;
/


--CALL PROCEDURE:
EXECUTE update_member_account();





--Step 4:  [5 points] Create the following TRANSACTION_UPLOAD table as per the specification, but do so understanding the business logic of the model.



CREATE TABLE transaction_upload
( account_number		VARCHAR2(10)
, first_name			VARCHAR2(20)
, middle_name			VARCHAR2(20)
, last_name			VARCHAR2(20)
, check_out_date		DATE
, return_date			DATE
, rental_item_type		VARCHAR2(12)
, transaction_type		VARCHAR2(14)
, transaction_amount		FLOAT
, transaction_date		DATE
, item_id			INT
, payment_method_type		VARCHAR2(14)
, payment_account_number	VARCHAR2(19))
  ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "UPLOAD"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE CHARACTERSET US7ASCII
      BADFILE     'UPLOAD':'transaction_upload.bad'
      DISCARDFILE 'UPLOAD':'transaction_upload.dis'
      LOGFILE     'UPLOAD':'transaction_upload.log'
      FIELDS TERMINATED BY ','
      OPTIONALLY ENCLOSED BY "'"
      MISSING FIELD VALUES ARE NULL     )
      LOCATION
       ( 'transaction_upload.csv'
       )
    )
   REJECT LIMIT UNLIMITED;


--VERIFICATION SCRIPTS:

--Step 1:
COLUMN table_name   FORMAT A14  HEADING "Table Name"
COLUMN column_id    FORMAT 9999 HEADING "Column ID"
COLUMN column_name  FORMAT A22  HEADING "Column Name"
COLUMN nullable     FORMAT A8   HEADING "Nullable"
COLUMN data_type    FORMAT A12  HEADING "Data Type"
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
WHERE    table_name = 'TRANSACTION'
ORDER BY 2;


COLUMN table_name       FORMAT A12  HEADING "Table Name"
COLUMN index_name       FORMAT A16  HEADING "Index Name"
COLUMN uniqueness       FORMAT A8   HEADING "Unique"
COLUMN column_position  FORMAT 9999 HEADING "Column Position"
COLUMN column_name      FORMAT A24  HEADING "Column Name"
SELECT   i.table_name
,        i.index_name
,        i.uniqueness
,        ic.column_position
,        ic.column_name
FROM     user_indexes i INNER JOIN user_ind_columns ic
ON       i.index_name = ic.index_name
WHERE    i.table_name = 'TRANSACTION'
AND      i.uniqueness = 'UNIQUE'
AND      i.index_name = 'NATURAL_KEY';


--Step 2:

COLUMN common_lookup_table  FORMAT A20 HEADING "COMMON_LOOKUP_TABLE"
COLUMN common_lookup_column FORMAT A20 HEADING "COMMON_LOOKUP_COLUMN"
COLUMN common_lookup_type   FORMAT A20 HEADING "COMMON_LOOKUP_TYPE"
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
WHERE    common_lookup_table = 'TRANSACTION'
AND      common_lookup_column IN ('TRANSACTION_TYPE','PAYMENT_METHOD_TYPE')
ORDER BY 1, 2, 3 DESC;


--Step 3:

COLUMN table_name   FORMAT A14  HEADING "Table Name"
COLUMN column_id    FORMAT 9999 HEADING "Column ID"
COLUMN column_name  FORMAT A22  HEADING "Column Name"
COLUMN nullable     FORMAT A8   HEADING "Nullable"
COLUMN data_type    FORMAT A12  HEADING "Data Type"
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
WHERE    table_name = 'AIRPORT'
ORDER BY 2;


COLUMN table_name       FORMAT A12  HEADING "Table Name"
COLUMN index_name       FORMAT A16  HEADING "Index Name"
COLUMN uniqueness       FORMAT A8   HEADING "Unique"
COLUMN column_position  FORMAT 9999 HEADING "Column Position"
COLUMN column_name      FORMAT A24  HEADING "Column Name"
SELECT   i.table_name
,        i.index_name
,        i.uniqueness
,        ic.column_position
,        ic.column_name
FROM     user_indexes i INNER JOIN user_ind_columns ic
ON       i.index_name = ic.index_name
WHERE    i.table_name = 'AIRPORT'
AND      i.uniqueness = 'UNIQUE'
AND      i.index_name = 'NK_AIRPORT';


COLUMN code           FORMAT A4  HEADING "Code"
COLUMN airport_city   FORMAT A14 HEADING "Airport City"
COLUMN city           FORMAT A14 HEADING "City"
COLUMN state_province FORMAT A10 HEADING "State or|Province"
SELECT   airport_code AS code
,        airport_city
,        city
,        state_province
FROM     airport;


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
WHERE    table_name = 'ACCOUNT_LIST'
ORDER BY 2;


COLUMN object_name FORMAT A18
COLUMN object_type FORMAT A12
SELECT   object_name
,        object_type
FROM     user_objects
WHERE    object_name = 'SEED_ACCOUNT_LIST';


COLUMN airport FORMAT A7
SELECT   SUBSTR(account_number,1,3) AS "Airport"
,        COUNT(*) AS "# Accounts"
FROM     account_list
WHERE    consumed_date IS NULL
GROUP BY SUBSTR(account_number,1,3)
ORDER BY 1;


COLUMN object_name FORMAT A22
COLUMN object_type FORMAT A12
SELECT   object_name
,        object_type
FROM     user_objects
WHERE    object_name = 'UPDATE_MEMBER_ACCOUNT';


-- Format the SQL statement display.
COLUMN member_id      FORMAT 999999 HEADING "Member|ID #"
COLUMN last_name      FORMAT A10    HEADING "Last|Name"
COLUMN account_number FORMAT A10 HEADING "Account|Number"
COLUMN city           FORMAT A16 HEADING "City"
COLUMN state_province FORMAT A10 HEADING "State or|Province"
 
-- Query distinct members and addresses.
SELECT   DISTINCT
         m.member_id
,        c.last_name
,        m.account_number
,        a.city
,        a.state_province
FROM     member m INNER JOIN contact c
ON       m.member_id = c.member_id INNER JOIN address a
ON       c.contact_id = a.contact_id
ORDER BY 1;

--Step 4:
SELECT   COUNT(*) AS "External Rows"
FROM     transaction_upload;


SPOOL OFF
