resource "aws_instance" "elastic_search_master"{

    instance_type   = "t2.micro"
    ami             = "ami-096fda3c22c1c990a"
      vpc_security_group_ids = ["${aws_security_group.elastic_search_allow_ssh_master.id}", "${aws_security_group.elastic_search_allow_inter_communication_master.id}"
                            , "${aws_security_group.elastic_search_allow_https_master.id}"]
    key_name    = "new_private_key"

    user_data = <<-EOF
		#! /bin/bash
        sudo yum install java-1.8.0 -y
        sudo yum remove java-1.7.0-openjdk 
        sudo rpm -i https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.3/elasticsearch-2.3.3.rpm
        sudo chkconfig --add elasticsearch
        echo "-Xms2g" >> /etc/elasticsearch/jvm.options
        echo "-Xmx2g" >> /etc/elasticsearch/jvm.options
        echo "node.master: true" >> /etc/elasticsearch/elashticsearch.yml
        echo "node.data: true" >> /etc/elasticsearch/elashticsearch.yml
        echo "cluster.initial_master_nodes: [ ${module.elastic-search-node1.instance_ip}, ${module.elastic-search-node2.instance_ip} ]" > /etc/elasticsearch/elashticsearch.yml
        sudo service elasticsearch start
	EOF

    tags={
        Name       = "elastic-search-master"
    }

    depends_on = [module.elastic-search-node1, module.elastic-search-node2]

}

resource "aws_security_group" "elastic_search_allow_ssh_master"{
    name    =   "elastic-search-ssh-rule_master"
    description =   "This SG allows ssh into the server"

    ingress {
        description =   "Allows port 22 for SSH"
        from_port   =   "22"
        to_port =   "22"
        protocol = "tcp"
        cidr_blocks =   ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elastic_search_allow_inter_communication_master"{
    name    =   "elastic_search_allow_inter_communication_master"
    description =   "This SG allows ssh into the server"

    ingress {
        description =   "Allows port 9200-9300 for inter communications"
        from_port   =   "9200"
        to_port =   "9300"
        protocol = "tcp"
         cidr_blocks =   ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elastic_search_allow_https_master"{
    name    =   "SG with https rule_master"
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



# data "aws_instance" "node1"{
#     filter{
#         name = "tag:Name"
#         values = ["elastic-search-node-1"]
#     }
# }

# data "aws_instance" "node2"{
#     filter{
#         name = "tag:Name"
#         values = ["elastic-search-node-2"]
#     }
# }