DROP TABLE st4hdc.SERVICE;

CREATE TABLE st4hdc.SERVICE
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    HN varchar(15),
    SEQ varchar(16) NOT NULL,
    DATE_SERV date NOT NULL,
    TIME_SERV varchar(6),
    LOCATION varchar(1),
    INTIME varchar(1),
    INSTYPE varchar(4) NOT NULL,
    INSID varchar(18),
    MAIN varchar(5),
    TYPEIN varchar(1) NOT NULL,
    REFERINHOSP varchar(5),
    CAUSEIN varchar(1),
    CHIEFCOMP varchar(255),
    SERVPLACE varchar(1) NOT NULL,
    BTEMP numeric(4,1),
    SBP numeric(3,0),
    DBP numeric(3,0),
    PR numeric(3,0),
    RR numeric(3,0),
    TYPEOUT varchar(1) NOT NULL,
    REFEROUTHOSP varchar(5),
    CAUSEOUT varchar(1),
    COST numeric(11,2),
    PRICE numeric(11,2) NOT NULL,
    PAYPRICE numeric(11,2) NOT NULL,
    ACTUALPAY numeric(11,2) NOT NULL,
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.SERVICE ADD CONSTRAINT SERVICE_PK PRIMARY KEY (HOSPCODE, PID, SEQ, DATE_SERV) ENABLED;

CREATE PROJECTION st4hdc.SERVICE /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 HN,
 SEQ,
 DATE_SERV,
 TIME_SERV,
 LOCATION,
 INTIME,
 INSTYPE,
 INSID,
 MAIN,
 TYPEIN,
 REFERINHOSP,
 CAUSEIN,
 CHIEFCOMP,
 SERVPLACE,
 BTEMP,
 SBP,
 DBP,
 PR,
 RR,
 TYPEOUT,
 REFEROUTHOSP,
 CAUSEOUT,
 COST,
 PRICE,
 PAYPRICE,
 ACTUALPAY,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT SERVICE.HOSPCODE,
        SERVICE.PID,
        SERVICE.HN,
        SERVICE.SEQ,
        SERVICE.DATE_SERV,
        SERVICE.TIME_SERV,
        SERVICE.LOCATION,
        SERVICE.INTIME,
        SERVICE.INSTYPE,
        SERVICE.INSID,
        SERVICE.MAIN,
        SERVICE.TYPEIN,
        SERVICE.REFERINHOSP,
        SERVICE.CAUSEIN,
        SERVICE.CHIEFCOMP,
        SERVICE.SERVPLACE,
        SERVICE.BTEMP,
        SERVICE.SBP,
        SERVICE.DBP,
        SERVICE.PR,
        SERVICE.RR,
        SERVICE.TYPEOUT,
        SERVICE.REFEROUTHOSP,
        SERVICE.CAUSEOUT,
        SERVICE.COST,
        SERVICE.PRICE,
        SERVICE.PAYPRICE,
        SERVICE.ACTUALPAY,
        SERVICE.D_UPDATE,
        SERVICE.CID,
        SERVICE.HDC_DATE,
        SERVICE.SOURCE_DATA
 FROM st4hdc.SERVICE
 ORDER BY SERVICE.HOSPCODE,
          SERVICE.PID,
          SERVICE.SEQ,
          SERVICE.DATE_SERV
SEGMENTED BY hash(SERVICE.HOSPCODE, SERVICE.PID, SERVICE.SEQ, SERVICE.DATE_SERV) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
