function configure_fish
    # Determine OS
    set uname (uname)

    # Begin profile init
    # (These functions are defined in the functions/ directory.)
    define_global_variables
    import_sources $uname
    define_aliases $uname
    zoxide init fish | source
end

configure_fish
