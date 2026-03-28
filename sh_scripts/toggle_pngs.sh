#!/bin/bash
# ==============================================================================
# Script: toggle_pngs.sh
# Description: HPC image viewer. Loads PNGs into a single X11 window.
# Options:
#   -d, --delay SEC   Set auto-play delay in seconds (default: 1)
#   -l, --list        Accept a list/glob of files instead of a directory
# ==============================================================================

# --- 1. Defaults ---
use_list=false
delay_sec=0.01 #1

# --- 2. Parse Arguments ---
while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--list)
            use_list=true
            shift
            ;;
        -d|--delay)
            delay_sec="$2"
            shift 2
            ;;
        -*)
            echo "Unknown option: $1"
            echo "Usage: $0 [-d seconds] [-l] /path/to/target"
            exit 1
            ;;
        *)
            # Stop parsing flags; the rest of the arguments are our targets
            break
            ;;
    esac
done

# If no targets are provided after parsing flags
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-d seconds] [-l] /path/to/target"
    exit 1
fi

# --- 3. Gather Files ---
if [ "$use_list" = true ]; then
    # List mode: The shell already expanded the *.png for us, 
    # so we just grab everything left in the arguments list ($@)
    png_files=("$@")
else
    # Directory mode (Default)
    target_dir="$1"
    if [ ! -d "$target_dir" ]; then
        echo "Error: Directory '$target_dir' not found."
        exit -1
    fi
    
    shopt -s nullglob
    png_files=("${target_dir}"/*.png)
    shopt -u nullglob
fi

# --- 4. Evaluate Count & Validate ---
n=${#png_files[@]}

if [ "$n" -eq 0 ]; then
    echo "Error: 0 files found."
    exit -1
fi

# Quick check to ensure the first item in the list is actually a file
# (Prevents crashing if you pass a bad glob like 'fake*.png')
if [ ! -f "${png_files[0]}" ]; then
    echo "Error: '${png_files[0]}' is not a valid file."
    exit -1
fi

# --- 5. Check & Load Module ---
if ! module is-loaded imagemagick &> /dev/null; then
    echo "ImageMagick not loaded. Loading imagemagick..."
    module load imagemagick
fi

# --- 6. Execution ---
delay_ticks=$(awk -v d="$delay_sec" 'BEGIN { printf "%.0f", d * 100 }')

echo "Found $n files. Launching viewer..."
echo "Auto-play delay set to: $delay_sec second(s)."
echo "------------------------------------------------"
echo "Controls: [Spacebar] = Pause/Resume | [q] = Quit"
echo "------------------------------------------------"

display -delay "$delay_ticks" "${png_files[@]}"
