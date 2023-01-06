proxmox_url = "{{ op://clcd-2023/hypervisor/website }}"
proxmox_skip_certificate_validation = true
proxmox_username = "{{ op://clcd-2023/hypervisor/username }}"
proxmox_password = "{{ op://clcd-2023/hypervisor/password }}"
proxmox_node = "{{ op://clcd-2023/hypervisor/Title }}"

proxmox_iso_storage_name = "local"
proxmox_iso_filename = "ubuntu-22.04.1-live-server-amd64.iso"
proxmox_iso_checksum = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"


proxmox_template_name = "template_ubuntu_22_04"
proxmox_vm_name = "packer-ubuntu-22-04"

proxmox_vm_storage_name = "local"
#proxmox_vm_storage_type = "nfs"


proxmox_vm_network_adapters = {
    model = "virtio"
    bridge = "vmbr1"
    vlan_tag = 3142
}

proxmox_vm_disks = {
    type = "virtio"
    disk_size = "50G"
    storage_pool = "local"
    storage_pool_type = "directory"
    format = "qcow2"
}


ssh_provisioner = {
    timeout = "10m"
    username = "{{ op://clcd-2023/provisioner/username }}"
    password = "{{ op://clcd-2023/provisioner/password }}"
    sshkey = "{{ op://clcd-2023/provisioner/public key }}"
}