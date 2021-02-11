module "elastic-search-node1" {
    source = "./elastic-search-cluster"
    sg1  = "${module.common_resources.sg1}"
    sg2 = "${module.common_resources.sg2}"
    sg3 = "${module.common_resources.sg3}"
    instance_count = 1
}

module "elastic-search-node2" {
    source = "./elastic-search-cluster"
    sg1  = "${module.common_resources.sg1}"
    sg2 = "${module.common_resources.sg2}"
    sg3 = "${module.common_resources.sg3}"
    instance_count = 2
}

module "common_resources"{
    source = "../common_resources"
}