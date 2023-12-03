#!/bin/zsh

read_doc() {
    local doc="$1"
    local awk_expr="$2"

    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    doc_path="$doc"

    if [ -f "$doc_path" ]; then
        if [ -z "$awk_expr" ]; then
            cat "$doc_path"
        else
            cat "$doc_path" | awk "$awk_expr"
        fi
    else
        echo "Error: documentation not found at $doc_path"
    fi
}

