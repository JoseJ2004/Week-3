-- Campus Equipment Checkout / MySQL 8+
CREATE DATABASE IF NOT EXISTS equipment_checkout CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE equipment_checkout;

CREATE TABLE IF NOT EXISTS student (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  birth_date DATE NOT NULL,
  eligible BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

-- Multivalued conceptual phone attribute becomes a separate relation.
CREATE TABLE IF NOT EXISTS student_phone (
  student_id INT NOT NULL,
  phone_number VARCHAR(25) NOT NULL,
  PRIMARY KEY (student_id, phone_number),
  FOREIGN KEY (student_id) REFERENCES student(student_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS category (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(80) NOT NULL UNIQUE,
  description VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS equipment (
  equipment_id INT PRIMARY KEY,
  category_id INT NOT NULL,
  equipment_name VARCHAR(100) NOT NULL,
  serial_number VARCHAR(100) NOT NULL UNIQUE,
  purchase_date DATE,
  status ENUM('available','maintenance','retired') NOT NULL DEFAULT 'available',
  FOREIGN KEY (category_id) REFERENCES category(category_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS checkout (
  checkout_id INT PRIMARY KEY,
  student_id INT NOT NULL,
  equipment_id INT NOT NULL,
  checkout_date DATE NOT NULL,
  due_date DATE NOT NULL,
  return_date DATE NULL,
  return_condition ENUM('good','damaged','needs_repair') NULL,
  -- Generated unique key disallows more than one open checkout per asset.
  active_equipment_id INT GENERATED ALWAYS AS (
    CASE WHEN return_date IS NULL THEN equipment_id ELSE NULL END
  ) STORED,
  UNIQUE KEY uq_one_active_checkout_per_equipment (active_equipment_id),
  CONSTRAINT chk_due_after_checkout CHECK (due_date >= checkout_date),
  CONSTRAINT chk_return_after_checkout CHECK (return_date IS NULL OR return_date >= checkout_date),
  CONSTRAINT chk_return_condition CHECK (
    (return_date IS NULL AND return_condition IS NULL)
    OR (return_date IS NOT NULL AND return_condition IS NOT NULL)
  ),
  FOREIGN KEY (student_id) REFERENCES student(student_id),
  FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
) ENGINE=InnoDB;

-- These triggers enforce borrower eligibility and asset administrative status.
DROP TRIGGER IF EXISTS checkout_before_insert;
DROP TRIGGER IF EXISTS checkout_before_update;
DELIMITER //
CREATE TRIGGER checkout_before_insert BEFORE INSERT ON checkout
FOR EACH ROW
BEGIN
  IF NOT EXISTS (SELECT 1 FROM student WHERE student_id = NEW.student_id AND eligible = TRUE) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student is not eligible to borrow';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM equipment WHERE equipment_id = NEW.equipment_id AND status = 'available') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Equipment unavailable for checkout';
  END IF;
END//
CREATE TRIGGER checkout_before_update BEFORE UPDATE ON checkout
FOR EACH ROW
BEGIN
  IF NEW.student_id <> OLD.student_id OR NEW.equipment_id <> OLD.equipment_id THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot reassign existing checkout';
  END IF;
END//
DELIMITER ;
