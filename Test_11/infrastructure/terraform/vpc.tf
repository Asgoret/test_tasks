resource "digitalocean_vpc" "test_assignment" {
  name   = "test-assignment"
  region = var.region
}
