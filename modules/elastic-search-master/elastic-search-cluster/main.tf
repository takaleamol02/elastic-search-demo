resource "aws_instance" "elastic_search_node"{
    instance_type   = "t2.micro"
    ami             = "ami-096fda3c22c1c990a"
    vpc_security_group_ids = ["${var.sg1}", "${var.sg2}", "${var.sg3}"]
    key_name    = "new_private_key"

    user_data = <<-EOF
		#! /bin/bash
        sudo yum install java-1.8.0 -y
        sudo yum remove java-1.7.0-openjdk 
        sudo rpm -i https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.3/elasticsearch-2.3.3.rpm
        sudo chkconfig --add elasticsearch
        echo "-Xms2g" >> /etc/elasticsearch/jvm.options
        echo "-Xmx2g" >> /etc/elasticsearch/jvm.options
        echo "node.master: false" >> /etc/elasticsearch/elashticsearch.yml
        echo "node.data: true" >> /etc/elasticsearch/elashticsearch.yml
        instance-ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
        echo "network.host:" [$instance-ip] >> /etc/elasticsearch/elashticsearch.yml
        sudo service elasticsearch start
	EOF

    tags={
        Name       = "elastic-search-node-${var.instance_count}"
    }

}


output "instance_ip" {
    value = aws_instance.elastic_search_node.private_ip
}

# output "instance_ip2" {
#     value = aws_instance.elastic_search_node-2.private_ip
# }

