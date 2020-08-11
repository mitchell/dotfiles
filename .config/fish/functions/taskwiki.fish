function taskwiki -a id
  set page (task _get $id.wiki)

  if test -n $page
    $EDITOR +VimwikiIndex "+VimwikiGoto $page"
  else
    echo 'no wiki file specified'
  end
end
