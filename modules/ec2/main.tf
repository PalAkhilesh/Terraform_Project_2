resource "aws_instance" "POC_USECASE2_EC2_INSTANCE" {
  ami           = var.POC_USECASE2_INSTANCE_AMI_ID  # Replace with your desired AMI ID
  instance_type = var.POC_USECASE2_EC2_INSTANCE_TYPE
  key_name      = aws_key_pair.generated_key.key_name # Replace with your key pair name
 
  depends_on = [aws_key_pair.generated_key]
  vpc_security_group_ids = [var.POC_USECASE2_vpc_security_group_ids]
 
  user_data = <<-EOF
                #!/bin/bash
                apt update
                apt install -y mysql-server
                systemctl start mysql
                sed -i '/bind-address/c\bind-address = 0.0.0.0' /etc/mysql/mysql.conf.d/mysqld.cnf
                systemctl restart mysql
                mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'Admin#123';"
                mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
                mysql -e "FLUSH PRIVILEGES;"
                mysql_secure_installation <<EOFINPUT
                y
                1  
                y
                n
                n
                y
                y
                EOFINPUT
                systemctl restart mysql
                mysql -u root -e "CREATE DATABASE customer_db;"
                EOF
 
  tags = var.common_tags
}
 
resource "tls_private_key" "terrafrom_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
 
resource "aws_key_pair" "generated_key" {
  # Name of key : Write the custom name of your key
  key_name   = var.POC_USECASE2_key_name
  # Public Key: The public will be generated using the reference of tls_private_key.terrafrom_generated_private_key
  public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh
  # Store private key :  Generate and save private key(aws_keys_pairs.pem) in current directory
  provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.terrafrom_generated_private_key.private_key_pem}' > awsPOC_USECASE2_618579_key_pair.pem
      chmod 400 awsPOC_USECASE2_618579_key_pair.pem
    EOT
  }
}