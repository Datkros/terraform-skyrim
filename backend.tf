terraform {
    backend "local" {
        path = "./skyrim-together.tfstate"
    }
}

provider "aws" {
    region = "eu-west-1"
}
