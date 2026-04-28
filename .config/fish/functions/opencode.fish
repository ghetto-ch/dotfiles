function opencode
    set -l default_port 4096

    # Check if --port is already specified
    if not string match -q -- '*--port*' $argv
        and not string match -q -- '*-p*' $argv
        set argv --port $default_port $argv
    end

    command opencode $argv
end
