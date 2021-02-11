resource "aws_security_group" "elastic_search_allow_ssh_node"{
    name    =   "elastic-search-ssh-rule_node"
    description =   "This SG allows ssh into the server"

    ingress {
        description =   "Allows port 22 for SSH"
        from_port   =   "22"
        to_port =   "22"
        protocol = "tcp"
        cidr_blocks =   ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elastic_search_allow_inter_communication_node"{
    name    =   "elastic_search_allow_inter_communication_node"
    description =   "This SG allows ssh into the server"

    ingress {
        description =   "Allows port 9200-9300 for inter communications"
        from_port   =   "9200"
        to_port =   "9300"
        protocol = "tcp"
         cidr_blocks =   ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elastic_search_allow_https_node"{
    name    =   "SG with https rule_node"
    description =   "This SG allows ssh into the server"

    egress {
        description =   "Allows port http for inter communications"
        from_port   =   "80"
        to_port =   "80"
        protocol = "tcp"
         cidr_blocks =   ["0.0.0.0/0"]
    }

    
    egress {
        description =   "Allows port https for inter communications"
        from_port   =   "443"
        to_port =   "443"
        protocol = "tcp"
         cidr_blocks =   ["0.0.0.0/0"]
    }
}


output "sg1" {
    value = "${aws_security_group.elastic_search_allow_https_node.id}"
}
output "sg2" {
    value = "${aws_security_group.elastic_search_allow_inter_communication_node.id}"
}
output "sg3" {
    value = "${aws_security_group.elastic_search_allow_ssh_node.id}"
}