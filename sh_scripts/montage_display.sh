#!/bin/bash
# ==============================================================================
# Script: montage_display.sh
# Description: Stitches PNG files into a single montage grid and displays it.
# Options:
#   -c, --cols NUM   Set number of columns (default: 2)
#   -H, --highres    Use '-mode concatenate' (original resolution, no borders)
#   -l, --list       Accept a list/glob of files instead of a directory
# ==============================================================================

# --- 1. Defaults ---
cols=2
mode=""
use_list=false

# --- 2. Parse Arguments ---
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--cols)
            cols="$2"
            shift 2
            ;;
        -H|--highres)
            mode="-mode concatenate"
            shift
            ;;
        -l|--list)
            use_list=true
            shift
            ;;
        -*)
            echo "Unknown option: $1"
            echo "Usage: $0 [-c columns] [-H] [-l] /path/to/target"
            echo "  [-H] : Enable High-Res mode (concatenates images at original size)"
            echo "  [-l] : List mode. Accepts a wildcard/list of files instead of a directory"
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# --- 3. Input Validation ---
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-c columns] [-H] [-l] /path/to/target"
    echo "  [-H] : Enable High-Res mode (concatenates images at original size)"
    echo "  [-l] : List mode. Accepts a wildcard/list of files instead of a directory"
    exit 1
fi

if [ "$use_list" = true ]; then
    png_files=("$@")
else
    target_dir="$1"
    if [ ! -d "$target_dir" ]; then
        echo "Error: Directory '$target_dir' not found."
        exit -1
    fi
    
    shopt -s nullglob
    png_files=("${target_dir}"/*.png)
    shopt -u nullglob
fi

# --- 4. Safely Count PNG Files ---
n=${#png_files[@]}

if [ "$n" -eq 0 ]; then
    echo "Error: 0 PNG files found."
    exit -1
fi

# --- 5. Check & Load Module ---
if ! module is-loaded imagemagick &> /dev/null; then
    echo "ImageMagick not loaded. Loading imagemagick..."
    module load imagemagick
fi

# --- 6. Execution ---
echo "Creating Montage ($cols columns) from $n files..."

# Pass the array of files directly to montage
montage $mode "${png_files[@]}" -tile "${cols}x" MIFF:- | display MIFF:-
