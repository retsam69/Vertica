DROP TABLE st4hdc.LABFU;

CREATE TABLE st4hdc.LABFU
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16) NOT NULL,
    DATE_SERV date NOT NULL,
    LABTEST varchar(7) NOT NULL,
    LABRESULT numeric(6,2),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.LABFU ADD CONSTRAINT LABFU_PK PRIMARY KEY (HOSPCODE, PID, SEQ, DATE_SERV, LABTEST) ENABLED;

CREATE PROJECTION st4hdc.LABFU /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 DATE_SERV,
 LABTEST,
 LABRESULT,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT LABFU.HOSPCODE,
        LABFU.PID,
        LABFU.SEQ,
        LABFU.DATE_SERV,
        LABFU.LABTEST,
        LABFU.LABRESULT,
        LABFU.D_UPDATE,
        LABFU.CID,
        LABFU.HDC_DATE,
        LABFU.SOURCE_DATA
 FROM st4hdc.LABFU
 ORDER BY LABFU.HOSPCODE,
          LABFU.PID,
          LABFU.SEQ,
          LABFU.DATE_SERV,
          LABFU.LABTEST
SEGMENTED BY hash(LABFU.HOSPCODE, LABFU.PID, LABFU.SEQ, LABFU.DATE_SERV, LABFU.LABTEST) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
