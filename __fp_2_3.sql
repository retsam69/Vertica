DROP TABLE st4hdc.FP;

CREATE TABLE st4hdc.FP
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16),
    DATE_SERV date NOT NULL,
    FPTYPE char(1) NOT NULL,
    FPPLACE varchar(5),
    PROVIDER varchar(15),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.FP ADD CONSTRAINT FP_PK PRIMARY KEY (HOSPCODE, PID, DATE_SERV, FPTYPE) ENABLED;

CREATE PROJECTION st4hdc.FP /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 DATE_SERV,
 FPTYPE,
 FPPLACE,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT FP.HOSPCODE,
        FP.PID,
        FP.SEQ,
        FP.DATE_SERV,
        FP.FPTYPE,
        FP.FPPLACE,
        FP.PROVIDER,
        FP.D_UPDATE,
        FP.CID,
        FP.HDC_DATE,
        FP.SOURCE_DATA
 FROM st4hdc.FP
 ORDER BY FP.HOSPCODE,
          FP.PID,
          FP.DATE_SERV,
          FP.FPTYPE
SEGMENTED BY hash(FP.HOSPCODE, FP.PID, FP.DATE_SERV, FP.FPTYPE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
