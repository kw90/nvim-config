#!/bin/bash

# Navigate to the project's root directory
PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
PYPROJECT_FILE="${PROJECT_ROOT}/pyproject.toml"

# Check if a virtual environment is activated
if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "Virtual environment not activated. Falling back to system Python."
    PYTHON_BIN="python"
else
    echo "Using Python from the virtual environment: $VIRTUAL_ENV"
    PYTHON_BIN="$VIRTUAL_ENV/bin/python"
fi

# Check if pyproject.toml exists
if [[ -f "$PYPROJECT_FILE" ]]; then
    # Extract mypy configuration from pyproject.toml using Python from the virtual environment
    MYPY_CONFIG=$($PYTHON_BIN -c '
import toml
config = toml.load("'"${PYPROJECT_FILE}"'")
mypy_config = config.get("tool", {}).get("mypy", {})
args = []
for key, value in mypy_config.items():
    print(key, value)
    args.append(f"""--{key.replace("_", "-")}={value}""")
print(" ".join(args))
    ')

    # Check if dmypy is running and start it with the extracted config
    if ! "$VIRTUAL_ENV/bin/dmypy status" > /dev/null 2>&1; then
        echo "Starting mypy daemon with config from pyproject.toml..."
        "$VIRTUAL_ENV/bin/dmypy" start "$MYPY_CONFIG"
    else
        echo "mypy daemon already running."
    fi
else
    echo "pyproject.toml not found, starting mypy daemon with default config..."
    dmypy start
fi
