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
--   sql> @apply_oracle_lab11.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab11/apply_oracle_lab11.sql

SPOOL apply_oracle_lab12.log



--    [3 points] Create the following CALENDAR table as per the specification.-----------------------------------------------------------

CREATE TABLE calendar
( calendar_id		INT	
, calendar_name		VARCHAR2(10)	CONSTRAINT nn_calendar_1 NOT NULL
, calendar_short_name	VARCHAR2(3)	CONSTRAINT nn_calendar_2 NOT NULL
, start_date		DATE		CONSTRAINT nn_calendar_3 NOT NULL
, end_date		DATE		CONSTRAINT nn_calendar_4 NOT NULL
, created_by		INT		
, creation_date		DATE		CONSTRAINT nn_calendar_5 NOT NULL
, last_updated_by	INT		
, last_update_date	DATE		CONSTRAINT nn_calendar_6 NOT NULL
, CONSTRAINT calendar_id_pk PRIMARY KEY(calendar_id)
, CONSTRAINT calendar_created_by_fk FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)
, CONSTRAINT calendar_last_updated_by_fk FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id));

--SEQUENCE:
CREATE SEQUENCE calendar_s1 START WITH 1;

--    [3 points] Seed the CALENDAR table with the following data.------------------------------------------------------------------------

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'January'
, 'JAN'
, '01-JAN-2009'
, '31-JAN-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'February'
, 'FEB'
, '01-FEB-2009'
, '28-FEB-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'March'
, 'MAR'
, '01-MAR-2009'
, '31-MAR-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'April'
, 'APR'
, '01-APR-2009'
, '30-APR-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'May'
, 'MAY'
, '01-MAY-2009'
, '31-MAY-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'June'
, 'JUN'
, '01-JUN-2009'
, '30-JUN-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'July'
, 'JUL'
, '01-JUL-2009'
, '31-JUL-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'AUGUST'
, 'AUG'
, '01-AUG-2009'
, '31-AUG-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'September'
, 'SEP'
, '01-SEP-2009'
, '30-SEP-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'October'
, 'OCT'
, '01-OCT-2009'
, '31-OCT-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'November'
, 'NOV'
, '01-NOV-2009'
, '30-NOV-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO calendar
VALUES
( calendar_s1.NEXTVAL
, 'December'
, 'DEC'
, '01-DEC-2009'
, '31-DEC-2009'
, 1
, SYSDATE
, 1
, SYSDATE);

--    [4 points] Import and merge the new *.csv files.----------------------------------------------------------------------------------

-- Set environment variables.
SET LONG 100000
SET PAGESIZE 0
 
-- Set a local variable of a character large object (CLOB).
VARIABLE ddl_text CLOB
 
-- Get the internal DDL command for the TRANSACTION table from the data dictionary.
SELECT dbms_metadata.get_ddl('TABLE','TRANSACTION') FROM dual;
 
-- Get the internal DDL command for the external TRANSACTION_UPLOAD table from the data dictionary.
SELECT dbms_metadata.get_ddl('TABLE','TRANSACTION_UPLOAD') FROM dual;

CREATE TABLE transaction_reversal
( transaction_id		INT
, transaction_account		VARCHAR2(15)
, transaction_type		INT
, transaction_date		DATE
, transaction_amount		FLOAT
, rental_id			INT
, payment_method_type		INT
, payment_account_number	VARCHAR2(19)
, created_by			INT
, creation_date			DATE
, last_updated_by		INT
, last_update_date		DATE)
  ORGANIZATION EXTERNAL
  ( TYPE oracle_loader
    DEFAULT DIRECTORY  upload
    ACCESS PARAMETERS
	( RECORDS DELIMITED BY NEWLINE CHARACTERSET US7ASCII                                                                           
      BADFILE     'UPLOAD':'transaction_upload.bad'                             
      DISCARDFILE 'UPLOAD':'transaction_upload.dis'                                                                       
      LOGFILE     'UPLOAD':'transaction_upload.log'                                                                               
      FIELDS TERMINATED BY ','                                                  
      OPTIONALLY ENCLOSED BY "'"                                                
      MISSING FIELD VALUES ARE NULL         )                                   
      LOCATION                                                                  
       ( 'transaction_upload.csv'                                               
       )                                                                        
    )                                                                           
   REJECT LIMIT UNLIMITED;


-- Move the data from TRANSACTION_REVERSAL to TRANSACTION.
INSERT INTO TRANSACTION
(SELECT transaction_id
, transaction_account
, transaction_type
, transaction_date
, transaction_amount
, rental_id
, payment_method_type
, payment_account_number
, created_by
, creation_date
, last_updated_by
, last_update_date
 FROM    transaction_reversal);


-- VERIFICATION SCRIPTS ----------------------------------------------------------------------------------------------------------------

COLUMN "Debit Transactions"  FORMAT A20
COLUMN "Credit Transactions" FORMAT A20
COLUMN "All Transactions"    FORMAT A20
 
-- Check current contents of the model.
SELECT 'SELECT record counts' AS "Statement" FROM dual;
SELECT   LPAD(TO_CHAR(c1.transaction_count,'99,999'),19,' ') AS "Debit Transactions"
,        LPAD(TO_CHAR(c2.transaction_count,'99,999'),19,' ') AS "Credit Transactions"
,        LPAD(TO_CHAR(c3.transaction_count,'99,999'),19,' ') AS "All Transactions"
FROM    (SELECT COUNT(*) AS transaction_count FROM transaction WHERE transaction_account = '111-111-111-111') c1 CROSS JOIN
        (SELECT COUNT(*) AS transaction_count FROM transaction WHERE transaction_account = '222-222-222-222') c2 CROSS JOIN
        (SELECT COUNT(*) AS transaction_count FROM transaction) c3;



SPOOL OFF
