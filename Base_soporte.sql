--Cesary Sorioco Miguel Angel 
--221064801

CREATE DATABASE soporte ; 
use soporte; 

CREATE TABLE FrequentFlyerCard (
    FCCNumber VARCHAR(20) PRIMARY KEY,
    Miles INT,
    MealCode VARCHAR(10)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY ,
    Name VARCHAR(100),
    DateOfBirth DATE,
    FCCNumber VARCHAR(20),
    FOREIGN KEY (FCCNumber) REFERENCES FrequentFlyerCard(FCCNumber)
);

CREATE TABLE Ticket (
    TicketNumber VARCHAR(20) PRIMARY KEY,
    TicketingCode VARCHAR(20),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY ,
    DateOfRedemption DATE,
    Class VARCHAR(20),
    Standby BIT,
    MealCode VARCHAR(10),
--	 AvailableSeatID INT, 
   TicketNumber VARCHAR(20),
    FOREIGN KEY (TicketNumber) REFERENCES Ticket(TicketNumber),
	--FOREIGN KEY (AvailableSeatID) REFERENCES AvailableSeat(AvailableSeatID),
	 FlightID VARCHAR(20),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
);

CREATE TABLE PiecesOfLuggage (
    LuggageID INT PRIMARY KEY,
    Number INT,
    Weight DECIMAL(5,2),
    CouponID INT,
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
);

CREATE TABLE Airport (
    AirportID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE FlightNumber(
	FlightNumberID VARCHAR(20)PRIMARY KEY , 
	DepartureTime DATETIME,
	Description VARCHAR(255),
	Type VARCHAR(50),
	Airline VARCHAR(100),
	StartAirportID INT,
    GoalAirportID INT,
    FOREIGN KEY (StartAirportID) REFERENCES Airport(AirportID),
    FOREIGN KEY (GoalAirportID) REFERENCES Airport(AirportID),
	ModelID INT , 
	FOREIGN KEY (ModelID) REFERENCES PlaneModel(ModelID)
); 

CREATE TABLE Flight (
    FlightID VARCHAR(20) PRIMARY KEY,
     boarding_time TIME,          -- Hora de embarque, tipo TIME
    flight_date DATE,            -- Fecha del vuelo, tipo DATE
    gate VARCHAR(10),            -- Puerta de embarque, tipo VARCHAR (hasta 10 caracteres)
    check_in_counter VARCHAR(10) ,-- Mostrador de check-in, tipo VARCHAR (hasta 10 caracteres)
	FlightNumberID VARCHAR(20),
	FOREIGN KEY (FlightNumberID) REFERENCES FlightNumber(FlightNumberID)
);


CREATE TABLE AvailableSeat (
    AvailableSeatID INT PRIMARY KEY,
    FlightID VARCHAR(20),
    SeatID INT,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID),
	 CouponID INT,
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
);


CREATE TABLE Airplane (
    RegistrationNumber VARCHAR(20) PRIMARY KEY,
    BeginOfOperation DATE,
    Status VARCHAR(20),
	ModelID INT , 
	FOREIGN KEY (ModelID) REFERENCES PlaneModel(ModelID)
);

CREATE TABLE PlaneModel (
    ModelID INT PRIMARY KEY,
    Description VARCHAR(255),
    Graphic VARBINARY(MAX) ,
);

CREATE TABLE Seat (
    SeatID INT PRIMARY KEY ,
    Size VARCHAR(10),
    Number VARCHAR(10),
    Location VARCHAR(50),
    ModelID INT,
    FOREIGN KEY (ModelID) REFERENCES PlaneModel(ModelID)
);