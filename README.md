# MSD_MAP

msd.tcl is a script for [VMD](http://www.ks.uiuc.edu/Research/vmd/) that calculates the mean squared displacement (MSD) of each lipid head in a bilayer and map it to a grid. It uses the [diffusion_coefficient tool](https://github.com/tonigi/vmd_diffusion_coefficient) developed by Toni Giorgino. For the input files, a sample trajectory is provided of [CLC-ec1](https://www.rcsb.org/structure/1OTS) in a monomeric state, embedded in a MARTINI bilayer of 90:10 POPE/POPG:DLPE/DLPG, where chemically different head groups are in a proportion of 2-to-1. 

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

The ```diffusion_cofficient``` tool is run internally with the following options, e.g.:

    diffusion_coefficient -selection "name PO4 and resid 455" -msd range -interval_from 1 -interval_to 10 -interval_stride 1 -from 2 -to 5 -step 1 -alongz 0 -remove_drift 0

For a detailed explanation of the meaning of each command term see the appropriate [documentation](https://github.com/tonigi/vmd_diffusion_coefficient/blob/master/doc/README.md). The MSD is computed in windows of 10 frames each, using lag times from 2 to 5 frames. The MSD value at lag time 2 is the one used in the projection. Values are stored in a PBC-corrected array (for a box with the origin at the lower left vertex):

    x_pbc = x - floor(x / xbox_size) * xbox_size

Resuts are printed in files ```MSD.dat``` for the lipid MSD map, and and ```PRO.dat``` for the grid mapped protein atoms. 

A postcript and a TIFF figure can be generated running these commands at the Figure directory:

    gnuplot gnuplot.plt
    convert -density 300 MAP.ps -geometry 900x900 -rotate 90 MAP.tiff

## Screenshot

![MAP.tiff](Figure/MAP.tiff)
    
    

