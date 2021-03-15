data "digitalocean_ssh_key" "db_ssh" {
  name       = var.ssh_token
}

resource "digitalocean_droplet" "db" {
    region  = var.region
    image   = var.db_image
    size    = var.db_size
    count   = var.db_count
    name    = format("db-%02d",count.index + 1)
    monitoring = true
    vpc_uuid = digitalocean_vpc.test_assignment.id
    ssh_keys = [data.digitalocean_ssh_key.db_ssh.id]
}