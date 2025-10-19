function adr --wraps aider
    set -lx OPENAI_BASE_URL http://localhost:8080/v1
    set -lx OPENAI_API_KEY local
    aider $argv
end
