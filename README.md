# Dev Ops - Amazon Web Service - Terraform

### Steps

1. Set aws access on enviroment.
2. Set a EC2 Instance with terraform.
3. Modify EC2 Instance with terraform.
4. Delete EC2 Instance with terraform.
5. Set aws VPC.
6. Set aws SUB_NET.
7. Reference id of vpc on SUB_NET.

### Project Steps

1. Create a VPC.
2. Create a Internet Gateway.
3. Create a custom route table.
4. Create a Subnet.
5. Associate Subnet with Route table.
6. Create a security group to allow port 22,80, 443.
7. Create a network interface with an ip in the subnet that was create in step 4.
8. Assign an elastic IP to the network interface created in step 7.
9. Create Ubuntu Server and install/enabled apache2.
10. Run with 'terraform apply -auto-approval'.

###### See the same course as us:https://www.youtube.com/watch?v=SLB_c_ayRMo
