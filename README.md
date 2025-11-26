# vhdl-practice
Repository with self-made exercises to improve my VHDL skills. The 
[NVC tool](https://github.com/nickg/nvc) is used as the compiler and simulator
for the VHDL code. To produce and visualize waveform files from NVC simulations,
[GTKWave wave viewer](https://github.com/gtkwave/gtkwave) is used.


## Installing libraries 

### Installing NVC
1. Install NVC.
```
brew install nvc
```

2. Check NVC's version.
```
nvc --version
```


### Installing GTKWave
1. Install dependencies.
```
brew install desktop-file-utils shared-mime-info       \
             gobject-introspection gtk-mac-integration \
             meson ninja pkg-config gtk+3 gtk4
```

2. Build GTKWave.
Head to the GitHub folder where you've got all your cloned
repositories and run this:
```
git clone "https://github.com/gtkwave/gtkwave.git"
cd gtkwave
meson setup build && cd build && meson install
```

3. Check GTKWave's version.
```
which gtkwave
```


## Running a simulation and visualizing the wave form.
To run a simulation and generate the corresponding waveform, follow the 
structure of this command:
```
nvc -a design.vhd design_tb.vhd -e design_tb -r design_tb --wave=waves.vcd
```
, where:
- _**design.vhd**_ is the _Design Under Test_ (DUT), containing the logic
design and the hardware's behavior. It gets compiled into the _work_ library.
- _**design_tb.vhd**_ is the testbench, used only in simulation to instantiate 
the DUT, drive its inputs, and verify its outputs.
- _**waves.vcd**_ is the file that stores the waveform generated during simulation.

To visualize the waveform file corresponding to a simulation, run GTKWave:
```
gtkwave waves.vcd
```
