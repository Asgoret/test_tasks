data "template_file" "template_inventory" {
  template = file("infrastructure/templates/inventory")

  vars = {
    web_node_group  = join("\n", formatlist("%s ansible_host=%s", digitalocean_droplet.web.*.name, digitalocean_droplet.web.*.ipv4_address))
    db_node_group   = join("\n", formatlist("%s ansible_host=%s", digitalocean_droplet.db.*.name, digitalocean_droplet.db.*.ipv4_address))
  }
}

resource "null_resource" "local-exec" {
  triggers = {
    template_inventory = data.template_file.template_inventory.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.template_inventory.rendered}' > ansible/inventory_ata"
  }
}

output "web-name" {
  value = digitalocean_droplet.web.*.name
}

output "db-name" {
  value = digitalocean_droplet.db.*.name
}