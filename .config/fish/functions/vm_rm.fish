function vm_rm -a domain -d 'Destroy, undefine, and delete the volume of a domain'
    virsh destroy $domain
    virsh undefine $domain
    virsh vol-delete /home/m/libvirt/$domain.qcow2
end
