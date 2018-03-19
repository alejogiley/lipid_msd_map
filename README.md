# MSD_MAP

msd.tcl is a script for [VMD](http://www.ks.uiuc.edu/Research/vmd/) that calculates the mean squared displacement of each lipid head in a bilayer and map it to a grid. It uses the [diffusion_coefficient tool](https://github.com/tonigi/vmd_diffusion_coefficient) developed by Toni Giorgino. For the input files, a sample trajectory is provided of [CLC-ec1](https://www.rcsb.org/structure/1OTS) in a monomeric state, embedded in a MARTINI bilayer of 90:10 POPE/POPG:DLPE/DLPG, where chemically different head groups are in a proportion of 2-to-1. 

## Citation

Please cite the following publication:

Toni Giorgino, Computing diffusion coefficients in macromolecular simulations: the Diffusion Coefficient Tool for VMD, Submitted (2015). Available from [GitHub](https://github.com/tonigi/vmd_diffusion_coefficient/).

## Directory Tree

msd.tcl writes everything on the main directory, relative file path are used in all scripts:

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

## Usage

The script should be run as:

    vmd -dispdev text -e msd.tcl

The trajectory must not be wrapped! You must check before running. 

