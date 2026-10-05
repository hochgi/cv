#!/usr/bin/env bash
# Build the CV, one PDF per company, each with its own utm_content tag
# so Google Analytics on the blog shows which copy a visitor came from.
#
#   ./build.sh                 -> out/Gilad_Hoch_CV.pdf          (utm_content=unmodified)
#   ./build.sh acme globex     -> out/acme/Gilad_Hoch_CV.pdf, out/globex/Gilad_Hoch_CV.pdf
#
# Every copy keeps the same file name, so the recipient can't tell it is tagged.
set -euo pipefail
cd "$(dirname "$0")"
export PATH="/Library/TeX/texbin:$PATH"

build() {
    local campaign="$1" dir="$2"
    if [[ ! "$campaign" =~ ^[A-Za-z0-9_-]+$ ]]; then
        echo "invalid campaign name '$campaign' (use letters, digits, - and _)" >&2
        exit 1
    fi
    mkdir -p "$dir"
    for _ in 1 2; do # second pass resolves references
        if ! pdflatex -interaction=nonstopmode -halt-on-error \
                -output-directory="$dir" -jobname=Gilad_Hoch_CV \
                "\def\uniquecampaign{$campaign}\input{main}" > /dev/null; then
            grep -A5 '^!' "$dir/Gilad_Hoch_CV.log" >&2 || tail -20 "$dir/Gilad_Hoch_CV.log" >&2
            exit 1
        fi
    done
    echo "$dir/Gilad_Hoch_CV.pdf  (utm_content=$campaign)"
}

if [[ $# -eq 0 ]]; then
    build unmodified out
else
    for campaign in "$@"; do
        build "$campaign" "out/$campaign"
    done
fi
