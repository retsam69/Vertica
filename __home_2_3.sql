DROP TABLE st4hdc.HOME;

CREATE TABLE st4hdc.HOME
(
    HOSPCODE varchar(5) NOT NULL,
    HID varchar(14) NOT NULL,
    HOUSE_ID varchar(11),
    HOUSETYPE varchar(1),
    ROOMNO varchar(10),
    CONDO varchar(75),
    HOUSE varchar(75),
    SOISUB varchar(255),
    SOIMAIN varchar(255),
    ROAD varchar(255),
    VILLANAME varchar(255),
    VILLAGE varchar(2),
    TAMBON varchar(2),
    AMPUR varchar(2),
    CHANGWAT varchar(2),
    TELEPHONE varchar(15),
    LATITUDE numeric(10,6),
    LONGITUDE numeric(10,6),
    NFAMILY varchar(2),
    LOCATYPE varchar(1),
    VHVID varchar(15),
    HEADID varchar(15),
    TOILET varchar(1),
    WATER varchar(1),
    WATERTYPE varchar(1),
    GARBAGE varchar(1),
    HOUSING varchar(1),
    DURABILITY varchar(1),
    CLEANLINESS varchar(1),
    VENTILATION varchar(1),
    LIGHT varchar(1),
    WATERTM varchar(1),
    MFOOD varchar(1),
    BCONTROL varchar(1),
    ACONTROL varchar(1),
    CHEMICAL varchar(1),
    OUTDATE date,
    D_UPDATE timestamp NOT NULL,
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.HOME ADD CONSTRAINT HOME_PK PRIMARY KEY (HOSPCODE, HID) ENABLED;

CREATE PROJECTION st4hdc.HOME /*+createtype(A)*/ 
(
 HOSPCODE,
 HID,
 HOUSE_ID,
 HOUSETYPE,
 ROOMNO,
 CONDO,
 HOUSE,
 SOISUB,
 SOIMAIN,
 ROAD,
 VILLANAME,
 VILLAGE,
 TAMBON,
 AMPUR,
 CHANGWAT,
 TELEPHONE,
 LATITUDE,
 LONGITUDE,
 NFAMILY,
 LOCATYPE,
 VHVID,
 HEADID,
 TOILET,
 WATER,
 WATERTYPE,
 GARBAGE,
 HOUSING,
 DURABILITY,
 CLEANLINESS,
 VENTILATION,
 LIGHT,
 WATERTM,
 MFOOD,
 BCONTROL,
 ACONTROL,
 CHEMICAL,
 OUTDATE,
 D_UPDATE,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT HOME.HOSPCODE,
        HOME.HID,
        HOME.HOUSE_ID,
        HOME.HOUSETYPE,
        HOME.ROOMNO,
        HOME.CONDO,
        HOME.HOUSE,
        HOME.SOISUB,
        HOME.SOIMAIN,
        HOME.ROAD,
        HOME.VILLANAME,
        HOME.VILLAGE,
        HOME.TAMBON,
        HOME.AMPUR,
        HOME.CHANGWAT,
        HOME.TELEPHONE,
        HOME.LATITUDE,
        HOME.LONGITUDE,
        HOME.NFAMILY,
        HOME.LOCATYPE,
        HOME.VHVID,
        HOME.HEADID,
        HOME.TOILET,
        HOME.WATER,
        HOME.WATERTYPE,
        HOME.GARBAGE,
        HOME.HOUSING,
        HOME.DURABILITY,
        HOME.CLEANLINESS,
        HOME.VENTILATION,
        HOME.LIGHT,
        HOME.WATERTM,
        HOME.MFOOD,
        HOME.BCONTROL,
        HOME.ACONTROL,
        HOME.CHEMICAL,
        HOME.OUTDATE,
        HOME.D_UPDATE,
        HOME.HDC_DATE,
        HOME.SOURCE_DATA
 FROM st4hdc.HOME
 ORDER BY HOME.HOSPCODE,
          HOME.HID
SEGMENTED BY hash(HOME.HOSPCODE, HOME.HID) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
