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
--   sql> @apply_oracle_lab4.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lab2/apply_oracle_lab2.sql
@/home/student/Data/cit225/oracle/lib/seed_oracle_store.sql

-- Add your lab here:
-- ----------------------------------------------------------------------
-- Open log file.
SPOOL apply_oracle_lab4.log

--SYSTEM_USER_LAB INSERTS
INSERT INTO system_user_lab
VALUES
(system_user_lab_s1.NEXTVAL
, 'REACHERJ'
, 2
, 1008
, 'Jack'
, NULL
, 'Reacher'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO system_user_lab
VALUES
(system_user_lab_s1.NEXTVAL
, 'OWENSR'
, 2
, 1008
, 'Ray'
, NULL
, 'Owens'
, 1
, SYSDATE
, 1
, SYSDATE);

--COMMON_LOOKUP_LAB INSERTS
INSERT INTO common_lookup_lab
Values
( common_lookup_lab_s1.NEXTVAL
, 'MEMBER_LAB'
, 'AMERICAN_EXPRESS_CARD'
, 'American Express Card'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO common_lookup_lab
Values
( common_lookup_lab_s1.NEXTVAL
, 'MEMBER_LAB'
, 'DINERS_CLUB_CARD'
, 'Diners Club Card'
, 1
, SYSDATE
, 1
, SYSDATE);

-- ------------------------------------------------------------------
-- This seeds rows in a dependency chain, including the MEMBER, CONTACT
-- ADDRESS, and TELEPHONE tables.
-- ---------------------------------------------------------------------------------------------
-- Insert record set #1: MEMBER_LAB, CONTACT_LAB, ADDRESS_LAB, STREET_ADDRESS_LAB, TELEPHONE_LAB
-- ---------------------------------------------------------------------------------------------
INSERT INTO member_lab
VALUES
( member_lab_s1.NEXTVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_context = 'MEMBER_LAB'
  AND      common_lookup_lab_type = 'AMERICAN_EXPRESS_CARD')
, 'x15-500-01'
, '9876-5432-1234-5678'
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_context = 'MEMBER_LAB'
  AND      common_lookup_lab_type = 'AMERICAN_EXPRESS_CARD')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact_lab
VALUES
( contact_lab_s1.NEXTVAL
, member_lab_s1.CURRVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_context = 'CONTACT'
  AND      common_lookup_lab_type = 'CUSTOMER')
, 'Jones'
, NULL
, 'John'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address_lab
VALUES
( address_lab_s1.NEXTVAL
, contact_lab_s1.CURRVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_type = 'HOME')
, 'Draper'
, 'Utah'
, '84020'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address_lab
VALUES
( street_address_lab_s1.NEXTVAL
, address_lab_s1.CURRVAL
, '372 East 12300 South'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone_lab
VALUES
(telephone_lab_s1.NEXTVAL
, contact_lab_s1.CURRVAL
, address_lab_s1.CURRVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_type = 'HOME')
, '001'
, '801'
,'389-0687'
, 1
,SYSDATE
,1
,SYSDATE);

-- ---------------------------------------------------------------------------------------------
-- Insert record set #2: MEMBER_LAB, CONTACT_LAB, ADDRESS_LAB, STREET_ADDRESS_LAB, TELEPHONE_LAB
-- ---------------------------------------------------------------------------------------------
INSERT INTO member_lab
VALUES
( member_lab_s1.NEXTVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_context = 'MEMBER_LAB'
  AND      common_lookup_lab_type = 'DINERS_CLUB_CARD')
, 'x15-500-02'
, '9876-5432-1234-5679'
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_context = 'MEMBER_LAB'
  AND      common_lookup_lab_type = 'DINERS_CLUB_CARD')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO contact_lab
VALUES
( contact_lab_s1.NEXTVAL
, member_lab_s1.CURRVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_context = 'CONTACT'
  AND      common_lookup_lab_type = 'CUSTOMER')
, 'Jones'
, NULL
, 'Jane'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO address_lab
VALUES
( address_lab_s1.NEXTVAL
, contact_lab_s1.CURRVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_type = 'HOME')
, 'Draper'
, 'Utah'
, '84020'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO street_address_lab
VALUES
( street_address_lab_s1.NEXTVAL
, address_lab_s1.CURRVAL
, '1872 West 5400 South'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO telephone_lab
VALUES
(telephone_lab_s1.NEXTVAL
, contact_lab_s1.CURRVAL
, address_lab_s1.CURRVAL
, (SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_type = 'HOME')
, '001'
, '801'
,'389-0688'
, 1
,SYSDATE
,1
,SYSDATE);

--ITEM_LAB INSERTS
INSERT INTO item_lab
VALUES
( item_lab_s1.NEXTVAL
,'B00N1JQ2UO'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_type = 'DVD_WIDE_SCREEN')
,'Guardians of the Galaxy'
, NULL
,'PG-13'
,'09-DEC-14'
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO item_lab
VALUES
( item_lab_s1.NEXTVAL
,'B00OY7YPGK'
,(SELECT   common_lookup_lab_id
  FROM     common_lookup_lab
  WHERE    common_lookup_lab_type = 'BLUE_RAY')
,'The Maze Runner'
,NULL
,'PG-13'
,'16-DEC-14'
, 1
, SYSDATE
, 1
, SYSDATE);

--RENTAL_LAB INSERTS
INSERT INTO rental_lab
VALUES
( rental_lab_s1.NEXTVAL
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Jones'
  AND      first_name = 'John')
, SYSDATE
, SYSDATE + 5
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_lab
VALUES
( rental_lab_s1.NEXTVAL
,(SELECT   contact_lab_id
  FROM     contact_lab
  WHERE    last_name = 'Jones'
  AND      first_name = 'Jane')
, SYSDATE
, SYSDATE + 5
, 1
, SYSDATE
, 1
, SYSDATE);


--RENTAL_ITEM_LAB INSERTS
INSERT INTO rental_item_lab
VALUES
( rental_item_lab_s1.NEXTVAL
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Jones'
  AND      c.first_name = 'John')
,(SELECT   i.item_lab_id
  FROM     item_lab i
  ,        common_lookup_lab cl
  WHERE    i.item_lab_title = 'Guardians of the Galaxy'
  AND      i.item_lab_subtitle = NULL
  AND      i.item_lab_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_lab_type = 'DVD_WIDE_SCREEN')
, 1
, SYSDATE
, 1
, SYSDATE);

INSERT INTO rental_item_lab
VALUES
( rental_item_lab_s1.NEXTVAL
,(SELECT   r.rental_lab_id
  FROM     rental_lab r
  ,        contact_lab c
  WHERE    r.customer_lab_id = c.contact_lab_id
  AND      c.last_name = 'Jones'
  AND      c.first_name = 'Jane')
,(SELECT   i.item_lab_id
  FROM     item_lab i
  ,        common_lookup_lab cl
  WHERE    i.item_lab_title = 'The Maze Runner'
  AND      i.item_lab_subtitle = NULL
  AND      i.item_lab_type = cl.common_lookup_lab_id
  AND      cl.common_lookup_lab_type = 'BLUE_RAY')
, 1
, SYSDATE
, 1
, SYSDATE);

--Verification Script
SELECT * FROM system_user_lab;

SELECT * 
FROM common_lookup_lab
WHERE common_lookup_lab_context = 'MEMBER_LAB'
AND common_lookup_lab_type IN ('AMERICAN_EXPRESS_CARD','DINERS_CLUB_CARD');

CLEAR COLUMNS
SELECT   m.member_id
,        m.member_type
,        m.account_number
,        m.credit_card_number
,        cl.common_lookup_lab_meaning AS credit_card_type
FROM     member_lab m INNER JOIN common_lookup_lab cl
ON       m.credit_card_type = cl.common_lookup_lab_id
WHERE    common_lookup_lab_context = 'MEMBER_LAB'
AND      common_lookup_lab_type IN ('AMERICAN_EXPRESS_CARD','DINERS_CLUB_CARD');

CLEAR COLUMNS
SELECT   c.contact_lab_id
,        m.credit_card_type
,        c.member_id
,        c.contact_lab_type
,        c.last_name
,        c.first_name
FROM     member_lab m INNER JOIN common_lookup_lab cl1
ON       m.credit_card_type = cl1.common_lookup_lab_id INNER JOIN contact_lab c
ON       m.member_id = c.member_id INNER JOIN common_lookup_lab cl2
ON       c.contact_lab_type = cl2.common_lookup_lab_id
WHERE    cl1.common_lookup_lab_context = 'MEMBER_LAB'
AND      cl1.common_lookup_lab_type IN ('AMERICAN_EXPRESS_CARD','DINERS_CLUB_CARD')
AND      cl2.common_lookup_lab_context = 'CONTACT_LAB'
AND      cl2.common_lookup_lab_type = 'CUSTOMER';

CLEAR COLUMNS
SELECT   c.contact_lab_id
,        a.address_lab_type
,        c.first_name
,        c.last_name
,        a.city
,        a.state_province
,        a.postal_code
FROM     contact_lab c INNER JOIN common_lookup_lab cl1
ON       c.contact_lab_type = cl1.common_lookup_lab_id INNER JOIN address_lab a
ON       c.contact_lab_id = a.contact_lab_id INNER JOIN common_lookup_lab cl2
ON       a.address_lab_type = cl2.common_lookup_lab_id
WHERE    cl1.common_lookup_lab_context = 'CONTACT_LAB'
AND      cl1.common_lookup_lab_type = 'CUSTOMER'
AND      cl2.common_lookup_lab_context = 'MULTIPLE'
AND      cl2.common_lookup_lab_type = 'HOME';

CLEAR COLUMNS
SELECT   c.contact_lab_id
,        a.address_lab_id
,        a.address_lab_type
,        c.first_name
,        c.last_name
,        sa.street_address_lab
,        a.city
,        a.state_province
,        a.postal_code
FROM     contact_lab c INNER JOIN common_lookup_lab cl1
ON       c.contact_lab_type = cl1.common_lookup_lab_id INNER JOIN address_lab a
ON       c.contact_lab_id = a.contact_lab_id INNER JOIN street_address_lab sa
ON       a.address_lab_id = sa.address_lab_id INNER JOIN common_lookup_lab cl2
ON       a.address_lab_type = cl2.common_lookup_lab_id
WHERE    cl1.common_lookup_lab_context = 'CONTACT_LAB'
AND      cl1.common_lookup_lab_type = 'CUSTOMER'
AND      cl2.common_lookup_lab_context = 'MULTIPLE'
AND      cl2.common_lookup_lab_type = 'HOME';

CLEAR COLUMNS
SELECT   c.contact_lab_id
,        t.telephone_lab_id
,        t.telephone_lab_type
,        c.first_name
,        c.last_name
,        t.country_code
,        t.area_code
,        t.telephone_number
FROM     contact_lab c INNER JOIN telephone_lab t
ON       c.contact_lab_id = t.contact_lab_id
WHERE    c.first_name IN ('John','Jane')
AND      c.last_name = 'Jones';

CLEAR COLUMNS
SELECT   r.rental_lab_id
,        r.customer_lab_id
,        r.check_out_date
,        r.return_date
FROM     rental_lab r 
WHERE    r.check_out_date IN ('02-JAN-2015','03-JAN-2015');

CLEAR COLUMNS
SELECT   i.item_lab_id
,        i.item_lab_title
,        i.item_lab_rating
,        i.item_lab_release_date
FROM     item_lab i 
WHERE    i.item_lab_release_date IN ('09-DEC-2014','16-DEC-2014');

CLEAR COLUMNS
SELECT   ri.rental_item_lab_id
,        ri.rental_lab_id
,        ri.item_lab_id
FROM     rental_item_lab ri INNER JOIN rental_lab r
ON       r.rental_lab_id = ri.rental_lab_id INNER JOIN item_lab i
ON       i.item_lab_id = ri.item_lab_id
WHERE    r.rental_lab_id IN (SELECT   r.rental_lab_id
                             FROM     rental_lab r 
                             WHERE    r.check_out_date IN ('02-JAN-2015','03-JAN-2015'))
AND      i.item_lab_id IN (SELECT   i.item_lab_id
                           FROM     item_lab i
                           WHERE    item_lab_title IN ('Guardians of the Galaxy','The Maze Runner')
                           AND      item_lab_release_date IN ('09-DEC-2014','16-DEC-2014'))



SPOOL OFF


