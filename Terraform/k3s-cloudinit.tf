resource "proxmox_vm_qemu" "cloudinit-k3s-master" {
  target_node = "apollo"
  desc = "Cloudinit Ubuntu"
  count = 3
  onboot = true

  clone = "ubuntu-cloud"

  agent = 0

  balloon = 1

  os_type = "cloud-init"
  cores = 2
  sockets = 1
  numa = false
  vcpus = 0
  cpu_type = "host"
  memory = 4096
  name = "k3s-master-0${count.index + 1}"

  scsihw   = "virtio-scsi-single" 
  bootdisk = "scsi0"

  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "m2_storage"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "m2_storage"
          size = 20
        }
      }
    }
  }

  ipconfig0 = "ip=192.168.1.${201 + count.index}/24,gw=192.168.1.1"

  network {
    id = 0
    model = "virtio"
    bridge = "vmbr0"
  }

  ciuser = "zlaya"
  sshkeys = <<EOF
${var.ssh_key}
${var.promox_ssh_key}
EOF
}

resource "proxmox_vm_qemu" "cloudinit-k3s-worker" {
  target_node = "apollo"
  desc = "Cloudinit Ubuntu"
  count = 3
  onboot = true

  clone = "ubuntu-cloud"

  agent = 0

  balloon = 1

  os_type = "cloud-init"
  cores = 2
  sockets = 1
  numa = false
  vcpus = 0
  cpu_type = "host"
  memory = 4096
  name = "k3s-worker-0${count.index + 1}"

  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"

  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "m2_storage"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "m2_storage"
          size = 250
        }
      }
    }
  }

  ipconfig0 = "ip=192.168.1.${210 + count.index}/24,gw=192.168.1.1"

  network {
    id = 0
    model = "virtio"
    bridge = "vmbr0"
  }

  ciuser = "zlaya"
  sshkeys = <<EOF
${var.ssh_key}
${var.promox_ssh_key}
EOF
}