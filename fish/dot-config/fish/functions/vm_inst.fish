function vm_inst -a name os_variant install_source
    argparse \
        --ignore-unknown \
        'm/memory=' \
        'c/cpus=' \
        'd/disk-size=' \
        'b/bridge=?' \
        s/backing-store \
        i/import \
        n/netboot \
        -- $argv
    or return

    set -l memory 2048
    set -l vcpus 2
    set -l disk_size 10
    set -l bridge_iface br0
    set -q "$_flag_memory"; and set memory $_flag_m
    set -q "$_flag_cpus"; and set vcpus $_flag_c
    set -q "$_flag_disk_size"; and set disk_size $_flag_d
    set -q "$_flag_bridge"; and not math $_flag_b &>/dev/null; or set bridge_iface $_flag_b

    set -l inst_args \
        --name $name \
        --memory $memory \
        --vcpus $vcpus \
        --os-variant $os_variant

    if set -q "$_flag_bridge"
        set inst_args $inst_args \
            --network bridge=$bridge_iface
    end

    if test -n "$_flag_import"
        set inst_args $inst_args \
            --disk $install_source \
            --import
    else if test -n "$_flag_backing_store"
        set inst_args $inst_args \
            --disk size=$disk_size,sparse=yes,backing_store=$install_source \
            --import
    else if test -n "$_flag_netboot"
        set inst_args $inst_args \
            --disk size=$disk_size,sparse=yes \
            --pxe
    else
        set inst_args $inst_args \
            --disk size=$disk_size,sparse=yes \
            --cdrom $install_source
    end

    virt-install $inst_args $argv[4..-1]
end
