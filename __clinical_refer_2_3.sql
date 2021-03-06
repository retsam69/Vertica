DROP TABLE st4hdc.CLINICAL_REFER;

CREATE TABLE st4hdc.CLINICAL_REFER
(
    HOSPCODE varchar(5) NOT NULL,
    REFERID varchar(10) NOT NULL,
    REFERID_PROVINCE varchar(10),
    DATETIME_ASSESS timestamp NOT NULL,
    CLINICALCODE varchar(6) NOT NULL,
    CLINICALNAME varchar(255),
    CLINICALVAULE numeric(6,0),
    CLINICALRESULT varchar(255),
    D_UPDATE timestamp NOT NULL,
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.CLINICAL_REFER ADD CONSTRAINT CLINICAL_REFER_PK PRIMARY KEY (HOSPCODE, REFERID, DATETIME_ASSESS, CLINICALCODE) ENABLED;

CREATE PROJECTION st4hdc.CLINICAL_REFER /*+createtype(A)*/ 
(
 HOSPCODE,
 REFERID,
 REFERID_PROVINCE,
 DATETIME_ASSESS,
 CLINICALCODE,
 CLINICALNAME,
 CLINICALVAULE,
 CLINICALRESULT,
 D_UPDATE,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT CLINICAL_REFER.HOSPCODE,
        CLINICAL_REFER.REFERID,
        CLINICAL_REFER.REFERID_PROVINCE,
        CLINICAL_REFER.DATETIME_ASSESS,
        CLINICAL_REFER.CLINICALCODE,
        CLINICAL_REFER.CLINICALNAME,
        CLINICAL_REFER.CLINICALVAULE,
        CLINICAL_REFER.CLINICALRESULT,
        CLINICAL_REFER.D_UPDATE,
        CLINICAL_REFER.HDC_DATE,
        CLINICAL_REFER.SOURCE_DATA
 FROM st4hdc.CLINICAL_REFER
 ORDER BY CLINICAL_REFER.HOSPCODE,
          CLINICAL_REFER.REFERID,
          CLINICAL_REFER.DATETIME_ASSESS,
          CLINICAL_REFER.CLINICALCODE
SEGMENTED BY hash(CLINICAL_REFER.HOSPCODE, CLINICAL_REFER.REFERID, CLINICAL_REFER.DATETIME_ASSESS, CLINICAL_REFER.CLINICALCODE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
