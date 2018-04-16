DROP TABLE st4hdc.CHRONIC;

CREATE TABLE st4hdc.CHRONIC
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    DATE_DIAG date NOT NULL,
    CHRONIC varchar(6) NOT NULL,
    HOSP_DX varchar(5),
    HOSP_RX varchar(5),
    DATE_DISCH date,
    TYPEDISCH varchar(2)  NOT NULL,
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.CHRONIC ADD CONSTRAINT CHRONIC_PK PRIMARY KEY (HOSPCODE, PID, DATE_DIAG, CHRONIC, D_UPDATE) ENABLED;

CREATE PROJECTION st4hdc.CHRONIC /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 DATE_DIAG,
 CHRONIC,
 HOSP_DX,
 HOSP_RX,
 DATE_DISCH,
 TYPEDISCH,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT CHRONIC.HOSPCODE,
        CHRONIC.PID,
        CHRONIC.DATE_DIAG,
        CHRONIC.CHRONIC,
        CHRONIC.HOSP_DX,
        CHRONIC.HOSP_RX,
        CHRONIC.DATE_DISCH,
        CHRONIC.TYPEDISCH,
        CHRONIC.D_UPDATE,
        CHRONIC.CID,
        CHRONIC.HDC_DATE,
        CHRONIC.SOURCE_DATA
 FROM st4hdc.CHRONIC
 ORDER BY CHRONIC.HOSPCODE,
          CHRONIC.PID,
          CHRONIC.DATE_DIAG,
          CHRONIC.CHRONIC,
          CHRONIC.D_UPDATE
SEGMENTED BY hash(CHRONIC.HOSPCODE, CHRONIC.PID, CHRONIC.DATE_DIAG, CHRONIC.CHRONIC, CHRONIC.D_UPDATE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);