
tf_deploy() {
  NAME="$1"

  rm -rf tf
  mkdir -p tf
  cd tf

  cat > main.tf <<'TF'
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

variable "compartment_id" {}
variable "image_id" {}
variable "subnet_id" {}
variable "name" {}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_instance" "node" {
  display_name        = var.name
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  metadata = {
    ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
  }
}

output "instance_id" {
  value = oci_core_instance.node.id
}

output "public_ip" {
  value = oci_core_instance.node.public_ip
}
TF

  terraform init -input=false

  terraform apply -auto-approve \
    -var="compartment_id=$TENANCY_OCID" \
    -var="image_id=$IMAGE_ID" \
    -var="subnet_id=$SUBNET_ID" \
    -var="name=$NAME"

  echo ""
  echo "✅ INSTANCE CREATED"

  IP=$(terraform output -raw public_ip)

  echo "🌐 Public IP: $IP"
  echo "🔗 SSH:"
  echo "ssh ubuntu@$IP -i ~/.ssh/id_rsa"
}
