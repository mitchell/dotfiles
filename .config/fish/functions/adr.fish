function adr --wraps aider
    aider \
        --model gemini \
        --dark-mode \
        --completion-menu-bg-color '#1f1f28' \
        --vim $argv
end
