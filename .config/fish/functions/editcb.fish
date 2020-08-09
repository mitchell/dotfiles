function editcb -a ft -d 'Opens your editor to the cliboard\'s current contents.'
  set uname (uname)
  set file "._temp.$ft"

  touch $file

  switch "$uname"
      case 'Linux'
          xclip -out -selection clipboard > $file
      case 'Darwin'
          pbpaste > $file
  end

  $EDITOR $file

  switch "$uname"
      case 'Linux'
          xclip -in -selection clipboard < $file
      case 'Darwin'
          pbcopy < $file
  end

  rm $file
end
