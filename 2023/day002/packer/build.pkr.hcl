build {
    name = "proxmox-ubuntu-22-04"
    
    sources = ["source.proxmox-iso.homelab-ubuntu-22-04"]

    provisioner "shell" {
        execute_command = "sudo -S -E bash -c '{{ .Vars }} {{ .Path }}'"
        environment_vars = [
            "PROVISIONER_SCRIPT_REPOSITORY_URL=${var.template_script_repository_url}",
            "PROVISIONER_SCRIPT_REPOSITORY_NAME=${var.template_script_repository_name}",
            "PROVISIONER_USERNAME=${var.ssh_provisioner.username}",
        ]
        scripts = [
            "../scripts/template.sh",
            "../scripts/remove_provisioner_user.sh",
        ]
    }
}




source "proxmox-iso" "homelab-ubuntu-22-04" {
    # PROXMOX CONNECTION DETAILS
    proxmox_url = "${var.proxmox_url}/api2/json"
    insecure_skip_tls_verify = var.proxmox_skip_certificate_validation
    username = "${var.proxmox_username}@pam"
    password = var.proxmox_password
    node = lower(var.proxmox_node)

    # INSTALLER ISO
    iso_file = "${var.proxmox_iso_storage_name}:iso/${var.proxmox_iso_filename}"
    iso_checksum = var.proxmox_iso_checksum
    unmount_iso = var.proxmox_unmount_iso

    # VM DETAILS
    vm_id = var.proxmox_vm_id
    vm_name = var.proxmox_vm_name

    # CLOUD-INIT
    cloud_init = true
    cloud_init_storage_pool = var.proxmox_vm_storage_name

    #http_directory = var.proxmox_cloudinit_path
    http_content = {
        "/meta-data" = file("cloud-init/meta-data")
        "/user-data" = templatefile("cloud-init/user-data", { "provisioner_username" = var.ssh_provisioner.username, "provisioner_password" = bcrypt(var.ssh_provisioner.password, 10), "provisioner_sshkey" = var.ssh_provisioner.sshkey})
    }

    boot_wait = "5s"
    boot_command = [
        "c",
        "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/' <enter>",
        "initrd /casper/<wait2s>initrd<enter>",
        "boot<wait><enter>"
    ]

    # VM CONFIGURATION
    os = var.proxmox_vm_os_type

    cpu_type = var.proxmox_vm_cpu_type
    sockets = var.proxmox_vm_cpu_sockets
    cores = var.proxmox_vm_cpu_cores

    memory = var.proxmox_vm_memory

    network_adapters {
        model = var.proxmox_vm_network_adapters.model
        bridge = var.proxmox_vm_network_adapters.bridge
        vlan_tag = var.proxmox_vm_network_adapters.vlan_tag
    }

    disks {
        type = var.proxmox_vm_disks.type
        disk_size = var.proxmox_vm_disks.disk_size
        storage_pool = var.proxmox_vm_disks.storage_pool
        storage_pool_type = var.proxmox_vm_disks.storage_pool_type
        format = var.proxmox_vm_disks.format

    }

    # SSH CONNECTION
    ssh_timeout = var.ssh_provisioner.timeout
    ssh_username = var.ssh_provisioner.username
    ssh_password = var.ssh_provisioner.password
}