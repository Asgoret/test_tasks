data "digitalocean_ssh_key" "web_ssh" {
  name       = var.ssh_token
}

resource "digitalocean_droplet" "web" {
    region  = var.region
    image   = var.web_image
    size    = var.web_size
    count   = var.web_count
    name    = format("web-%02d",count.index + 1)
    monitoring = true
    vpc_uuid = digitalocean_vpc.test_assignment.id
    ssh_keys = [data.digitalocean_ssh_key.web_ssh.id]
}