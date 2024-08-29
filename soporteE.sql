Use master
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'soporteE')
BEGIN
    ALTER DATABASE [soporteE] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [soporteE];
END

CREATE DATABASE soporteE;
GO

USE soporteE;
GO

CREATE TABLE Country (
    CountryID INT PRIMARY KEY IDENTITY, 
    Name VARCHAR(100) NOT NULL 
);
GO

CREATE TABLE DocumentType (
    DocumentTypeID INT PRIMARY KEY IDENTITY, 
    TypeName VARCHAR(50) NOT NULL 
);
GO

CREATE TABLE FlightCategory (
    FlightCategoryID INT PRIMARY KEY IDENTITY, 
    CategoryName VARCHAR(50) NOT NULL 
);
GO

CREATE TABLE PlaneModel (
    PlaneModelID INT PRIMARY KEY IDENTITY, 
    Description VARCHAR(100) NOT NULL, 
    Graphic VARBINARY(MAX) 
);
GO

CREATE TABLE Clase (
    ClaseID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    NombreClase VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    Descripcion VARCHAR(255) -- Hasta 255 caracteres
);
GO



CREATE TABLE City (
    CityID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    Name VARCHAR(100) NOT NULL, -- Hasta 100 caracteres
    CountryID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Airport (
    AirportID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    Name VARCHAR(100) NOT NULL, -- Hasta 100 caracteres
    CityID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (CityID) REFERENCES City(CityID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    DateOfBirth DATE,
    Name VARCHAR(100) NOT NULL, -- Hasta 100 caracteres
  
);
GO

CREATE TABLE Document (
    DocumentID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    DocumentTypeID INT, -- Clave foránea
    DocumentNumber VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    IssueDate DATE,
    ExpiryDate DATE,
    IssuingAuthority VARCHAR(100), -- Hasta 100 caracteres
    CustomerID INT, -- Clave foránea
    FOREIGN KEY (DocumentTypeID) REFERENCES DocumentType(DocumentTypeID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE SET NULL
    ON UPDATE NO ACTION
);
GO

CREATE TABLE FlightNumber (
    FlightNumberID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    DepartureTime DATETIME NOT NULL,
    Description VARCHAR(50) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Airline VARCHAR(50) NOT NULL,
    StartAirportID INT NOT NULL, 
    GoalAirportID INT NOT NULL, 
    PlaneModelID INT NOT NULL,
    FlightCategoryID INT NOT NULL, --
    FOREIGN KEY (StartAirportID) REFERENCES Airport(AirportID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (GoalAirportID) REFERENCES Airport(AirportID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (FlightCategoryID) REFERENCES FlightCategory(FlightCategoryID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    TicketingCode VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    CustomerID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
GO

CREATE TABLE FrequentFlyerCard (
    FFC_Number INT PRIMARY KEY, -- 10 dígitos
    Miles INT NOT NULL,
    Meal_Code VARCHAR(10) NOT NULL, -- Hasta 10 caracteres
    CustomerID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Airplane (
    AirplaneID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    RegistrationNumber VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    BeginOfOperation DATE NOT NULL,
    Status VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    PlaneModelID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Flight (
    FlightID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    BoardingTime DATETIME NOT NULL,
    FlightDate DATE NOT NULL,
    Gate VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    CheckInCounter VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    FlightNumberID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (FlightNumberID) REFERENCES FlightNumber(FlightNumberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Seat (
    SeatID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    Size VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    Number INT NOT NULL, -- Número del asiento
    Location VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    PlaneModelID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (PlaneModelID) REFERENCES PlaneModel(PlaneModelID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO

CREATE TABLE AvailableSeat (
    AvailableSeatID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    FlightID INT NOT NULL, -- Clave foránea
    SeatID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    DateOfRedemption DATE NOT NULL,
    Standby VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    MealCode VARCHAR(50) NOT NULL, -- Hasta 50 caracteres
    TicketID INT NOT NULL, -- Clave foránea
    FlightID INT NOT NULL, -- Clave foránea
    ClaseID INT,
    FOREIGN KEY (ClaseID) REFERENCES Clase(ClaseID)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
GO

CREATE TABLE Coupon_AvailableSeat (
    CouponID INT NOT NULL,
    AvailableSeatID INT NOT NULL,
    PRIMARY KEY (CouponID, AvailableSeatID),
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
    FOREIGN KEY (AvailableSeatID) REFERENCES AvailableSeat(AvailableSeatID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
GO

CREATE TABLE PiecesOfLuggage (
    LuggageID INT PRIMARY KEY IDENTITY, -- 10 dígitos
    Number INT NOT NULL, -- Número del equipaje
    Weight DECIMAL(5, 2) NOT NULL, -- Peso del equipaje (hasta 999.99 kg)
    CouponID INT NOT NULL, -- Clave foránea
    FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
GO
-----
 
CREATE INDEX idx_Customer_Name ON Customer(Name);--clientes por nombre
GO

CREATE UNIQUE INDEX idx_Document_DocumentNumber ON Document(DocumentNumber);--document number
GO
CREATE INDEX idx_Document_CustomerID ON Document(CustomerID);--uniones de busqueda por cliente 
GO
CREATE INDEX idx_FlightNumber_Airline ON FlightNumber(Airline);--vuelos de aerolinea 
GO
CREATE INDEX idx_FlightNumber_DepartureTime ON FlightNumber(DepartureTime);--vuelos por hora de salida 
GO
CREATE INDEX idx_Ticket_CustomerID ON Ticket(CustomerID);--tickets por cliente 
GO
CREATE UNIQUE INDEX idx_Ticket_TicketingCode ON Ticket(TicketingCode);--por codigo de ticket
GO
CREATE INDEX idx_Coupon_TicketID ON Coupon(TicketID);--
GO

-- Insertar datos en Country
INSERT INTO Country (Name) VALUES 
('Bolivia'),
('Argentina'),
('Brasil'),
('Perú'),
('Chile'),
('Colombia'),
('México'),
('Estados Unidos'),
('España'),
('Francia'),
('Italia'),
('Alemania'),
('Japón'),
('China'),
('India'),
('Canadá'),
('Australia'),
('Sudáfrica'),
('Rusia'),
('Suecia'),
('Noruega'),
('Finlandia'),
('Egipto'),
('Turquía'),
('Corea del Sur'),
('Nueva Zelanda'),
('Portugal'),
('Grecia'),
('Suiza'),
('Países Bajos');
GO
 
 Select * from Country;
-- Insertar datos en DocumentType
INSERT INTO DocumentType (TypeName) VALUES 
('Cédula de Identidad'),
('Pasaporte'),
('Licencia de Conducir'),
('Visa'),
('Permiso de Residencia');

Select * from DocumentType; 
GO


-- Insertar datos en FlightCategory
INSERT INTO FlightCategory (CategoryName) VALUES 
('Nacional'),
('Internacional'),
('Charter');
--('Económica'),
--('Primera Clase');

Select * from FlightCategory; 
GO

-- Insertar datos en PlaneModel
INSERT INTO PlaneModel (Description, Graphic) VALUES 
('Boeing 737', NULL),
('Airbus A320', NULL),
('Embraer 190', NULL),
('Boeing 777', NULL),
('Airbus A380', NULL);

Select * from PlaneModel; 
GO

-- Insertar datos en Clase
INSERT INTO Clase (NombreClase, Descripcion) VALUES 
('Economy', 'Clase económica'),
('Business', 'Clase ejecutiva'),
('First Class', 'Primera clase'),
('Premium Economy', 'Clase económica premium'),
('Charter', 'Clase charter');

Select * from Clase; 
GO

-- Insertar datos en City
INSERT INTO City (Name, CountryID) VALUES 
('La Paz', 1),
('Buenos Aires', 2),
('São Paulo', 3),
('Lima', 4),
('Santiago', 5),
('Bogotá', 6),
('Ciudad de México', 7),
('Nueva York', 8),
('Madrid', 9),
('París', 10),
('Roma', 11),              -- Italia
('Berlín', 12),            -- Alemania
('Tokio', 13),             -- Japón
('Beijing', 14),           -- China
('Nueva Delhi', 15),       -- India
('Toronto', 16),           -- Canadá
('Sídney', 17),            -- Australia
('Ciudad del Cabo', 18),   -- Sudáfrica
('Moscú', 19),             -- Rusia
('Estocolmo', 20),         -- Suecia
('Oslo', 21),              -- Noruega
('Helsinki', 22),          -- Finlandia
('El Cairo', 23),          -- Egipto
('Estambul', 24),          -- Turquía
('Seúl', 25),              -- Corea del Sur
('Auckland', 26),          -- Nueva Zelanda
('Lisboa', 27),            -- Portugal
('Atenas', 28),            -- Grecia
('Zúrich', 29),            -- Suiza
('Ámsterdam', 30);         -- Países Bajos

Select* from City;
GO

-- Insertar datos en Airport
INSERT INTO Airport (Name, CityID) VALUES 
('Aeropuerto Internacional El Alto', 1),
('Aeropuerto Internacional Ezeiza', 2),
('Aeropuerto Internacional de São Paulo', 3),
('Aeropuerto Internacional Jorge Chávez', 4),
('Aeropuerto Internacional Comodoro Arturo Merino Benítez', 5),
('Aeropuerto Internacional El Dorado', 6),
('Aeropuerto Internacional Benito Juárez', 7),
('Aeropuerto Internacional JFK', 8),
('Aeropuerto Internacional de Madrid-Barajas', 9),
('Aeropuerto Internacional Charles de Gaulle', 10);

Select * from Airport;
GO

-- Insertar datos en Customer
INSERT INTO Customer (DateOfBirth, Name) VALUES 
('1985-01-15', 'Miguel Angel'),
('1990-03-22', 'Juan Pérez'),
('1988-07-10', 'Maria Rodriguez'),
('1995-12-01', 'Ana Martinez'),
('1983-06-25', 'Carlos Lopez'),
('1979-11-30', 'Laura Gómez'),
('2000-04-14', 'José Fernández'),
('1986-08-08', 'Luis Sanchez'),
('1992-02-28', 'Sofia Gutierrez'),
('1981-05-20', 'Elena Castro'),
('1975-03-11', 'Alberto Herrera'),
('1998-11-23', 'Lucía Ramírez'),
('1967-09-14', 'Ricardo Gómez'),
('2003-02-10', 'Diana Martínez'),
('1989-06-05', 'Santiago Paredes');

Select * from  CUstomer; 
GO

-- Insertar datos en Document
INSERT INTO Document (DocumentTypeID, DocumentNumber, IssueDate, ExpiryDate, IssuingAuthority, CustomerID) VALUES 
(1, '12345678', '2020-01-01', '2030-01-01', 'SERECI', 1),
(2, 'A1234567', '2019-05-15', '2029-05-15', 'Ministerio de Gobierno', 2),
(3, '87654321', '2018-07-20', '2028-07-20', 'SERECI', 3),
(4, 'B7654321', '2017-10-10', '2027-10-10', 'Ministerio de Relaciones Exteriores', 4),
(5, 'C9876543', '2016-03-30', '2026-03-30', 'Ministerio de Gobierno', 5),
(1, '87654322', '2017-01-11', '2027-01-11', 'SERECI', 6),
(2, 'C1234567', '2018-02-28', '2028-02-28', 'Ministerio de Gobierno', 7),
(3, '12345679', '2019-04-03', '2029-04-03', 'SERECI', 8),
(4, 'B7654322', '2020-05-25', '2030-05-25', 'Ministerio de Relaciones Exteriores', 9),
(5, 'C9876544', '2021-08-18', '2031-08-18', 'Ministerio de Gobierno', 10);

Select * from Document;
GO

-- Insertar datos en FlightNumber
INSERT INTO FlightNumber (DepartureTime, Description, Type, Airline, StartAirportID, GoalAirportID, PlaneModelID, FlightCategoryID) VALUES 
('2024-09-01 14:00:00', 'Vuelo La Paz - Buenos Aires', 'Regular', 'Avianca', 1, 2, 1, 2),
('2024-09-02 15:30:00', 'Vuelo Buenos Aires - São Paulo', 'Regular', 'LATAM', 2, 3, 2, 2),
('2024-09-03 16:45:00', 'Vuelo São Paulo - Lima', 'Regular', 'Gol', 3, 4, 3, 2),
('2024-09-04 18:00:00', 'Vuelo Lima - Santiago', 'Regular', 'LATAM', 4, 5, 4, 2),
('2024-09-05 19:15:00', 'Vuelo Santiago - Bogotá', 'Regular', 'Avianca', 5, 6, 5, 2);

Select * from FlightNumber; 
GO

-- Insertar datos en Ticket
INSERT INTO Ticket (TicketingCode, CustomerID) VALUES 
('ABC123', 1),
('DEF456', 2),
('GHI789', 3),
('JKL012', 4),
('MNO345', 5),
('PQR678', 6),
('STU901', 7),
('VWX234', 8),
('YZA567', 9),
('BCD890', 10);

Select * from Ticket;
GO

-- Insertar datos en FrequentFlyerCard
INSERT INTO FrequentFlyerCard (FFC_Number, Miles, Meal_Code, CustomerID) VALUES 
(12345, 10000, 'VLML', 1),
(23456, 15000, 'HNML', 2),
(34567, 20000, 'VGML', 3),
(45678, 25000, 'RVML', 4),
(56789, 30000, 'AVML', 5),
(67890, 35000, 'LCML', 6),
(78901, 40000, 'BLML', 7),
(89012, 45000, 'FPML', 8),
(90123, 50000, 'LSML', 9),
(10234, 55000, 'NOML', 10);

Select * from FrequentFlyerCard;
GO

-- Insertar datos en Airplane
INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, PlaneModelID) VALUES 
('CP-1234', '2015-01-01', 'Active', 1),
('CP-2345', '2016-02-15', 'Active', 2),
('CP-3456', '2017-03-20', 'Active', 3),
('CP-4567', '2018-04-25', 'Active', 4),
('CP-5678', '2019-05-30', 'Active', 5);

Select * from Airplane;
GO

-- Insertar datos en Flight
INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, FlightNumberID) VALUES 
('2024-09-01 13:00:00', '2024-09-01', 'G1', 'C1', 1),
('2024-09-02 14:30:00', '2024-09-02', 'G2', 'C2', 2),
('2024-09-03 15:45:00', '2024-09-03', 'G3', 'C3', 3),
('2024-09-04 17:00:00', '2024-09-04', 'G4', 'C4', 4),
('2024-09-05 18:15:00', '2024-09-05', 'G5', 'C5', 5);

Select * from Flight; 
GO

-- Insertar datos en Seat
INSERT INTO Seat (Size, Number, Location, PlaneModelID) VALUES 
('Standard', 1, 'Window', 1),
('Standard', 2, 'Aisle', 2),
('Standard', 3, 'Window', 3),
('Standard', 4, 'Aisle', 4),
('Standard', 5, 'Window', 5),
('Extra Legroom', 6, 'Exit Row', 1),
('Extra Legroom', 7, 'Exit Row', 2),
('Extra Legroom', 8, 'Exit Row', 3),
('Extra Legroom', 9, 'Exit Row', 4),
('Extra Legroom', 10, 'Exit Row', 5);

Select * from Seat; 
GO

-- Insertar datos en AvailableSeat
INSERT INTO AvailableSeat (FlightID, SeatID) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6),
(2, 7),
(3, 8),
(4, 9),
(5, 10);

Select * from  AvailableSeat; 
GO


-- Insertar datos en Coupon
INSERT INTO Coupon (DateOfRedemption, Standby, MealCode, TicketID, FlightID, ClaseID) VALUES 
('2024-09-01', 'No', 'VLML', 1, 1, 1),
('2024-09-02', 'Yes', 'HNML', 2, 2, 2),
('2024-09-03', 'No', 'VGML', 3, 3, 3),
('2024-09-04', 'Yes', 'RVML', 4, 4, 4),
('2024-09-05', 'No', 'AVML', 5, 5, 5),
('2024-09-06', 'Yes', 'LCML', 6, 1, 1),
('2024-09-07', 'No', 'BLML', 7, 2, 2),
('2024-09-08', 'Yes', 'FPML', 8, 3, 3),
('2024-09-09', 'No', 'LSML', 9, 4, 4),
('2024-09-10', 'Yes', 'NOML', 10, 5, 5);

Select * from Coupon; 
GO

-- Insertar datos en Coupon_AvailableSeat
INSERT INTO Coupon_AvailableSeat (CouponID, AvailableSeatID) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

Select * from Coupon_AvailableSeat; 
GO
 -----

 