function commit -d 'Generate commit message for staged changes using LMC'
    git diff --staged | lmc --new --git-message --stdin --model qwen3.6-35b-a3b
end
