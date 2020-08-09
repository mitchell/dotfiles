function dm-env -d 'Shortcut for setting your shell env for a docker-machine'
  eval (docker-machine env $argv)
end
