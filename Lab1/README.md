## Crear una instancia EC2 usando AWS CLI

### 1. Crear par de claves

```console
aws ec2 create-key-pair --key-name ec2_key --query 'KeyMaterial' --output text > ec2_key.pem
```

### 2. Crear una nueva instancia EC2

```console
aws ec2 run-instances --image-id ami-051f8a213df8bc089 --instance-type t2.micro --key-name ec2_key
```

### 3. Terminar una instancia EC2

```console
aws ec2 terminate-instances --instance-ids  [INSTANCE_ID]
```
## Habilitar SSL en NGINX

### 1. Instalar Cerbot

```console
aws ec2 run-instances --image-id ami-051f8a213df8bc089 --instance-type t2.micro --key-name ec2_key
```

### 2. Generar Certificado

```console
sudo certbot certonly -d www.3.84.249.214.sslip.io
```

### 3. Editar la configuración de Nginx (/etc/nginx/nginx.conf). Descomentar la configuración para TLS e indicar la ruta del certificado y la clave privada generados con Cerbot.

```console
# Settings for a TLS enabled server.
#
    server {
        listen       443 ssl http2;
        listen       [::]:443 ssl http2;
        server_name  _;
        root         /usr/share/nginx/html;

        ssl_certificate "/etc/letsencrypt/live/www.3.84.249.214.sslip.io/cert.pem";
        ssl_certificate_key "/etc/letsencrypt/live/www.3.84.249.214.sslip.io/privkey.pem";
        ssl_session_cache shared:SSL:1m;
        ssl_session_timeout  10m;
        ssl_ciphers PROFILE=SYSTEM;
        ssl_prefer_server_ciphers on;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
```

### 4. Arrancar Nginx