# msd_map

msd.tcl is a script for [VMD](http://www.ks.uiuc.edu/Research/vmd/) that calculates the mean squared displacement of each lipid head in a bilayer and map it to a grid. It uses the [vmd_diffusion_coefficient tool](https://github.com/tonigi/vmd_diffusion_coefficient). A sample trajectory is provided (of [CLC-ec1](https://www.rcsb.org/structure/1OTS) in a monomeric state, embedded in a MARTINI bilayer of 90:10 POPE/POPG:DLPE/DLPG, where chemically different head groups are in a proportion of 2-to-1. structurally, 

## Directory tree

msd.tcl writes everything in Example/, under a relative internal path:

```
/msd_map/
├── Example
    ├── protein_unwrap.gro  --> coord of the protein at time 0.
    ├── leaflet0_unwrap.gro --> coord of the upper leaflet at time 0.
    └── leaflet0_unwrap.trr --> traj of lipids.
└── Figure
    ├── gnuplot.plt --> gnuplot script.
    └── palette.pal --> color palette.
```
