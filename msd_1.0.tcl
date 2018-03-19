#### Load packages

package require pbctools 
package require diffusion_coefficient

#### Load files

mol load gro Example/leaflet0_unwrap.gro
mol addfile Example/leaflet0_unwrap.trr type trr first 0 last -1 step 1 waitfor all

#### PBC

#pbc wrap -center com -all

#### Initialize

#set binsize 3A
set binsize 3
# set stride 100 frames
set stride  10
# set windows
set wind1   2
set wind2   4
# set step between windows
set step    1
# set box sizes
set x_size  300
set y_size  300

#set number of lipid residues
set sel [atomselect top "name PO4"]
set nresid [llength [lsort -unique -integer [$sel get residue]]] 
set lresid [$sel get resid]

#matrix with indexes as array(int(x-xmin/bin),int(y-ymin/bin))
for {set i 0} {$i < [expr int($x_size/$binsize)]} {incr i} {
	for {set j 0} {$j <= [expr int($y_size/$binsize)]} {incr j} {

		set matrix($i,$j) 0.0
		set patrix($i,$j) 0.0
		set pop($i,$j) 1
	}
}

set mols [molinfo top]
set frames [molinfo $mols get numframes]

#### Fill matrix with MSD values

for {set i 0} {$i < [expr $frames-$stride]} {incr i $stride} {
	for {set j 0} {$j < [expr $nresid-1]} {incr j} {
	
		puts "frame $i"
	
		set coord [atomselect top "name PO4 and resid [lindex $lresid $j]" frame $i]
		set x [$coord get {x}]
		set y [$coord get {y}]

		set k [expr int([expr floor([expr ($x-[expr floor($x/$x_size)*$x_size])/$binsize])])]
		set l [expr int([expr floor([expr ($y-[expr floor($y/$y_size)*$y_size])/$binsize])])]

		set msd [diffusion_coefficient -selection "name PO4 and resid [lindex $lresid $j]" -msd range -interval_from $i -interval_to [expr $i+$stride] -interval_stride 1 -from $wind1 -to $wind2 -step $step -alongz 0 -remove_drift 0]

		set pippo [lindex [lindex $msd 1] 1]

		set matrix($k,$l) [expr {$matrix($k,$l) + $pippo}]
		incr pop($k,$l)
	
		unset msd pippo k l coord x y
	}
}


#### Map the protein atoms

mol load gro Example/protein_unwrap.gro

unset sel nresid lresid

set sel [atomselect 1 "name BB and z>45"]
set nresid [llength [lsort -unique -integer [$sel get residue]]]
set lresid [$sel get resid]

for {set i 0} {$i < [expr $nresid-1]} {incr i} {

	set coord [atomselect 1 "name BB and resid [lindex $lresid $i]"]
	
	set cx [$coord get {x}]
	set cy [$coord get {y}]

	set k [expr int([expr floor([expr ($cx-[expr floor($cx/$x_size)*$x_size])/$binsize])])]
	set l [expr int([expr floor([expr ($cy-[expr floor($cy/$y_size)*$y_size])/$binsize])])]
	#set k [expr int([expr floor($cx/$binsize)])]
        #set l [expr int([expr floor($cy/$binsize)])]

	set patrix($k,$l) [expr {$patrix($k,$l) - 0.1}]

	unset coord k l cx cy	
}

#### Prints Matrix

set fm [ open Example/MSD.dat w+ ]
set fp [ open Example/PRO.dat w+ ]
	
#from A^2 to nm^2
set unit 100

for {set j 0} {$j < [expr int($x_size/$binsize)]} {incr j} {
        for {set i 0} {$i < [expr int($y_size/$binsize)]} {incr i} {
                puts -nonewline $fm [format "%.3f " "[expr $matrix($i,$j)/($unit*$pop($i,$j))]"]
		puts -nonewline $fp [format "%.3f " "$patrix($i,$j)"]
        }
	puts $fm " "
	puts $fp " "
}

exit

