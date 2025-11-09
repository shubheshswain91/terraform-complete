### Creating multiple subnets using count

![Image 01](assets/01.png)


### Creating multiple EC2 instances using count index(round robin strategy)

![Image 01](assets/02.png)


### Creating multiple EC2 instances using list giving 2 different instance type defined in terrafrom.tfvars file
```
ec2_instance_count = 0
ec2_instance_config_list = [{
  ami           = "ubuntu"
  instance_type = "t2.micro"
  },
  {
    ami           = "ubuntu"
    instance_type = "t3.micro"
  }

]
```

![Image 01](assets/03.png)

### Validating if both the instance type are same or not

![Image 01](assets/04.png)