provider "google" {
 credentials = file(var.gcp_key)
 project     = var.project_name
 region      = var.region
}

resource "google_compute_firewall" "default" {
 name    = var.fw_name
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["80"]
 }
}

// Create a single instance
resource "google_compute_instance" "default" {
 name         = var.instance_name
 machine_type = var.instance_type
 zone         = var.region_zone

 boot_disk {
   initialize_params {
     image = var.image
   }

 }

// copy ssh key
 metadata = {
   ssh-keys = "root:${file(var.pub_key)}"
 }

 network_interface {
   network = "default"

   access_config {
       // external access
   }
 }

// make connection to the server
  connection {
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
    host = self.network_interface.0.access_config.0.nat_ip
  }

 // copy and execute provision script
  provisioner "file" {
    source      = "scripts/provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "file" {
    source      = "../ansible/playbooks"
    destination = "/tmp/playbooks"
  }

  provisioner "file" {
    source      = "../apache/default-vhost-example.conf"
    destination = "/tmp/default-vhost-example.conf"
  }

  provisioner "file" {
    source      = "../dockerfiles/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }

  provisioner "file" {
    source      = "../dockerfiles/wp-config.php"
    destination = "/tmp/wp-config.php"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh",
    ]
  }


}

// output ip address
  output "ip" {
   value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
  }