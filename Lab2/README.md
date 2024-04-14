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