DROP TABLE st4hdc.PROCEDURE_IPD;

CREATE TABLE st4hdc.PROCEDURE_IPD
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    AN varchar(9) NOT NULL,
    DATETIME_ADMIT timestamp NOT NULL,
    WARDSTAY varchar(5) NOT NULL,
    PROCEDCODE varchar(7) NOT NULL,
    TIMESTART timestamp NOT NULL,
    TIMEFINISH timestamp,
    SERVICEPRICE numeric(11,2),
    PROVIDER varchar(15),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.PROCEDURE_IPD ADD CONSTRAINT PROCEDURE_IPD_PK PRIMARY KEY (HOSPCODE, PID, AN, DATETIME_ADMIT, PROCEDCODE, TIMESTART) ENABLED;

CREATE PROJECTION st4hdc.PROCEDURE_IPD /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 AN,
 DATETIME_ADMIT,
 WARDSTAY,
 PROCEDCODE,
 TIMESTART,
 TIMEFINISH,
 SERVICEPRICE,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT PROCEDURE_IPD.HOSPCODE,
        PROCEDURE_IPD.PID,
        PROCEDURE_IPD.AN,
        PROCEDURE_IPD.DATETIME_ADMIT,
        PROCEDURE_IPD.WARDSTAY,
        PROCEDURE_IPD.PROCEDCODE,
        PROCEDURE_IPD.TIMESTART,
        PROCEDURE_IPD.TIMEFINISH,
        PROCEDURE_IPD.SERVICEPRICE,
        PROCEDURE_IPD.PROVIDER,
        PROCEDURE_IPD.D_UPDATE,
        PROCEDURE_IPD.CID,
        PROCEDURE_IPD.HDC_DATE,
        PROCEDURE_IPD.SOURCE_DATA
 FROM st4hdc.PROCEDURE_IPD
 ORDER BY PROCEDURE_IPD.HOSPCODE,
          PROCEDURE_IPD.PID,
          PROCEDURE_IPD.AN,
          PROCEDURE_IPD.DATETIME_ADMIT,
          PROCEDURE_IPD.PROCEDCODE,
          PROCEDURE_IPD.TIMESTART
SEGMENTED BY hash(PROCEDURE_IPD.HOSPCODE, PROCEDURE_IPD.PID, PROCEDURE_IPD.AN, PROCEDURE_IPD.DATETIME_ADMIT, PROCEDURE_IPD.PROCEDCODE, PROCEDURE_IPD.TIMESTART) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
