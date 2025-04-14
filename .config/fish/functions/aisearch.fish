function aisearch --wraps aichat
    set -lx AICHAT_PATCH_GEMINI_CHAT_COMPLETIONS '{".*":{"body":{"tools":[{"google_search":{}}]}}}'
    aichat -r search -s $argv
end
