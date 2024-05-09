DROP DATABASE IF EXISTS library;
CREATE DATABASE IF NOT EXISTS library;
USE library;

DROP TABLE IF EXISTS book, magazine, video, media, signouts, holds, reader, signins, librarian, user;

CREATE TABLE user (
    LibraryID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    BirthDate DATE,
    PhoneNum VARCHAR(15),
    StreetAddress VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(10),
    Province VARCHAR(255)
);

CREATE TABLE media (
    MediaID INT AUTO_INCREMENT,
    Title VARCHAR(255),
    PubDate DATE,
    IsAvailable ENUM('Yes', 'No'),
    MediaType ENUM('Book', 'Magazine', 'Video'),
    CopyNum INT,
    PRIMARY KEY (MediaID, CopyNum)
);

CREATE TABLE book (
    MediaID INT,
    Author VARCHAR(255),
    ISBN VARCHAR(50),
    FOREIGN KEY (MediaID) REFERENCES media(MediaID)
);

CREATE TABLE magazine (
    MediaID INT,
    ISSN VARCHAR(25),
    FOREIGN KEY (MediaID) REFERENCES media(MediaID)
);

CREATE TABLE video (
    MediaID INT,
    Duration INT,
    FOREIGN KEY (MediaID) REFERENCES media(MediaID)
);

CREATE TABLE reader (
    ReaderID INT PRIMARY KEY,
    UserID INT,
    Checkouts INT,
    Holds INT,
    FOREIGN KEY (UserID) REFERENCES user(LibraryID)
);

CREATE TABLE librarian (
    LibrarianID INT PRIMARY KEY,
    UserID INT,
    Schedule VARCHAR(255),
    Tasks VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES user(LibraryID)
);

CREATE TABLE signouts (
    MediaID INT,
    CopyNum INT,
    ReaderID INT,
    CheckoutDate DATE,
    DueDate DATE,
    PRIMARY KEY (MediaID, CopyNum, ReaderID),
    FOREIGN KEY (MediaID, CopyNum) REFERENCES media(MediaID, CopyNum),
    FOREIGN KEY (ReaderID) REFERENCES reader(ReaderID)
);

CREATE TABLE holds (
    MediaID INT,
    LibraryID INT,
    HoldDate DATE,
    CopyDate DATE,
    PRIMARY KEY (MediaID, LibraryID),
    FOREIGN KEY (MediaID) REFERENCES media(MediaID),
    FOREIGN KEY (LibraryID) REFERENCES user(LibraryID)
);

CREATE TABLE signins (
    LibrarianID INT,
    MediaID INT,
    CopyNum INT,
    SignInDate DATE,
    PRIMARY KEY (LibrarianID, MediaID, CopyNum),
    FOREIGN KEY (MediaID, CopyNum) REFERENCES media(MediaID, CopyNum),
    FOREIGN KEY (LibrarianID) REFERENCES librarian(LibrarianID)
);
