# Desplegar Wordpress en una instancia Amazon EC2 con Amazon RDS

### 1. Instalar Apache Web Server + PHP

#### 1. Conéctese a la instancia

#### 2. Para asegurarse de que todos los paquetes de software están actualizados, realice una actualización rápida del software en la instancia.

```console
sudo dnf update -y
```

#### 3. Instale las versiones más recientes del servidor web Apache y de los paquetes PHP para el AL2023.

```console
sudo dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
```

#### 4. Instale los paquetes de software de MariaDB. Utilice el comando dnf install para instalar varios paquetes de software y todas las dependencias relacionadas al mismo tiempo.

```console
sudo dnf install mariadb105-server
```

#### 5. Inicie el servidor web Apache.

```console
sudo systemctl start httpd
```

#### 6. Utilice el comando systemctl para configurar el servidor web Apache de forma que se inicie cada vez que arranque el sistema.

```console
sudo systemctl enable httpd
```

#### 7. Añada el usuario (en este caso, el usuario ec2-user) al grupo apache.

```console
sudo usermod -a -G apache ec2-user
```

#### 8. Cerrar sesión y volver a conectar

#### 9. Cambie la propiedad de grupo de /var/www y su contenido al grupo apache.

```console
sudo chown -R ec2-user:apache /var/www
```
#### 10. Para agregar permisos de escritura de grupo y establecer el ID de grupo en futuros subdirectorios, cambie los permisos del directorio /var/www y sus subdirectorios.

```console
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
```

#### 11. Para agregar permisos de escritura de grupo, cambie recursivamente los permisos de archivo de /var/www y sus subdirectorios:

```console
find /var/www -type f -exec sudo chmod 0664 {} \;
```

### 2. Descargar y configurar Wordpress

#### 1. Descargar Wordpress

```console
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
```

#### 2. Copiar a la carpeta pública de Apache Web Server

```console
cd wordpress
cp -R * /var/www/html/
```

### 3. Crear una base de datos MySQL en RDS

### 4. Configurar Wordpress desde el navegador web.

### 5. (Opcional) [Habilitar SSL en Apache Web Server](Enable_SSL.md#habilitar-ssl)