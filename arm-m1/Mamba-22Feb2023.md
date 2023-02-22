1. Download:
```
mkdir /Users/sakella/Mambaforge
cd    /Users/sakella/Mambaforge

wget https://github.com/conda-forge/miniforge/releases/download/22.11.1-4/Mambaforge-22.11.1-4-MacOSX-x86_64.sh
```

2. Install mamba:
If it exists: `~/.condarc`, move: `mv .condarc .condarc--`
before running this:
`bash Mambaforge-22.11.1-4-Linux-x86_64.sh -b -p /discover/nobackup/sakella/MambaCylc/install-22Feb2023`
move it back: `mv .condarc-- .condarc`

3. Install packages you need, for e.g.:
```
/Users/sakella/Mambaforge/install-22Feb2023/bin/mamba install xesmf xgcm
```

4. To use above install:
- Create `/Users/sakella/modulefiles/Python/Mamba/22Feb2023.lua`
- Add to .zshrc (if not already present) `module use -a /Users/sakella/modulefiles`
