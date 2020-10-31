##!/usr/bin/env fish
# Uncomment this line and the last 2 lines of this file to enable running it like `./swim.fish`.
#
# This swim.fish script serves as a central place to store frequently run commands for this project.
# Replace Commands section with your own command functions.
# Source: https://github.com/mitchell/swim.fish

# Configuration

set -g cmd_func_prefix 'swim' # Set the function prefix for defining tasks
set -g fish_files \
    ./install_arch \
    ./provision_linux \
    ./sync \
    ./upgrade_debian \
    ./**.fish \
    ./.**.fish

# Commands

function swim_lint -d 'Lint fish scripts'
    fish --no-execute $fish_files
end

function swim_format -d 'Format fish scripts'
    fish_indent --write $fish_files
end

function swim_sync -d 'Run the sync script'
    ./sync $argv
end

function swim_install_arch -d 'Run the install_arch script'
    ./install_arch $argv
end

function swim_upgrade_debi -d 'Run the debian_upgrade script'
    ./upgrade_debian $argv
end

function swim_provision -d 'Run the provision_linux script with the specified distro'
    argparse 'd/distro=' -- $argv

    if test -n "$_flag_d"
        set -g distro $_flag_d
    end

    ./provision_linux $argv[2..-1]
end

#curl -fsS https://raw.githubusercontent.com/mitchell/swim.fish/master/importable_sw.fish | source
#run_swim_command 'swim' $argv
