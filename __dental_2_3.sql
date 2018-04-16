DROP TABLE st4hdc.DENTAL;

CREATE TABLE st4hdc.DENTAL
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16) NOT NULL,
    DATE_SERV date NOT NULL,
    DENTTYPE varchar(1) NOT NULL,
    SERVPLACE varchar(1) NOT NULL,
    PTEETH numeric(2,0),
    PCARIES numeric(2,0),
    PFILLING numeric(2,0),
    PEXTRACT numeric(2,0),
    DTEETH numeric(2,0),
    DCARIES numeric(2,0),
    DFILLING numeric(2,0),
    DEXTRACT numeric(2,0),
    NEED_FLUORIDE char(1),
    NEED_SCALING char(1),
    NEED_SEALANT numeric(2,0),
    NEED_PFILLING numeric(2,0),
    NEED_DFILLING numeric(2,0),
    NEED_PEXTRACT numeric(2,0),
    NEED_DEXTRACT numeric(2,0),
    NPROSTHESIS char(1),
    PERMANENT_PERMANENT numeric(6,0),
    PERMANENT_PROSTHESIS numeric(6,0),
    PROSTHESIS_PROSTHESIS numeric(6,0),
    GUM varchar(6),
    SCHOOLTYPE char(1),
    CLASS char(1),
    PROVIDER varchar(15),
    D_UPDATE timestamp,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.DENTAL ADD CONSTRAINT DENTAL_PK PRIMARY KEY (HOSPCODE, PID, SEQ, DATE_SERV) ENABLED;

CREATE PROJECTION st4hdc.DENTAL /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 DATE_SERV,
 DENTTYPE,
 SERVPLACE,
 PTEETH,
 PCARIES,
 PFILLING,
 PEXTRACT,
 DTEETH,
 DCARIES,
 DFILLING,
 DEXTRACT,
 NEED_FLUORIDE,
 NEED_SCALING,
 NEED_SEALANT,
 NEED_PFILLING,
 NEED_DFILLING,
 NEED_PEXTRACT,
 NEED_DEXTRACT,
 NPROSTHESIS,
 PERMANENT_PERMANENT,
 PERMANENT_PROSTHESIS,
 PROSTHESIS_PROSTHESIS,
 GUM,
 SCHOOLTYPE,
 CLASS,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT DENTAL.HOSPCODE,
        DENTAL.PID,
        DENTAL.SEQ,
        DENTAL.DATE_SERV,
        DENTAL.DENTTYPE,
        DENTAL.SERVPLACE,
        DENTAL.PTEETH,
        DENTAL.PCARIES,
        DENTAL.PFILLING,
        DENTAL.PEXTRACT,
        DENTAL.DTEETH,
        DENTAL.DCARIES,
        DENTAL.DFILLING,
        DENTAL.DEXTRACT,
        DENTAL.NEED_FLUORIDE,
        DENTAL.NEED_SCALING,
        DENTAL.NEED_SEALANT,
        DENTAL.NEED_PFILLING,
        DENTAL.NEED_DFILLING,
        DENTAL.NEED_PEXTRACT,
        DENTAL.NEED_DEXTRACT,
        DENTAL.NPROSTHESIS,
        DENTAL.PERMANENT_PERMANENT,
        DENTAL.PERMANENT_PROSTHESIS,
        DENTAL.PROSTHESIS_PROSTHESIS,
        DENTAL.GUM,
        DENTAL.SCHOOLTYPE,
        DENTAL.CLASS,
        DENTAL.PROVIDER,
        DENTAL.D_UPDATE,
        DENTAL.CID,
        DENTAL.HDC_DATE,
        DENTAL.SOURCE_DATA
 FROM st4hdc.DENTAL
 ORDER BY DENTAL.HOSPCODE,
          DENTAL.PID,
          DENTAL.SEQ,
          DENTAL.DATE_SERV
SEGMENTED BY hash(DENTAL.HOSPCODE, DENTAL.PID, DENTAL.SEQ, DENTAL.DATE_SERV) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);