resource "yandex_vpc_network" "vpc_dev" {
  name = "${var.env_name}-network"
}

# resource "yandex_vpc_subnet" "vpc_dev" {
#   name           = "${var.env_name}-${var.zone}-subnet"
#   zone           = var.zone
#   network_id     = yandex_vpc_network.vpc_dev.id
#   v4_cidr_blocks = [var.v4_cidr_blocks]
# }

resource "yandex_vpc_subnet" "vpc_dev" {
  for_each = { for subnet in var.subnets : subnet.zone => subnet }

  name           = "${var.env_name}-${each.key}-subnet"
  zone           = each.key
  network_id     = yandex_vpc_network.vpc_dev.id
  v4_cidr_blocks = [each.value.cidr]
}