CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nombre, apellido, email, contraseña) VALUES
('Juan', 'Pérez', 'juan@example.com', 'contraseña123'),
('María', 'González', 'maria@example.com', 'secreto456'),
('Carlos', 'López', 'carlos@example.com', 'clave789');