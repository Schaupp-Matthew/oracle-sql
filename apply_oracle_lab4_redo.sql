-- Open log file.
SPOOL apply_oracle_lab4.log

--SYSTEM_USER_LAB INSERTS
INSERT INTO
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
( item_lab_s1.nextval
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
( item_s1.nextval
,'B00OY7YPGK'
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'BLUE_RAY')
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
( rental_s1.nextval
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
( rental_s1.nextval
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

