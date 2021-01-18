function vm_inst -a name os_variant install_source
    argparse \
        'm/memory=' \
        'c/cpus=' \
        'd/disk-size=' \
        'b/bridge=' \
        'i/import' \
        -- $argv

    set -l memory '4096'
    set -l vcpus '2'
    set -l disk_size '40'
    set -l bridge_iface 'br0'

    if test -n "$_flag_m"
        set memory $_flag_m
    end

    if test -n "$_flag_c"
        set vcpus $_flag_c
    end

    if test -n "$_flag_d"
        set disk_size $_flag_d
    end

    if test -n "$_flag_b"
        set bridge_iface $_flag_b
    end

    set -l inst_args \
        --name $name \
        --memory $memory \
        --vcpus $vcpus \
        --os-variant $os_variant \
        --network bridge=$bridge_iface \

    if test -n "$_flag_i"
        set inst_args $inst_args \
            --disk $install_source \
            --import
    else
        set inst_args $inst_args \
            --disk size=$disk_size,sparse=yes \
            --cdrom $install_source
    end

    virt-install $inst_args
end
