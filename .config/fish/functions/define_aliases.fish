function define_aliases -a uname -d 'Defines aliases for commonly used commands'
    alias cp 'rsync -aP'
    alias dm 'docker-machine'
    alias v  'nvim (fzf)'
    alias vg 'vagrant'
    alias tf 'terraform'
    alias tocb 'xclip -in -selection clipboard'
    alias fromcb 'xclip -out -selection clipboard'
    alias ssh-rm-host 'ssh-keygen -f ~/.ssh/known_hosts -R'
    alias wiki 'nvim +VimwikiIndex'

    switch "$uname"
        case 'Linux'
            alias cat      'batcat --theme ansi-dark'
            alias goland   'command goland'
            alias rider    'command rider'
            alias webstorm 'command webstorm'
        case 'Darwin'
            alias cat      'bat --theme ansi-dark'
            alias goland   'open -a Goland'
            alias rider    'open -a Rider'
            alias webstorm 'open -a Webstorm'
    end
end
