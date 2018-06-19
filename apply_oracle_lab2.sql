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
--   sql> @apply_oracle_lab2.sql
--
-- ----------------------------------------------------------------------

-- Run the prior lab script.
@/home/student/Data/cit225/oracle/lib/cleanup_oracle.sql
@/home/student/Data/cit225/oracle/lib/create_oracle_store.sql

-- Add your lab here:
-- ----------------------------------------------------------------------
-- Open log file.
SPOOL apply_oracle_lab2.log

-- Create the SYSTEM_USER_LAB 
	--table
CREATE TABLE system_user_lab
( system_user_lab_id              NUMBER
, system_user_lab_name            VARCHAR2(20) CONSTRAINT nn_system_user_lab_1 NOT NULL
, system_user_lab_group_id        NUMBER       CONSTRAINT nn_system_user_lab_2 NOT NULL
, system_user_lab_type            NUMBER       CONSTRAINT nn_system_user_lab_3 NOT NULL
, first_name                  VARCHAR2(20)
, middle_name                 VARCHAR2(20)
, last_name                   VARCHAR2(20)
, created_by                  NUMBER       CONSTRAINT nn_system_user_lab_4 NOT NULL
, creation_date               DATE         CONSTRAINT nn_system_user_lab_5 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_system_user_lab_6 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_system_user_lab_7 NOT NULL
, CONSTRAINT pk_system_user_lab_1 PRIMARY KEY(system_user_lab_id));
	--sequence
CREATE SEQUENCE system_user_lab_s1 START WITH 1001;
	--seed
INSERT INTO system_user_lab
( system_user_lab_id
, system_user_lab_name
, system_user_lab_group_id
, system_user_lab_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( 1,'SYSADMIN', 1, 1, 1, SYSDATE, 1, SYSDATE);

	--constraints
ALTER TABLE system_user_lab
ADD CONSTRAINT fk_system_user_lab_1 FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id);

ALTER TABLE system_user_lab
ADD CONSTRAINT fk_system_user_lab_2 FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id);

-- Create the COMMON_LOOKUP_LAB 
	--table
CREATE TABLE common_lookup_lab
( common_lookup_lab_id            NUMBER
, common_lookup_lab_context       VARCHAR2(30) CONSTRAINT nn_clookup_lab_1 NOT NULL
, common_lookup_lab_type          VARCHAR2(30) CONSTRAINT nn_clookup_lab_2 NOT NULL
, common_lookup_lab_meaning       VARCHAR2(30) CONSTRAINT nn_clookup_lab_3 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_clookup_lab_4 NOT NULL
, creation_date               DATE         CONSTRAINT nn_clookup_lab_5 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_clookup_lab_6 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_clookup_lab_7 NOT NULL
, CONSTRAINT pk_c_lookup_lab_1    PRIMARY KEY(common_lookup_lab_id)
, CONSTRAINT fk_c_lookup_lab_1    FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_c_lookup_lab_2    FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE common_lookup_lab_s1 START WITH 1001;
	--seed
INSERT INTO common_lookup_lab VALUES
( 1,'SYSTEM_USER','SYSTEM_ADMIN','System Administrator', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( 2,'SYSTEM_USER','DBA','Database Administrator', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'CONTACT','EMPLOYEE','Employee', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'CONTACT','CUSTOMER','Customer', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MEMBER','INDIVIDUAL','Individual Membership', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MEMBER','GROUP','Group Membership', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MEMBER','DISCOVER_CARD','Discover Card', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MEMBER','MASTER_CARD','Master Card', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MEMBER','VISA_CARD','VISA Card', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MULTIPLE','HOME','Home', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'MULTIPLE','WORK','Work', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'ITEM','DVD_FULL_SCREEN','DVD: Full Screen', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'ITEM','DVD_WIDE_SCREEN','DVD: Wide Screen', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'ITEM','NINTENDO_GAMECUBE','Nintendo GameCube', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'ITEM','PLAYSTATION2','PlayStation2', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'ITEM','XBOX','XBOX', 1, SYSDATE, 1, SYSDATE);

INSERT INTO common_lookup_lab VALUES
( common_lookup_s1.nextval,'ITEM','BLU-RAY','Blu-ray', 1, SYSDATE, 1, SYSDATE);
	--constraints
ALTER TABLE system_user_lab
ADD CONSTRAINT fk_system_user_lab_3 FOREIGN KEY(system_user_lab_type)
    REFERENCES system_user_lab(system_user_lab_type);
	--indexes
CREATE INDEX common_lookup_lab_n1
  ON common_lookup_lab(common_lookup_lab_context);

CREATE UNIQUE INDEX common_lookup_lab_u2
  ON common_lookup_lab(common_lookup_lab_context,common_lookup_lab_type);

-- Create the MEMBER_LAB 
BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'MEMBER') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE member CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'MEMBER_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE member_s1';
  END LOOP;
END;
/

	--table
CREATE TABLE member_lab
( member_id                   NUMBER
, member_type                 NUMBER
, account_number              VARCHAR2(10) CONSTRAINT nn_member_2 NOT NULL
, credit_card_number          VARCHAR2(19) CONSTRAINT nn_member_3 NOT NULL
, credit_card_type            NUMBER       CONSTRAINT nn_member_4 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_member_5 NOT NULL
, creation_date               DATE         CONSTRAINT nn_member_6 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_member_7 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_member_8 NOT NULL
, CONSTRAINT pk_member_1      PRIMARY KEY(member_id)
, CONSTRAINT fk_member_1      FOREIGN KEY(member_type) REFERENCES common_lookup_lab(common_lookup_lab_id)
, CONSTRAINT fk_member_2      FOREIGN KEY(credit_card_type) REFERENCES common_lookup_lab(common_lookup_lab_id)
, CONSTRAINT fk_member_3      FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_member_4      FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE member_lab_s1 START WITH 1001;
	--indexes
CREATE INDEX member_n1 ON member_lab(credit_card_type);

-- Create the CONTACT_LAB
BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'CONTACT') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE contact CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'CONTACT_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE contact_s1';
  END LOOP;
END;
/ 
	--table
CREATE TABLE contact_lab
( contact_lab_id              NUMBER
, member_lab_id               NUMBER       CONSTRAINT nn_contact_1 NOT NULL
, contact_lab_type            NUMBER	CONSTRAINT nn_contact_2 NOT NULL
, first_name                  VARCHAR2(20) CONSTRAINT nn_contact_3 NOT NULL
, middle_name                 VARCHAR2(20)
, last_name                   VARCHAR2(20) CONSTRAINT nn_contact_4 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_contact_5 NOT NULL
, creation_date               DATE         CONSTRAINT nn_contact_6 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_contact_7 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_contact_8 NOT NULL
, CONSTRAINT pk_contact_1     PRIMARY KEY(contact_lab_id)
, CONSTRAINT fk_contact_1     FOREIGN KEY(member_lab_id) REFERENCES member_lab(member_id)
, CONSTRAINT fk_contact_2     FOREIGN KEY(contact_lab_type) REFERENCES common_lookup_lab(common_lookup_lab_id)
, CONSTRAINT fk_contact_3     FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_contact_4     FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE contact_lab_s1 START WITH 1001;
	--indexes
CREATE INDEX contact_n1 ON contact_lab(member_lab_id);
CREATE INDEX contact_n2 ON contact_lab(contact_lab_type);

-- Create the ADDRESS_LAB
 BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'ADDRESS') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE address CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'ADDRESS_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE address_s1';
  END LOOP;
END;
/
	--table
CREATE TABLE address_lab
( address_lab_id                  NUMBER
, contact_lab_id                  NUMBER       CONSTRAINT nn_address_1 NOT NULL
, address_lab_type                NUMBER       CONSTRAINT nn_address_2 NOT NULL
, city                        VARCHAR2(30) CONSTRAINT nn_address_3 NOT NULL
, state_province              VARCHAR2(30) CONSTRAINT nn_address_4 NOT NULL
, postal_code                 VARCHAR2(20) CONSTRAINT nn_address_5 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_address_6 NOT NULL
, creation_date               DATE         CONSTRAINT nn_address_7 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_address_8 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_address_9 NOT NULL
, CONSTRAINT pk_address_1     PRIMARY KEY(address_lab_id)
, CONSTRAINT fk_address_1     FOREIGN KEY(contact_lab_id) REFERENCES contact_lab(contact_lab_id)
, CONSTRAINT fk_address_2     FOREIGN KEY(address_lab_type) REFERENCES common_lookup_lab(common_lookup_lab_id)
, CONSTRAINT fk_address_3     FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_address_4     FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE address_lab_s1 START WITH 1001;
	--indexes
CREATE INDEX address_n1 ON address_lab(contact_lab_id);
CREATE INDEX address_n2 ON address_lab(address_lab_type);

-- Create the STREET_ADDRESS_LAB
BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'STREET_ADDRESS') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE street_address CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'STREET_ADDRESS_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE street_address_s1';
  END LOOP;
END;
/ 
	--table
CREATE TABLE street_address_lab
( street_address_lab_id           NUMBER
, address_lab_id                  NUMBER       CONSTRAINT nn_saddress_1 NOT NULL
, street_address_lab              VARCHAR2(30) CONSTRAINT nn_saddress_2 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_saddress_3 NOT NULL
, creation_date               DATE         CONSTRAINT nn_saddress_4 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_saddress_5 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_saddress_6 NOT NULL
, CONSTRAINT pk_s_address_1   PRIMARY KEY(street_address_lab_id)
, CONSTRAINT fk_s_address_1   FOREIGN KEY(address_lab_id) REFERENCES address_lab(address_lab_id)
, CONSTRAINT fk_s_address_3   FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_s_address_4   FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE street_address_lab_s1 START WITH 1001;

-- Create the TELEPHONE_LAB
BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'TELEPHONE') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE telephone CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'TELEPHONE_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE telephone_s1';
  END LOOP;
END;
/ 
	--table
CREATE TABLE telephone_lab
( telephone_lab_id                NUMBER
, contact_lab_id                  NUMBER       CONSTRAINT nn_telephone_1 NOT NULL
, address_lab_id                  NUMBER
, telephone_lab_type              NUMBER       CONSTRAINT nn_telephone_2 NOT NULL
, country_code                VARCHAR2(3)  CONSTRAINT nn_telephone_3 NOT NULL
, area_code                   VARCHAR2(6)  CONSTRAINT nn_telephone_4 NOT NULL
, telephone_number            VARCHAR2(10) CONSTRAINT nn_telephone_5 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_telephone_6 NOT NULL
, creation_date               DATE         CONSTRAINT nn_telephone_7 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_telephone_8 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_telephone_9 NOT NULL
, CONSTRAINT pk_telephone_1   PRIMARY KEY(telephone_lab_id)
, CONSTRAINT fk_telephone_1   FOREIGN KEY(contact_lab_id) REFERENCES contact_lab(contact_lab_id)
, CONSTRAINT fk_telephone_2   FOREIGN KEY(telephone_lab_type) REFERENCES common_lookup_lab(common_lookup_lab_id)
, CONSTRAINT fk_telephone_3   FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_telephone_4   FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE telephone_lab_s1 START WITH 1001;
	--indexes
CREATE INDEX telephone_n1 ON telephone_lab(contact_lab_id,address_lab_id);
CREATE INDEX telephone_n2 ON telephone_lab(address_lab_id);
CREATE INDEX telephone_n3 ON telephone_lab(telephone_lab_type);

-- Create the ITEM_LAB
 BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'ITEM') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE item CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'ITEM_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE item_s1';
  END LOOP;
END;
/
	--table
CREATE TABLE item_lab
( item_lab_id                     NUMBER
, item_lab_barcode                VARCHAR2(14) CONSTRAINT nn_item_1 NOT NULL
, item_lab_type                   NUMBER       CONSTRAINT nn_item_2 NOT NULL
, item_lab_title                  VARCHAR2(60) CONSTRAINT nn_item_3 NOT NULL
, item_lab_subtitle               VARCHAR2(60)
, item_lab_rating                 VARCHAR2(8)  CONSTRAINT nn_item_4 NOT NULL
, item_lab_release_date           DATE         CONSTRAINT nn_item_5 NOT NULL
, created_by                  NUMBER       CONSTRAINT nn_item_6 NOT NULL
, creation_date               DATE         CONSTRAINT nn_item_7 NOT NULL
, last_updated_by             NUMBER       CONSTRAINT nn_item_8 NOT NULL
, last_update_date            DATE         CONSTRAINT nn_item_9 NOT NULL
, CONSTRAINT pk_item_1        PRIMARY KEY(item_lab_id)
, CONSTRAINT fk_item_1        FOREIGN KEY(item_lab_type) REFERENCES common_lookup_lab(common_lookup_lab_id)
, CONSTRAINT fk_item_2        FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_item_3        FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE item_lab_s1 START WITH 1001;

-- Create the RENTAL_LAB
BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'RENTAL') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE rental CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'RENTAL_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE rental_s1';
  END LOOP;
END;
/ 
	--table
CREATE TABLE rental_lab
( rental_lab_id                   NUMBER
, customer_lab_id                 NUMBER CONSTRAINT nn_rental_1 NOT NULL
, check_out_date              DATE   CONSTRAINT nn_rental_2 NOT NULL
, return_date                 DATE   CONSTRAINT nn_rental_3 NOT NULL
, created_by                  NUMBER CONSTRAINT nn_rental_4 NOT NULL
, creation_date               DATE   CONSTRAINT nn_rental_5 NOT NULL
, last_updated_by             NUMBER CONSTRAINT nn_rental_6 NOT NULL
, last_update_date            DATE   CONSTRAINT nn_rental_7 NOT NULL
, CONSTRAINT pk_rental_1      PRIMARY KEY(rental_lab_id)
, CONSTRAINT fk_rental_1      FOREIGN KEY(customer_lab_id) REFERENCES contact_lab(contact_lab_id)
, CONSTRAINT fk_rental_2      FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_rental_3      FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE rental_lab_s1 START WITH 1001;

-- Create the RENTAL_ITEM_LAB
BEGIN
  FOR i IN (SELECT null FROM user_tables WHERE table_name = 'RENTAL_ITEM') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE rental_item CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null FROM user_sequences WHERE sequence_name = 'RENTAL_ITEM_S1') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE rental_item_s1';
  END LOOP;
END;
/ 
	--table
CREATE TABLE rental_item_lab
( rental_item_lab_id              NUMBER
, rental_lab_id                   NUMBER CONSTRAINT nn_rental_item_1 NOT NULL
, item_lab_id                     NUMBER CONSTRAINT nn_rental_item_2 NOT NULL
, created_by                  NUMBER CONSTRAINT nn_rental_item_3 NOT NULL
, creation_date               DATE   CONSTRAINT nn_rental_item_4 NOT NULL
, last_updated_by             NUMBER CONSTRAINT nn_rental_item_5 NOT NULL
, last_update_date            DATE   CONSTRAINT nn_rental_item_6 NOT NULL
, CONSTRAINT pk_rental_item_1 PRIMARY KEY(rental_item_lab_id)
, CONSTRAINT fk_rental_item_1 FOREIGN KEY(rental_lab_id) REFERENCES rental_lab(rental_lab_id)
, CONSTRAINT fk_rental_item_2 FOREIGN KEY(item_lab_id) REFERENCES item_lab(item_lab_id)
, CONSTRAINT fk_rental_item_3 FOREIGN KEY(created_by) REFERENCES system_user_lab(system_user_lab_id)
, CONSTRAINT fk_rental_item_4 FOREIGN KEY(last_updated_by) REFERENCES system_user_lab(system_user_lab_id));
	--sequence
CREATE SEQUENCE rental_item_lab_s1 START WITH 1001;

--commit inserted records.
COMMIT;

SPOOL OFF
