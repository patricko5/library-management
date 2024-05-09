CREATE VIEW View_MediaHolds AS
SELECT 
    m.MediaID,
    m.Title,
    m.MediaType,
    m.PubDate,
    u.LibraryID AS UserLibraryID,
    CONCAT(u.FirstName, ' ', u.LastName) AS UserName,
    u.Email,
    u.PhoneNum,
    h.HoldDate,
    h.CopyDate AS ExpectedAvailabilityDate
FROM 
    holds h
INNER JOIN media m ON h.MediaID = m.MediaID
INNER JOIN user u ON h.LibraryID = u.LibraryID;

CREATE TABLE media_audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    MediaID INT,
    ActionType VARCHAR(50),
    ActionDate DATETIME,
    Details VARCHAR(255)
);


DELIMITER //
CREATE TRIGGER after_media_insert
AFTER INSERT ON media
FOR EACH ROW
BEGIN
    INSERT INTO media_audit (MediaID, ActionType, ActionDate, Details)
    VALUES (NEW.MediaID, 'Insert', NOW(), CONCAT('Inserted new media with Title: ', NEW.Title));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_media_update
BEFORE UPDATE ON media
FOR EACH ROW
BEGIN
    IF OLD.IsAvailable <> NEW.IsAvailable THEN
        INSERT INTO media_audit (MediaID, ActionType, ActionDate, Details)
        VALUES (OLD.MediaID, 'Update', NOW(), CONCAT('Availability changed from ', OLD.IsAvailable, ' to ', NEW.IsAvailable, ' for Title: ', OLD.Title));
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_media_delete
BEFORE DELETE ON media
FOR EACH ROW
BEGIN
    INSERT INTO media_audit (MediaID, ActionType, ActionDate, Details)
    VALUES (OLD.MediaID, 'Delete', NOW(), CONCAT('Deleted media with Title: ', OLD.Title));
END;
//
DELIMITER ;