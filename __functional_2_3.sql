DROP TABLE st4hdc.FUNCTIONAL;

CREATE TABLE st4hdc.FUNCTIONAL
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16) NOT NULL,
    DATE_SERV date NOT NULL,
    FUNCTIONAL_TEST varchar(2) NOT NULL,
    TESTRESULT varchar(3),
    DEPENDENT char(1),
    PROVIDER varchar(15),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.FUNCTIONAL ADD CONSTRAINT FUNCTIONAL_PK PRIMARY KEY (HOSPCODE, PID, SEQ, FUNCTIONAL_TEST) ENABLED;

CREATE PROJECTION st4hdc.FUNCTIONAL /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 DATE_SERV,
 FUNCTIONAL_TEST,
 TESTRESULT,
 DEPENDENT,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT FUNCTIONAL.HOSPCODE,
        FUNCTIONAL.PID,
        FUNCTIONAL.SEQ,
        FUNCTIONAL.DATE_SERV,
        FUNCTIONAL.FUNCTIONAL_TEST,
        FUNCTIONAL.TESTRESULT,
        FUNCTIONAL.DEPENDENT,
        FUNCTIONAL.PROVIDER,
        FUNCTIONAL.D_UPDATE,
        FUNCTIONAL.CID,
        FUNCTIONAL.HDC_DATE,
        FUNCTIONAL.SOURCE_DATA
 FROM st4hdc.FUNCTIONAL
 ORDER BY FUNCTIONAL.HOSPCODE,
          FUNCTIONAL.PID,
          FUNCTIONAL.SEQ,
          FUNCTIONAL.FUNCTIONAL_TEST
SEGMENTED BY hash(FUNCTIONAL.HOSPCODE, FUNCTIONAL.PID, FUNCTIONAL.SEQ, FUNCTIONAL.FUNCTIONAL_TEST) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
