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
--   sql> @apply_oracle_lab10.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab9/apply_oracle_lab9.sql

SPOOL apply_oracle_lab10.log


--STEP 1: ---------------------------------------------------------------------------------------------
--[15 points] Write a query that returns the rows necessary to insert records into the RENTAL table.
SELECT 'STEP 1' AS "CODE" FROM dual;

SELECT   COUNT(*) AS "Rental before count"
FROM     rental;

SELECT COUNT(*)
FROM (
SELECT DISTINCT
	r.rental_id
,	c.contact_id
,	tu.check_out_date AS check_out_date
,	tu.return_date AS return_date
,	1 AS created_by
,	TRUNC(SYSDATE) AS creation_date
,	1 AS last_updated_by
,	TRUNC(SYSDATE) AS last_update_date
FROM	member m INNER JOIN contact c
ON	m.member_id = c.member_id INNER JOIN transaction_upload tu
ON	c.first_name = tu.first_name--MEMBER ACCOUNT_NUMBER/CONTACT FN MN LN
AND	NVL(c.middle_name, 'x') = NVL(tu.middle_name, 'x')
AND	c.last_name = tu.last_name
AND	tu.account_number = m.account_number LEFT OUTER JOIN rental r
ON	c.contact_id = r.customer_id
AND	TRUNC(tu.check_out_date) = TRUNC(r.check_out_date)
AND	TRUNC(tu.return_date) = TRUNC(r.return_date) );


SET NULL '<Null>'
COLUMN rental_id        FORMAT 9999 HEADING "Rental|ID #"
COLUMN customer         FORMAT 9999 HEADING "Customer|ID #"
COLUMN check_out_date   FORMAT A9   HEADING "Check Out|Date"
COLUMN return_date      FORMAT A10  HEADING "Return|Date"
COLUMN created_by       FORMAT 9999 HEADING "Created|By"
COLUMN creation_date    FORMAT A10  HEADING "Creation|Date"
COLUMN last_updated_by  FORMAT 9999 HEADING "Last|Update|By"
COLUMN last_update_date FORMAT A10  HEADING "Last|Updated"
INSERT INTO rental
SELECT 	NVL(r.rental_id,rental_s1.NEXTVAL) AS rental_id
,	r.contact_id--r.customer_id
,	r.check_out_date
,	r.return_date
,	r.created_by
,	r.creation_date
,	r.last_updated_by
,	r.last_update_date
FROM (SELECT DISTINCT
		r.rental_id
	,	c.contact_id
	,	tu.check_out_date AS check_out_date
	,	tu.return_date AS return_date
	,	1 AS created_by
	,	TRUNC(SYSDATE) AS creation_date
	,	1 AS last_updated_by
	,	TRUNC(SYSDATE) AS last_update_date
	FROM	member m INNER JOIN contact c
	ON	m.member_id = c.member_id INNER JOIN transaction_upload tu
	ON	c.first_name = tu.first_name--MEMBER ACCOUNT_NUMBER/CONTACT FN MN LN
	AND	NVL(c.middle_name, 'x') = NVL(tu.middle_name, 'x')
	AND	c.last_name = tu.last_name
	AND	tu.account_number = m.account_number LEFT OUTER JOIN rental r
	ON	c.contact_id = r.customer_id
	AND	TRUNC(tu.check_out_date) = TRUNC(r.check_out_date)
	AND	TRUNC(tu.return_date) = TRUNC(r.return_date)) r;

/*
SELECT 	DISTINCT c.contact_id
FROM	member m INNER JOIN contact c
ON	m.member_id = c.member_id INNER JOIN transaction_upload tu
ON	c.first_name = tu.first_name--MEMBER ACCOUNT_NUMBER/CONTACT FN MN LN
AND	NVL(c.middle_name, 'x') = NVL(tu.middle_name, 'x')
AND	c.last_name = tu.last_name
AND	m.account_number = tu.account_number LEFT OUTER JOIN rental r
ON	tu.item_id = r.rental_id;
*/



SELECT   COUNT(*) AS "Rental after count"
FROM     rental;


--verify
SELECT   COUNT(*)
FROM     member m INNER JOIN contact c
ON       m.member_id = c.member_id;

--verify
SELECT   COUNT(*)
FROM     contact c INNER JOIN transaction_upload tu
ON       c.first_name = tu.first_name
AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
AND      c.last_name = tu.last_name;


--verify
SELECT   COUNT(*)
FROM     member m INNER JOIN contact c
ON       m.member_id = c.member_id INNER JOIN transaction_upload tu
ON       c.first_name = tu.first_name
AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
AND      c.last_name = tu.last_name
AND      m.account_number = tu.account_number;




--STEP 2: --------------------------------------------------------------------------------------------------
--[15 points] Write a query that returns the rows necessary to insert records into the RENTAL_ITEM table.
SELECT 'STEP 2' AS "CODE" FROM dual;


SET NULL '<Null>'
COLUMN rental_item_id     FORMAT 99999 HEADING "Rental|Item ID #"
COLUMN rental_id          FORMAT 99999 HEADING "Rental|ID #"
COLUMN item_id            FORMAT 99999 HEADING "Item|ID #"
COLUMN rental_item_price  FORMAT 99999 HEADING "Rental|Item|Price"
COLUMN rental_item_type   FORMAT 99999 HEADING "Rental|Item|Type"

SELECT COUNT(*)
FROM (
SELECT	ri.rental_item_id
,	r.rental_id
,	tu.item_id
,	1 AS created_by
,	TRUNC(SYSDATE) AS creation_date
,	1 AS last_updated_by
,	TRUNC(SYSDATE) AS last_update_date
,	cl.common_lookup_id AS rental_item_type
,	r.return_date - r.check_out_date AS rental_item_price
FROM	member m INNER JOIN contact c
ON	m.member_id = c.member_id INNER JOIN transaction_upload tu
ON	c.first_name = tu.first_name--MEMBER ACCOUNT_NUMBER/CONTACT FN MN LN
AND	NVL(c.middle_name, 'x') = NVL(tu.middle_name, 'x')
AND	c.last_name = tu.last_name
AND	tu.account_number = m.account_number LEFT OUTER JOIN rental r
ON	c.contact_id = r.customer_id
AND	TRUNC(tu.check_out_date) = TRUNC(r.check_out_date)
AND	TRUNC(tu.return_date) = TRUNC(r.return_date) INNER JOIN common_lookup cl
ON	cl.common_lookup_table = 'RENTAL_ITEM'
AND	cl.common_lookup_column = 'RENTAL_ITEM_TYPE'
AND	cl.common_lookup_type = tu.rental_item_type LEFT OUTER JOIN rental_item ri
ON	r.rental_id = ri.rental_id);


SELECT   COUNT(*) AS "Rental Item Before Count"
FROM     rental_item;


INSERT INTO rental_item
(SELECT 	NVL(ri.rental_item_id,rental_item_s1.NEXTVAL) AS rental_item_id
	,	r.rental_id
	,	tu.item_id
	,	1 AS created_by
	,	TRUNC(SYSDATE) AS creation_date
	,	1 AS last_updated_by
	,	TRUNC(SYSDATE) AS last_update_date
	,	cl.common_lookup_id AS rental_item_type
	,	r.return_date - r.check_out_date AS rental_item_price
	FROM	member m INNER JOIN contact c
	ON	m.member_id = c.member_id INNER JOIN transaction_upload tu
	ON	c.first_name = tu.first_name--MEMBER ACCOUNT_NUMBER/CONTACT FN MN LN
	AND	NVL(c.middle_name, 'x') = NVL(tu.middle_name, 'x')
	AND	c.last_name = tu.last_name
	AND	tu.account_number = m.account_number LEFT OUTER JOIN rental r
	ON	c.contact_id = r.customer_id
	AND	TRUNC(tu.check_out_date) = TRUNC(r.check_out_date)
	AND	TRUNC(tu.return_date) = TRUNC(r.return_date) INNER JOIN common_lookup cl
	ON	cl.common_lookup_table = 'RENTAL_ITEM'
	AND	cl.common_lookup_column = 'RENTAL_ITEM_TYPE'
	AND	cl.common_lookup_type = tu.rental_item_type LEFT OUTER JOIN rental_item ri
	ON	r.rental_id = ri.rental_id);
	


SELECT   COUNT(*) AS "Rental Item After Count"
FROM     rental_item;



--STEP 3: ----------------------------------------------------------------------------------------------------
--[15 points] Write a query that returns the rows necessary to insert records into the TRANSACTION table
SELECT 'STEP 3' AS "CODE" FROM dual;

SELECT COUNT(*)
FROM (
SELECT	t.transaction_id
,	tu.payment_account_number AS transaction_account
,	cl1.common_lookup_id AS transaction_type
,	tu.transaction_date
,	(SUM(tu.transaction_amount)/1.06) AS transaction_amount
,	r.rental_id
,	cl2.common_lookup_id AS payment_method_type
,	m.credit_card_number AS payment_account_number
,	1 AS created_by
,	TRUNC(SYSDATE) AS creation_date
,	1 AS last_updated_by
,	TRUNC(SYSDATE) AS last_update_date
FROM	member m INNER JOIN contact c
ON	m.member_id = c.member_id INNER JOIN transaction_upload tu
ON	c.first_name = tu.first_name--MEMBER ACCOUNT_NUMBER/CONTACT FN MN LN
AND	NVL(c.middle_name, 'x') = NVL(tu.middle_name, 'x')
AND	c.last_name = tu.last_name
AND	tu.account_number = m.account_number INNER JOIN rental r
ON	c.contact_id = r.customer_id
AND	TRUNC(tu.check_out_date) = TRUNC(r.check_out_date)
AND	TRUNC(tu.return_date) = TRUNC(r.return_date) INNER JOIN common_lookup cl1
ON	cl1.common_lookup_table = 'TRANSACTION'
AND	cl1.common_lookup_column = 'TRANSACTION_TYPE'
AND	cl1.common_lookup_type = tu.transaction_type INNER JOIN common_lookup cl2
ON      cl2.common_lookup_table = 'TRANSACTION'
AND     cl2.common_lookup_column = 'PAYMENT_METHOD_TYPE'
AND     cl2.common_lookup_type = tu.payment_method_type LEFT OUTER JOIN transaction t
-- TRANSACTION_ACCOUNT, TRANSACTION_TYPE, TRANSACTION_DATE, TRANSACTION_AMOUNT, PAYMENT_METHOD, and PAYMENT_ACCOUNT_NUMBER columns
ON	t.transaction_account = tu.payment_account_number
AND	t.transaction_type = cl1.common_lookup_id
AND	t.transaction_date = tu.transaction_date
AND	t.payment_method_type = cl2.common_lookup_id
AND	t.payment_account_number = m.credit_card_number
GROUP BY t.transaction_id
,	tu.payment_account_number
,	cl1.common_lookup_id
,	tu.transaction_date
,	r.rental_id
,	cl2.common_lookup_id
,	m.credit_card_number
,	1
,	TRUNC(SYSDATE)
,	1
,	TRUNC(SYSDATE)) ri;


--VERIFICATION SCRIPTS: ----------------------------------------------------------------------------------------
SELECT 'VERFICATION' AS "VERFICATION_SCRIPTS" FROM dual;

SELECT   DISTINCT c.contact_id
FROM     member m INNER JOIN transaction_upload tu
ON       m.account_number = tu.account_number INNER JOIN contact c
ON       m.member_id = c.member_id
WHERE    c.first_name = tu.first_name
AND      NVL(c.middle_name,'x') = NVL(tu.middle_name,'x')
AND      c.last_name = tu.last_name
ORDER BY c.contact_id;


SPOOL OFF
