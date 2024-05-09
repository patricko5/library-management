
-- Now perform the INSERT operations in the correct order

-- Insert into user first
INSERT INTO user (LibraryID, FirstName, LastName, Email, BirthDate, PhoneNum, StreetAddress, City, PostalCode, Province) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1980-05-15', '555-0101', '123 Maple Street', 'Springfield', '12345', 'StateA'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1985-07-22', '555-0202', '456 Oak Road', 'Centerville', '23456', 'StateB'),
(3, 'Jim', 'Beam', 'jim.beam@example.com', '1990-03-30', '555-0303', '789 Pine Avenue', 'Laketown', '34567', 'StateC'),
(4, 'Jill', 'Valentine', 'jill.valentine@example.com', '1992-11-19', '555-0404', '101 Elm Street', 'Raccoon City', '45678', 'StateD'),
(5, 'Chris', 'Redfield', 'chris.redfield@example.com', '1987-06-29', '555-0505', '202 Birch Lane', 'Raccoon City', '45678', 'StateD'),
(6, 'Leon', 'Kennedy', 'leon.kennedy@example.com', '1993-08-10', '555-0606', '303 Cedar Place', 'Raccoon City', '45678', 'StateD'),
(7, 'Claire', 'Redfield', 'claire.redfield@example.com', '1994-04-11', '555-0707', '404 Spruce Circle', 'Raccoon City', '45678', 'StateD'),
(8, 'Ada', 'Wong', 'ada.wong@example.com', '1989-02-14', '555-0808', '505 Walnut Street', 'Metro City', '56789', 'StateE'),
(9, 'Barry', 'Burton', 'barry.burton@example.com', '1976-09-23', '555-0909', '606 Hickory Street', 'New Town', '67890', 'StateF'),
(10, 'Rebecca', 'Chambers', 'rebecca.chambers@example.com', '1995-12-24', '555-1010', '707 Aspen Court', 'Old Town', '78901', 'StateG');

-- Insert into media
INSERT INTO media (Title, PubDate, IsAvailable, MediaType, CopyNum) VALUES
('The Great Gatsby', '2020-01-01', 'No', 'Book', 1), -- Signed out
('Inception Script', '2020-02-01', 'Yes', 'Video', 1), -- Available
('National Geographic July', '2020-03-01', 'No', 'Magazine', 1), -- Signed out
('1984', '2020-04-01', 'Yes', 'Book', 1), -- Available
('The Matrix', '2020-05-01', 'No', 'Video', 1), -- Signed out
('Science Magazine', '2020-06-01', 'Yes', 'Magazine', 1), -- Available
('Pride and Prejudice', '2020-07-01', 'No', 'Book', 1), -- Signed out
('The Dark Knight Rises', '2020-08-01', 'Yes', 'Video', 1), -- Available
('Time Magazine', '2020-09-01', 'No', 'Magazine', 1), -- Signed out
('To Kill a Mockingbird', '2020-10-01', 'Yes', 'Book', 1); -- Available

-- Insert into book
INSERT INTO book (MediaID, Author, ISBN) VALUES
(1, 'F. Scott Fitzgerald', 'ISBN12345GATSBY'), -- The Great Gatsby
(4, 'George Orwell', 'ISBN123451984'), -- 1984
(7, 'Jane Austen', 'ISBN12345PRIDE'), -- Pride and Prejudice
(10, 'Harper Lee', 'ISBN12345MOCKINGBIRD'); -- To Kill a Mockingbird


-- Insert into magazine
INSERT INTO magazine (MediaID, ISSN) VALUES
(3, 'ISSN12345NATGEO'), -- National Geographic July
(9, 'ISSN12345TIME'); -- Time Magazine

-- Insert into video
INSERT INTO video (MediaID, Duration) VALUES
(2, 148), -- Inception Script, assuming duration is 148 minutes
(5, 136), -- The Matrix, assuming duration is 136 minutes
(8, 164); -- The Dark Knight Rises, assuming duration is 164 minutes

-- Insert into reader
INSERT INTO reader (ReaderID, UserID, Checkouts, Holds) VALUES
(1, 1, 1, 0), -- Checked out 'The Great Gatsby'
(3, 3, 1, 0), -- Checked out 'National Geographic July'
(5, 5, 1, 0), -- Checked out 'The Matrix'
(7, 7, 1, 1), -- Checked out 'Pride and Prejudice' and holds 'Inception Script'
(9, 9, 1, 1), -- Checked out 'Time Magazine'and holds '1984'
(6, 6, 0, 1), -- Holds 'Inception Script'
(8, 8, 0, 1), -- Holds '1984'
(2, 2, 0, 0), -- No checkouts or holds 
(4, 4, 0, 0), -- No checkouts or holds 
(10, 10, 0, 0); -- No checkouts or holds 


-- Insert into librarian
INSERT INTO librarian (LibrarianID, UserID, Schedule, Tasks) VALUES
(1, 1, '9-5', 'Checkouts'),
(2, 2, '10-6', 'Inventory Management'),
(3, 3, '11-7', 'Customer Service'),
(4, 4, '8-4', 'Book Restoration'),
(5, 5, '9-5', 'Event Planning'),
(6, 6, '10-6', 'Digital Resources'),
(7, 7, '11-7', 'Acquisitions'),
(8, 8, '8-4', 'Cataloging'),
(9, 9, '9-5', 'Youth Services'),
(10, 10, '10-6', 'Community Outreach');

-- Insert into holds for Inception Script and 1984
INSERT INTO holds (MediaID, LibraryID, HoldDate, CopyDate) VALUES
(2, 6, '2023-03-01', '2023-03-15'), -- User with LibraryID '6' places a hold for 'Inception Script'
(2, 7, '2023-03-02', '2023-03-22'), -- User with LibraryID '7' places a hold for 'Inception Script'
(4, 8, '2023-03-03', '2023-03-17'), -- User with LibraryID '8' places a hold for '1984'
(4, 9, '2023-03-04', '2023-03-24'); -- User with LibraryID '9' places a hold for '1984'

-- Table for all checkouts
-- Insert into signouts for items marked as 'No' in isAvailable, indicating they are currently signed out.
INSERT INTO signouts (MediaID, CopyNum, ReaderID, CheckoutDate, DueDate) VALUES
(1, 1, 1, '2023-01-01', '2023-01-15'), -- The Great Gatsby
(3, 1, 3, '2023-01-03', '2023-01-17'), -- National Geographic July
(5, 1, 5, '2023-01-05', '2023-01-19'), -- The Matrix
(7, 1, 7, '2023-01-07', '2023-01-21'), -- Pride and Prejudice
(9, 1, 9, '2023-01-09', '2023-01-23'); -- Time Magazine


-- Insert past signouts for items - that are marked as 'Yes' in isAvailable.
INSERT INTO signouts (MediaID, CopyNum, ReaderID, CheckoutDate, DueDate) VALUES
(2, 1, 2, '2022-12-01', '2022-12-15'), -- Inception Script
(4, 1, 4, '2022-12-02', '2022-12-16'), -- 1984
(6, 1, 6, '2022-12-03', '2022-12-17'), -- Science Magazine
(8, 1, 8, '2022-12-04', '2022-12-18'), -- The Dark Knight Rises
(10, 1, 10, '2022-12-05', '2022-12-19'); -- To Kill a Mockingbird

-- Insert matching signins for the returned items - that are marked as 'Yes' in isAvailable.
INSERT INTO signins (LibrarianID, MediaID, CopyNum, SignInDate) VALUES
(2, 2, 1, '2022-12-15'), -- Corresponds to Inception Script
(4, 4, 1, '2022-12-16'), -- Corresponds to 1984
(6, 6, 1, '2022-12-17'), -- Corresponds to Science Magazine
(8, 8, 1, '2022-12-18'), -- Corresponds to The Dark Knight Rises
(10, 10, 1, '2022-12-19'); -- Corresponds to To Kill a Mockingbird