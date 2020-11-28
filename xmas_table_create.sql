--------------------------------------------------------
--  DDL for Table XMAS_BEHAVIOURS
--------------------------------------------------------

  CREATE TABLE "XMAS_BEHAVIOURS" 
   (	"CHILD_ID" NUMBER(7,0), 
	"EVENT_DATE" DATE, 
	"SCORE" NUMBER(11,9)
   );
--------------------------------------------------------
--  DDL for Table XMAS_CHILDREN
--------------------------------------------------------

  CREATE TABLE "XMAS_CHILDREN" 
   (	"CHILD_ID" NUMBER(5,0), 
	"NAME" VARCHAR2(256), 
	"COUNTRY" VARCHAR2(256), 
	"DOB" DATE, 
	"BELIEF" NUMBER(7,5)
   );
--------------------------------------------------------
--  DDL for Table XMAS_TOYS
--------------------------------------------------------

  CREATE TABLE "XMAS_TOYS" 
   (	"UNIQ_ID" VARCHAR2(128), 
	"PRODUCT_NAME" VARCHAR2(1024), 
	"MANUFACTURER" VARCHAR2(128), 
	"PRICE" NUMBER(7,2), 
	"AVERAGE_REVIEW_RATING" VARCHAR2(26), 
	"AMAZON_CATEGORY_SUB_CATEGORY" VARCHAR2(256)
   );
--------------------------------------------------------
--  DDL for Table XMAS_WISHES
--------------------------------------------------------

  CREATE TABLE "XMAS_WISHES" 
   (	"CHILD_ID" NUMBER(7,0), 
	"TOY_ID" VARCHAR2(128)
   );


--------------------------------------------------------
--  Table Indexes
--------------------------------------------------------
CREATE INDEX IND_XMAS_WSH_TOY 
ON xmas_wishes(TOY_ID);

--------------------------------------------------------
--  Table Comments
--------------------------------------------------------
COMMENT ON COLUMN xmas_behaviours.child_id IS
	'Unique ID for each child (FK XMAS_CHILDREN)';

COMMENT ON COLUMN xmas_behaviours.event_date IS
	'Date of the event for the behaviour';

COMMENT ON COLUMN xmas_behaviours.score IS
	'Score for the event between -1 (fully naughty) and 1 (fully nice)';

COMMENT ON COLUMN xmas_children.child_id IS
	'Unique ID for each child (PK)';

COMMENT ON COLUMN xmas_children.name IS
	'Name of the child (randomly generated)';

COMMENT ON COLUMN xmas_children.country IS
	'Country the child is in (randomly selected)';

COMMENT ON COLUMN xmas_children.dob IS
	'Date of birth (randomly generated)';

COMMENT ON COLUMN xmas_children.belief IS
	'Strength of their belief in Santa from 0 (no belief) to 1 (True Believer)';

COMMENT ON COLUMN xmas_toys.uniq_id IS
	'Unique ID of the toy for their wish (PK)';

COMMENT ON COLUMN xmas_toys.product_name IS
	'Name of toy';

COMMENT ON COLUMN xmas_toys.manufacturer IS
	'Manufacturer of toy';

COMMENT ON COLUMN xmas_toys.price IS
	'Price of toy in pounds and decimal pence';

COMMENT ON COLUMN xmas_toys.average_review_rating IS
	'Average rating of the toy in for "X.X out of 5 stars"';

COMMENT ON COLUMN xmas_toys.amazon_category_sub_category IS
	'Category tree of toy';

COMMENT ON COLUMN xmas_wishes.child_id IS
	'Unique ID for each child (FK XMAS_CHILDREN)';

COMMENT ON COLUMN xmas_wishes.toy_id IS
	'Unique ID of the toy for their wish (FK UNIQ_ID XMAS_TOYS)';