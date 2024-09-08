CREATE TABLE info(username VARCHAR(200), password VARCHAR(500), name VARCHAR(100), prof INT, street VARCHAR(100), city VARCHAR(50), phone VARCHAR(32), PRIMARY KEY(username));


CREATE TABLE plans (
    name VARCHAR(100) NOT NULL PRIMARY KEY,
    exercise VARCHAR(100),
    sets INT,
    reps INT
);

CREATE TABLE receps(username VARCHAR(200), PRIMARY KEY(username), FOREIGN KEY(username) references info(username));

CREATE TABLE trainors(username VARCHAR(200), PRIMARY KEY(username), FOREIGN KEY(username) references info(username));

CREATE TABLE members(username VARCHAR(200), plan VARCHAR(100), trainor VARCHAR(200), PRIMARY KEY(username), FOREIGN KEY(username) references info(username), FOREIGN KEY(plan) references plans(name), FOREIGN KEY(trainor) references trainors(username));

ALTER TABLE info ADD time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;--done for all tables

INSERT INTO info(username, password, name, prof, street, city, phone) VALUES('eswar_123', '$5$rounds=535000$ajR8hAzSoSF.NhEs$MaLn1dbnXq9eu2W5Ge3c1ScAS9960yLBFv3aU9zaxc0', 'Parameswar K', 1, 'Adarshnagar', 'Anantapur', 9666585361);--admin's password is eswar@259522

CREATE TABLE progress (
    username VARCHAR(200),
    date DATE,
    daily_result VARCHAR(200),
    time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (username, date),
    FOREIGN KEY (username) REFERENCES members(username)
);

INSERT INTO plans (name) VALUES
('Beginner Plan'),
('Intermediate Plan'),
('Advanced Plan');


DELIMITER //

CREATE PROCEDURE AddMember(
    IN p_username VARCHAR(200),
    IN p_password VARCHAR(500),
    IN p_name VARCHAR(100),
    IN p_prof INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(50),
    IN p_phone VARCHAR(32),
    IN p_plan VARCHAR(100),
    IN p_trainor VARCHAR(200)
)
BEGIN
    -- Insert into info table
    INSERT INTO info(username, password, name, prof, street, city, phone)
    VALUES(p_username, p_password, p_name, p_prof, p_street, p_city, p_phone);

    -- Insert into members table
    INSERT INTO members(username, plan, trainor)
    VALUES(p_username, p_plan, p_trainor);
END //


DELIMITER //

DELIMITER //

CREATE TRIGGER DeleteMemberData
AFTER DELETE ON members
FOR EACH ROW
BEGIN
    DELETE FROM info WHERE username = OLD.username;
    DELETE FROM progress WHERE username = OLD.username;
END //


DELIMITER //

CREATE TRIGGER SetProfForMemberInfo
AFTER INSERT ON members
FOR EACH ROW
BEGIN
    UPDATE info
    SET prof = 4
    WHERE username = NEW.username;
END //




