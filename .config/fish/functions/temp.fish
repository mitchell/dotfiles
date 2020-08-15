# temp creates a temporary file in your editor, with the given filetype.
function temp -a ft
    set file "._temp.$ft"

    touch $file
    $EDITOR $file
    rm $file
end
