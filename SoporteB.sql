CREATE DATABASE soporteB;
USE soporteB;

--drop database soporteB; 

--valores no  nulos , integridad  
--integridad referencial 

CREATE TABLE Country (
    CountryID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    DateOfBirth DATE,
    Name VARCHAR(100)
);

CREATE TABLE City (
    CityID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE Airport (
    AirportID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
	CityID INT,
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

CREATE TABLE Document (
    DocumentID INT PRIMARY KEY IDENTITY,
    DocumentType VARCHAR(50) NOT NULL, -- Ejemplo: Cédula de Identidad, Pasaporte
    DocumentNumber VARCHAR(50) NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
--  fecha de emision y vencimiento 

-- Añadir categorías de vuelo
CREATE TABLE FlightCategory (
    FlightCategoryID INT PRIMARY KEY IDENTITY,
    CategoryName VARCHAR(50) NOT NULL -- Ejemplo: Primera Clase, Clase Ejecutiva, Clase Económica
);

CREATE TABLE PlaneModel (
    PlaneModelID INT PRIMARY KEY IDENTITY,
    Description VARCHAR(100),
    Graphic VARBINARY(MAX)
);

CREATE TABLE FlightNumber (
    FlightNumberID INT PRIMARY KEY IDENTITY,
    DepartureTime DATETIME,
    Description VARCHAR(50),
    Type VARCHAR(50),
    Airline VARCHAR(50),
    StartAirportID INT,
    GoalAirportID INT,
    PlaneModelID INT,
    FlightCategoryID INT,
    FOREIGN KEY (StartAirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (GoalAirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID),
    FOREIGN KEY (FlightCategoryID) REFERENCES FlightCategory(FlightCategoryID)
);



CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY,
    TicketingCode VARCHAR(50),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE FrequentFlyerCard (-- tarjeta de vieajes frecuentes 
    FFC_Number INT PRIMARY KEY,
    Miles INT,
    Meal_Code VARCHAR(10),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);



CREATE TABLE Airplane (
    AirplaneID INT PRIMARY KEY IDENTITY,
    RegistrationNumber VARCHAR(50),
    BeginOfOperation DATE,
    Status VARCHAR(50),
    PlaneModelID INT,
    FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID)
);

CREATE TABLE Flight (
    FlightID INT PRIMARY KEY IDENTITY,
    BoardingTime DATETIME,
    FlightDate DATE,
    Gate VARCHAR(50),
    CheckInCounter VARCHAR(50),
    FlightNumberID INT,
    FOREIGN KEY (FlightNumberID) REFERENCES FlightNumber(FlightNumberID)
);

CREATE TABLE Seat (
    SeatID INT PRIMARY KEY IDENTITY,
    Size VARCHAR(50),
    Number INT,
    Location VARCHAR(50),
    PlaneModelID INT,
    FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID)
);

CREATE TABLE AvailableSeat (-- asiento disponible 
    AvailableSeatID INT PRIMARY KEY IDENTITY,
    FlightID INT,
    SeatID INT,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID)
);

CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY IDENTITY,
    DateOfRedemption DATE,--fecha por defecto del sistema 
    Class VARCHAR(50),
    Standby VARCHAR(50),
    MealCode VARCHAR(50),
    TicketID INT,
    FlightID INT,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

CREATE TABLE Coupon_AvailableSeat (
    CouponID INT,
    AvailableSeatID INT,
    PRIMARY KEY (CouponID, AvailableSeatID),
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID),
    FOREIGN KEY (AvailableSeatID) REFERENCES AvailableSeat(AvailableSeatID)
);

CREATE TABLE PiecesOfLuggage (--piezas de equipaje 
    LuggageID INT PRIMARY KEY IDENTITY,
    Number INT,
    Weight DECIMAL(5, 2),
    CouponID INT,
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
);

--inserción de datos 
INSERT INTO Country (Name) VALUES ('Bolivia');
INSERT INTO Country (Name) VALUES ('Argentina');
INSERT INTO Country (Name) VALUES ('Brasil');
INSERT INTO Country (Name) VALUES ('Chile');

select * from Country; 

INSERT INTO City (Name, CountryID) VALUES ('Santa Cruz', 1);
INSERT INTO City (Name, CountryID) VALUES ('Buenos Aires', 2);
INSERT INTO City (Name, CountryID) VALUES ('São Paulo', 3);
INSERT INTO City (Name, CountryID) VALUES ('Santiago', 4);

select * from city ; 

INSERT INTO Airport (Name, CityID) VALUES ('Viru Viru International Airport', 1);
INSERT INTO Airport (Name, CityID) VALUES ('Ministro Pistarini International Airport', 2);
INSERT INTO Airport (Name, CityID) VALUES ('São Paulo–Guarulhos International Airport', 3);
INSERT INTO Airport (Name, CityID) VALUES ('Comodoro Arturo Merino Benítez International Airport', 4);

select * from airport  ;

INSERT INTO Customer (DateOfBirth, Name) VALUES ('1990-05-15', 'Leo Sanchez');
INSERT INTO Customer (DateOfBirth, Name) VALUES ('1985-09-23', 'Wilson Duran');
INSERT INTO Customer (DateOfBirth, Name) VALUES ('1992-11-05', 'Juan Pérez');
INSERT INTO Customer (DateOfBirth, Name) VALUES ('1988-02-12', 'María López');

select * from customer ; 

INSERT INTO Document (DocumentType, DocumentNumber, CustomerID) VALUES ('Cédula de Identidad', '1234567', 1);
INSERT INTO Document (DocumentType, DocumentNumber, CustomerID) VALUES ('Pasaporte', 'P9876543', 2);
INSERT INTO Document (DocumentType, DocumentNumber, CustomerID) VALUES ('Cédula de Identidad', '7654321', 3);
INSERT INTO Document (DocumentType, DocumentNumber, CustomerID) VALUES ('Pasaporte', 'P1239874', 4);

select * from document ; 

INSERT INTO PlaneModel (Description, Graphic) VALUES ('Boeing 737', NULL);
INSERT INTO PlaneModel (Description, Graphic) VALUES ('Airbus A320', NULL);
INSERT INTO PlaneModel (Description, Graphic) VALUES ('Boeing 787', NULL);
INSERT INTO PlaneModel (Description, Graphic) VALUES ('Airbus A380', NULL);

select * from PlaneModel;


INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, PlaneModelID) 
VALUES ('CP-1234', '2010-03-15', 'Operational', 1);

INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, PlaneModelID) 
VALUES ('AR-5678', '2012-07-20', 'Operational', 2);

INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, PlaneModelID) 
VALUES ('BR-9012', '2015-11-01', 'Operational', 3);

INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, PlaneModelID) 
VALUES ('CL-3456', '2018-05-10', 'Operational', 4);

select * from airplane ; 

INSERT INTO FlightCategory (CategoryName) VALUES ('Primera Clase');
INSERT INTO FlightCategory (CategoryName) VALUES ('Clase Ejecutiva');
INSERT INTO FlightCategory (CategoryName) VALUES ('Clase Económica');
INSERT INTO FlightCategory (CategoryName) VALUES ('Clase Premium Economy');

select * from FlightCategory; 

INSERT INTO FlightNumber (DepartureTime, Description, Type, Airline, StartAirportID, GoalAirportID, PlaneModelID, FlightCategoryID) 
VALUES ('2024-09-01 08:00:00', 'VVI-EZE', 'Internacional', 'Aerolíneas Argentinas', 1, 2, 1, 2);

INSERT INTO FlightNumber (DepartureTime, Description, Type, Airline, StartAirportID, GoalAirportID, PlaneModelID, FlightCategoryID) 
VALUES ('2024-09-02 10:00:00', 'GRU-SCL', 'Internacional', 'LATAM', 3, 4, 2, 3);

INSERT INTO FlightNumber (DepartureTime, Description, Type, Airline, StartAirportID, GoalAirportID, PlaneModelID, FlightCategoryID) 
VALUES ('2024-09-03 12:00:00', 'EZE-GRU', 'Internacional', 'Gol Linhas Aéreas', 2, 3, 3, 1);

INSERT INTO FlightNumber (DepartureTime, Description, Type, Airline, StartAirportID, GoalAirportID, PlaneModelID, FlightCategoryID) 
VALUES ('2024-09-04 14:00:00', 'SCL-VVI', 'Internacional', 'Boliviana de Aviación', 4, 1, 4, 2);

select * from FlightNumber; 

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, FlightNumberID) 
VALUES ('2024-09-01 07:00:00', '2024-09-01', 'A1', '5', 1);

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, FlightNumberID) 
VALUES ('2024-09-02 09:00:00', '2024-09-02', 'B2', '10', 2);

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, FlightNumberID) 
VALUES ('2024-09-03 11:00:00', '2024-09-03', 'C3', '15', 3);

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, FlightNumberID) 
VALUES ('2024-09-04 13:00:00', '2024-09-04', 'D4', '20', 4);

select * from Flight ; 

INSERT INTO Seat (Size, Number, Location, PlaneModelID) VALUES ('Large', 1, 'Window', 1);
INSERT INTO Seat (Size, Number, Location, PlaneModelID) VALUES ('Medium', 2, 'Aisle', 2);
INSERT INTO Seat (Size, Number, Location, PlaneModelID) VALUES ('Small', 3, 'Middle', 3);
INSERT INTO Seat (Size, Number, Location, PlaneModelID) VALUES ('Large', 4, 'Window', 4);

select * from seat; 

INSERT INTO AvailableSeat (FlightID, SeatID) VALUES (1, 1);
INSERT INTO AvailableSeat (FlightID, SeatID) VALUES (2, 2);
INSERT INTO AvailableSeat (FlightID, SeatID) VALUES (3, 3);
INSERT INTO AvailableSeat (FlightID, SeatID) VALUES (4, 4);

select * from AvailableSeat; 

INSERT INTO Ticket (TicketingCode, CustomerID) VALUES ('TK-001', 1);
INSERT INTO Ticket (TicketingCode, CustomerID) VALUES ('TK-002', 2);
INSERT INTO Ticket (TicketingCode, CustomerID) VALUES ('TK-003', 3);
INSERT INTO Ticket (TicketingCode, CustomerID) VALUES ('TK-004', 4);

select * from  ticket; 

INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, TicketID, FlightID) 
VALUES ('2024-09-01', 'Economy', 'No', 'Vegan', 1, 1);

INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, TicketID, FlightID) 
VALUES ('2024-09-02', 'Business', 'No', 'Vegetarian', 2, 2);

INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, TicketID, FlightID) 
VALUES ('2024-09-03', 'First', 'Yes', 'Regular', 3, 3);

INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, TicketID, FlightID) 
VALUES ('2024-09-04', 'Premium Economy', 'No', 'Kosher', 4, 4);

select * from Coupon; 

INSERT INTO Coupon_AvailableSeat (CouponID, AvailableSeatID) VALUES (4, 1);
INSERT INTO Coupon_AvailableSeat (CouponID, AvailableSeatID) VALUES (3, 2);
INSERT INTO Coupon_AvailableSeat (CouponID, AvailableSeatID) VALUES (2, 3);
INSERT INTO Coupon_AvailableSeat (CouponID, AvailableSeatID) VALUES (1, 4);

select * from Coupon_AvailableSeat;

INSERT INTO PiecesOfLuggage (Number, Weight, CouponID) VALUES (2, 23.5, 4);
INSERT INTO PiecesOfLuggage (Number, Weight, CouponID) VALUES (1, 18.0, 1);
INSERT INTO PiecesOfLuggage (Number, Weight, CouponID) VALUES (3, 27.0, 3);
INSERT INTO PiecesOfLuggage (Number, Weight, CouponID) VALUES (2, 25.0, 2);

select * from PiecesOfLuggage;

--version 3 , con integridad de datos e identidad referencial 
-- base de datos indexadas (indice)(create index)
--generar un indice para otros campos (no llaves primarias )