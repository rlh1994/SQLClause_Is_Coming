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
