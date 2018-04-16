DROP TABLE st4hdc.POSTNATAL;

CREATE TABLE st4hdc.POSTNATAL
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16),
    GRAVIDA varchar(2) NOT NULL,
    BDATE date NOT NULL,
    PPCARE date NOT NULL,
    PPPLACE varchar(5),
    PPRESULT char(1) NOT NULL,
    PROVIDER varchar(15),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.POSTNATAL ADD CONSTRAINT POSTNATAL_PK PRIMARY KEY (HOSPCODE, PID, GRAVIDA, PPCARE) ENABLED;

CREATE PROJECTION st4hdc.POSTNATAL /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 GRAVIDA,
 BDATE,
 PPCARE,
 PPPLACE,
 PPRESULT,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT POSTNATAL.HOSPCODE,
        POSTNATAL.PID,
        POSTNATAL.SEQ,
        POSTNATAL.GRAVIDA,
        POSTNATAL.BDATE,
        POSTNATAL.PPCARE,
        POSTNATAL.PPPLACE,
        POSTNATAL.PPRESULT,
        POSTNATAL.PROVIDER,
        POSTNATAL.D_UPDATE,
        POSTNATAL.CID,
        POSTNATAL.HDC_DATE,
        POSTNATAL.SOURCE_DATA
 FROM st4hdc.POSTNATAL
 ORDER BY POSTNATAL.HOSPCODE,
          POSTNATAL.PID,
          POSTNATAL.GRAVIDA,
          POSTNATAL.PPCARE
SEGMENTED BY hash(POSTNATAL.HOSPCODE, POSTNATAL.PID, POSTNATAL.GRAVIDA, POSTNATAL.PPCARE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
