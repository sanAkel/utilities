# What's here?
  Scripts for quick visualization of image files on HPC environments over X11.

# Brief description:

| File name | Brief description |
| :--       | --: |
| `toggle_pngs.sh` | Instantly toggle through a directory or list of PNGs in a single X11 window. Includes auto-play functionality. |
| `montage_display.sh` | Stitches multiple PNGs into a single grid (montage) and displays it. Supports high-res concatenation and custom column sizing. |

# Example usage:

- `./toggle_pngs.sh -d 0.01 -l /path/to/plots/ssh*.png`
- `./montage_display.sh -c 4 -H -l /path/to/plots/ssh*.png`


- Note: Both scripts require ImageMagick. They will attempt to `module load imagemagick` automatically if it is not already in your environment.
