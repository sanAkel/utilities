## Follow instructions from Matt:

```
cd /discover/nobackup/sakella/MambaCylc
wget https://github.com/conda-forge/miniforge/releases/download/22.11.1-4/Mambaforge-22.11.1-4-Linux-x86_64.sh
```

If it exists: `move away my ~/.condarc` 
before running this:
`bash Mambaforge-22.11.1-4-Linux-x86_64.sh -b -p /discover/nobackup/sakella/MambaCylc/install-22Feb2023`

> If it exists: `I then moved back my ~/.condarc`


Install cylc-flow:

```
/discover/nobackup/sakella/MambaCylc/install-22Feb2023/bin/mamba install cylc-flow
```

### On discover:
- Create `~sakella/modulefiles/python/MambaCylc/22Feb2023.lua`
- Add `+x` permissions: `chmod +x ~sakella/modulefiles-SLES12/python/MambaCylc/22Feb2023.lua` <-- Needed??
- To show available modules, including above: `module use -a ~sakella/modulefiles`
- Load it: `ml python/MambaCylc/22Feb2023`

