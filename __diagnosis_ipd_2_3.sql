DROP TABLE st4hdc.DIAGNOSIS_IPD;

CREATE TABLE st4hdc.DIAGNOSIS_IPD
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    AN varchar(9) NOT NULL,
    DATETIME_ADMIT timestamp NOT NULL,
    WARDDIAG varchar(5) NOT NULL,
    DIAGTYPE char(1) NOT NULL,
    DIAGCODE varchar(6) NOT NULL,
    PROVIDER varchar(15),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.DIAGNOSIS_IPD ADD CONSTRAINT DIAGNOSIS_IPD_PK PRIMARY KEY (HOSPCODE, PID, AN, DATETIME_ADMIT, DIAGCODE) ENABLED;

CREATE PROJECTION st4hdc.DIAGNOSIS_IPD /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 AN,
 DATETIME_ADMIT,
 WARDDIAG,
 DIAGTYPE,
 DIAGCODE,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT DIAGNOSIS_IPD.HOSPCODE,
        DIAGNOSIS_IPD.PID,
        DIAGNOSIS_IPD.AN,
        DIAGNOSIS_IPD.DATETIME_ADMIT,
        DIAGNOSIS_IPD.WARDDIAG,
        DIAGNOSIS_IPD.DIAGTYPE,
        DIAGNOSIS_IPD.DIAGCODE,
        DIAGNOSIS_IPD.PROVIDER,
        DIAGNOSIS_IPD.D_UPDATE,
        DIAGNOSIS_IPD.CID,
        DIAGNOSIS_IPD.HDC_DATE,
        DIAGNOSIS_IPD.SOURCE_DATA
 FROM st4hdc.DIAGNOSIS_IPD
 ORDER BY DIAGNOSIS_IPD.HOSPCODE,
          DIAGNOSIS_IPD.PID,
          DIAGNOSIS_IPD.AN,
          DIAGNOSIS_IPD.DATETIME_ADMIT,
          DIAGNOSIS_IPD.DIAGCODE
SEGMENTED BY hash(DIAGNOSIS_IPD.HOSPCODE, DIAGNOSIS_IPD.PID, DIAGNOSIS_IPD.AN, DIAGNOSIS_IPD.DATETIME_ADMIT, DIAGNOSIS_IPD.DIAGCODE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
