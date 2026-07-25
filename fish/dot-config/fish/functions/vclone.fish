function vclone -a source image -d 'Clones and resizes a VM image to 40G'
    virsh vol-clone $source $image default
    virsh vol-resize $image 40G default
end
