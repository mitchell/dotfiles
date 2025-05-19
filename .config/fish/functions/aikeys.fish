function aikeys -d 'Set AI API keys' -a service
    switch $service
        case gemini
            echo "set -lx GEMINI_API_KEY (kp Keys/google-aistudio-key -a Password)"
        case openai
            echo "set -lx OPENAI_API_KEY (kp Keys/openai-general -a Password)"
        case anthro
            echo "set -lx ANTHROPIC_API_KEY (kp Keys/anthropic-bespin-nvim -a Password)"
    end
end
