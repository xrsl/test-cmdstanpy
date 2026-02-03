set unstable := true

# Default recipe (shows help)
default:
    @just --list --unsorted

install-cmdstan:
    @uv run python -c "import cmdstanpy; cmdstanpy.cmdstan_path()" 2>/dev/null \
        && printf "\033[33m⚡ CmdStan already installed, skipping.\033[0m\n" \
        || uv run python -m cmdstanpy.install_cmdstan

run-mvp:
    @uv run python mvp.py
    @printf "\033[32m✅ MVP ran successfully!\033[0m\n"

# Format code with ruff
fmt:
    @uvx ruff format .
    @printf "\033[36m🎨 Code formatted!\033[0m\n"

# Lint code with ruff
lint:
    @uvx ruff check .
    @printf "\033[33m🔍 Lint passed!\033[0m\n"

# Remove build artifacts and caches
clean:
    @rm -rf .venv __pycache__ .ruff_cache
    @printf "\033[31m🗑️  Cleaned up!\033[0m\n"

# Local ci
ci: fmt lint run-mvp
    @just --fmt
