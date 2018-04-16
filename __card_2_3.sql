DROP TABLE st4hdc.CARD;

CREATE TABLE st4hdc.CARD
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    INSTYPE_OLD varchar(2),
    INSTYPE_NEW varchar(4) NOT NULL,
    INSID varchar(18),
    STARTDATE date,
    EXPIREDATE date,
    MAIN varchar(5),
    SUB varchar(5),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.CARD ADD CONSTRAINT CARD_PK PRIMARY KEY (HOSPCODE, PID, INSTYPE_NEW) ENABLED;

CREATE PROJECTION st4hdc.CARD /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 INSTYPE_OLD,
 INSTYPE_NEW,
 INSID,
 STARTDATE,
 EXPIREDATE,
 MAIN,
 SUB,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT CARD.HOSPCODE,
        CARD.PID,
        CARD.INSTYPE_OLD,
        CARD.INSTYPE_NEW,
        CARD.INSID,
        CARD.STARTDATE,
        CARD.EXPIREDATE,
        CARD.MAIN,
        CARD.SUB,
        CARD.D_UPDATE,
        CARD.CID,
        CARD.HDC_DATE,
        CARD.SOURCE_DATA
 FROM st4hdc.CARD
 ORDER BY CARD.HOSPCODE,
          CARD.PID,
          CARD.INSTYPE_NEW
SEGMENTED BY hash(CARD.HOSPCODE, CARD.PID, CARD.INSTYPE_NEW) ALL NODES KSAFE 1;

-- SELECT MARK_DESIGN_KSAFE(1);