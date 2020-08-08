data aws_ami "ubuntu" {

    owners = ["099720109477"]
    filter {
        name = "image-id"
        values = ["ami-0a74b2559fb675b98"]
    }

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20200729"]
    }
}

resource aws_key_pair "skyrim_deployment_key" {
    key_name = "skyrim_deployment"
    public_key = file("keys.pub")
    tags = {
        Owner = "Datkros"
        Purpose = "Skyrim Together"
    }
}

data template_file "skyrim_deployment" {
    template = file("${path.module}/scripts/init_cloud.sh.tpl")

    vars = {
        server_password = var.server_password
    }
}

resource aws_instance "skyrim_server" {
    instance_type = "t2.micro"
    ami = data.aws_ami.ubuntu.id
    user_data = data.template_file.skyrim_deployment.rendered

    key_name = aws_key_pair.skyrim_deployment_key.key_name

    tags = {
        Owner = "Datkros"
        Purpose = "Skyrim Together"
    }
}