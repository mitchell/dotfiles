function configure_fish
    # Determine OS
    set uname (uname)

    # Set umask
    umask 077

    # Begin profile init
    # (These functions are defined in the functions/ directory.)
    define_global_variables
    import_sources $uname
    define_aliases $uname
    ssh_agent_startup
end

configure_fish
