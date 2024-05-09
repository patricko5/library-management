
-- Question 1: 
SHOW TABLES FROM library;
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_KEY 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'library';

-- Question 2: 
SELECT b.*, m.Title, m.MediaType, m.PubDate, m.IsAvailable
FROM book AS b
JOIN media AS m ON b.MediaID = m.MediaID;

-- Question 3: 
SELECT u.FirstName, u.LastName, r.*
FROM reader AS r
JOIN user AS u ON r.UserID = u.LibraryID
ORDER BY u.LastName, u.FirstName;

-- Question 4:
-- 4.1
SELECT b.MediaID, m.Title, b.Author, b.ISBN, m.IsAvailable
FROM book AS b
JOIN media AS m ON b.MediaID = m.MediaID
WHERE m.MediaType = 'Book'
ORDER BY m.IsAvailable DESC, m.Title;

-- 4.2 
SELECT u.FirstName, u.LastName, u.Email, m.Title, h.HoldDate, h.CopyDate AS ExpectedAvailabilityDate
FROM holds AS h
JOIN media AS m ON h.MediaID = m.MediaID
JOIN user AS u ON h.LibraryID = u.LibraryID
ORDER BY h.HoldDate;

-- 4.3 
SELECT m.Title, m.MediaType, u.FirstName AS ReaderFirstName, u.LastName AS ReaderLastName, s.CheckoutDate, s.DueDate
FROM signouts AS s
JOIN media AS m ON s.MediaID = m.MediaID
JOIN reader AS r ON s.ReaderID = r.ReaderID
JOIN user AS u ON r.UserID = u.LibraryID
WHERE s.DueDate < CURDATE() AND NOT EXISTS (
    SELECT 1 FROM signins AS si WHERE si.MediaID = s.MediaID AND si.CopyNum = s.CopyNum AND si.SignInDate >= s.DueDate
)
ORDER BY s.DueDate;

-- Question 5:
SELECT * FROM View_MediaHolds ORDER BY HoldDate ASC;


-- Question 6:

-- Insert a new media item to trigger 'after_media_insert'
INSERT INTO media (Title, PubDate, IsAvailable, MediaType, CopyNum) VALUES
('Newest Fantasy Novel', '2024-01-01', 'Yes', 'Book', 1);

-- Update an existing media item's availability to trigger 'before_media_update'
UPDATE media SET IsAvailable = 'Yes' WHERE MediaID = 1;

-- Delete a media item to trigger 'before_media_delete'
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM media WHERE MediaID = 1;
SET FOREIGN_KEY_CHECKS = 1;


SELECT * FROM media_audit ORDER BY ActionDate DESC;