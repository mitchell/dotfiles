function adr --wraps aider
    aider \
        --model gemini \
        --editor-model gpt-4.1-mini \
        --weak-model gpt-4.1-mini \
        --dark-mode \
        --completion-menu-bg-color '#1f1f28' \
        --vim $argv
end
