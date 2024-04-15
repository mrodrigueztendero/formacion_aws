## Configurar servidor LAMP

### 1. Conéctese a la instancia

### 2. Para asegurarse de que todos los paquetes de software están actualizados, realice una actualización rápida del software en la instancia.

```console
sudo dnf update -y
```

### 3. Instale las versiones más recientes del servidor web Apache y de los paquetes PHP para el AL2023.

```console
sudo dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
```

### 4. Instale los paquetes de software de MariaDB. Utilice el comando dnf install para instalar varios paquetes de software y todas las dependencias relacionadas al mismo tiempo.

```console
sudo dnf install mariadb105-server
```

### 5. Inicie el servidor web Apache.

```console
sudo systemctl start httpd
```

### 6. Utilice el comando systemctl para configurar el servidor web Apache de forma que se inicie cada vez que arranque el sistema.

```console
sudo systemctl enable httpd
```

### 7. Configuración de permisos

#### 7.1 Añada el usuario (en este caso, el usuario ec2-user) al grupo apache.

```console
sudo usermod -a -G apache ec2-user
```

#### 7.2 Cerrar sesión y volver a conectar

#### 7.3 Cambie la propiedad de grupo de /var/www y su contenido al grupo apache.

```console
sudo chown -R ec2-user:apache /var/www
```
#### 7.4 Para agregar permisos de escritura de grupo y establecer el ID de grupo en futuros subdirectorios, cambie los permisos del directorio /var/www y sus subdirectorios.

```console
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
```

#### 7.5 Para agregar permisos de escritura de grupo, cambie recursivamente los permisos de archivo de /var/www y sus subdirectorios:

```console
find /var/www -type f -exec sudo chmod 0664 {} \;
```

## Probar servidor LAMP

### 1. Cree un archivo PHP en la raíz de documentos de Apache.

```console
echo '<center><h1>Welcome to Server: <?php echo $_SERVER["SERVER_ADDR"]; ?></h1><br><br></center>' > /var/www/html/index.php
```

### 2. En un navegador web, escriba la URL del archivo que acaba de crear. Esta URL es la dirección DNS pública de la instancia seguida de una barra diagonal y el nombre del archivo.


## Documentación Oficial

[Instalar un servidor LAMP en AL2023](https://docs.aws.amazon.com/es_es/linux/al2023/ug/ec2-lamp-amazon-linux-2023.html)


## Configurar Base de Datos MariaDB en un EBS para datos.

### 1. Conéctese a la instancia

### 2. Para asegurarse de que todos los paquetes de software están actualizados, realice una actualización rápida del software en la instancia.

```console
sudo dnf update -y
```

### 3. Instalar MariaDB

```console
sudo dnf install mariadb105-server
```

### 4. Utilizar el comando lsblk para ver los dispositivos de disco disponibles y sus puntos de montaje (si procede) para  determinar el nombre de dispositivo correcto que debe emplear.

```console
sudo lsblk -f
```

### 5. Crear un sistema de archivos en el volumen adicional.

```console
sudo mkfs -t xfs /dev/xvdb
```

### 6. Comprobar que el volumen tiene un sistema de ficheros xfs.

```console
sudo lsblk -f
```

### 7. Editar el fichero /etc/fstab para montar el volumen /dev/xvdb en la carpeta de datos de MariaDB /var/lib/mysql/

```console
nano /etc/fstab
```


```console
UUID=aebf131c-6957-451e-8d34-ec978d9581ae /var/lib/mysql xfs  defaults,nofail  0  2
```

### 8. Reiniciar la instancia

### 9. Asignar propietario de la carpeta /var/lib/mysql

```console
sudo chown mysql:root mysql
```

### 10. Iniciar el servicio de MariaDB

```console
sudo systemctl start mariadb 
```

### 11. Utilice el comando systemctl para configurar el servicio de MariaDB de forma que se inicie cada vez que arranque el sistema.

```console
sudo systemctl enable mariadb
```

### 9. Iniciar sesión en el servidor de base de datos como el usuario root.

```console
sudo mysql -u root -p
```

### 10. Cree un usuario y una contraseña para la base de datos MySQL

```console
CREATE USER 'user'@'%' IDENTIFIED BY 'mypassword';
```

### 11. Cree una base de datos

```console
CREATE DATABASE `my-database`;
```

### 12. Otorgue todos los privilegios de su base de datos al usuario que creó anteriormente.

```console
GRANT ALL PRIVILEGES ON `my-database`.* TO "user"@"%";
```

### 13. Salir del cliente de Mariadb

### 14. Editar el fichero de configuración /etc/my.cnf.d/mariadb-server.cnf

```console
sudo nano /etc/my.cnf.d/mariadb-server.cnf
```

Descomentar la línea: bind-address=0.0.0.0

### 15. Reiniciar el servicio de MariaDB

```console
sudo systemctl restart mariadb 
```

### 16. Configurar el Grupo de Securidad de la instancia para permitir conectar en el puerto 3306 para nuestra IP.

### 17. Conectar a la base de datos desde nuestro equipo utilizando cualquier cliente.

### 18. Lanzar el script [mariadb_dummy_data.sql](mariadb_dummy_data.sql) para crear una tabla de usuarios con datos de prueba.