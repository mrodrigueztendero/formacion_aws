# Crear una instancia EC2 usando AWS CLI

## 1. Crear par de claves

```console
aws ec2 create-key-pair --key-name ec2_key --query 'KeyMaterial' --output text > ec2_key.pem
```

## 2. Crear una nueva instancia EC2

```console
aws ec2 run-instances --image-id ami-051f8a213df8bc089 --instance-type t2.micro --key-name ec2_key
```

## 3. Terminar una instancia EC2

```console
aws ec2 terminate-instances --instance-ids  [INSTANCE_ID]
```
