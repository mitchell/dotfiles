function back -d 'A shortcut for backgrounding a command using nohup and named log file'
  set log_name (string join _ $argv)

  echo "log file: $log_name.out"
  nohup $argv > "$log_name.out" &
end
