-- Create a table named dummy_table
CREATE TABLE IF NOT EXISTS dummy_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    email VARCHAR(50)
);

-- Insert sample data into the table
INSERT INTO dummy_table (name, age, email) VALUES
('John Doe', 30, 'john@example.com'),
('Jane Smith', 25, 'jane@example.com'),
('Bob Johnson', 40, 'bob@example.com'),
('Alice Brown', 35, 'alice@example.com');

-- Query the table to verify data insertion
SELECT * FROM dummy_table;