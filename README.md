# How to install MiniSat on different operating systems

## clone project from:
``` https://github.com/niklasso/minisat ```

## Linux
After cloning the project, run the following commands from MiniSat directory:

``` make CXXFLAGS = " - fpermissive " ```

``` sudo apt install make ```

And now, go to the following path: ``` cd build / release / bin ```, from where you can run files using MiniSat.

## Windows
For start, we need to install the free and open-source Unix-like environment and command-line interface for Windows, **Cygwin** from https://www.cygwin.com, and run the *setup.exe* file.

Next, we need to install CMake software and extract the files in a folder named, for example, like this: ``` C:\CMake ```.

After that, we need to configure the access paths in **PATH**. We open **Environment Variables** and in **Path variable** we add access paths to ``` MinGW\bin ``` and ``` CMake\bin ```.

Now we clone the project, and using **Cygwin** we navigate to MiniSat directory and from here we run the following commands:

``` cmake -G " MinGW Makefiles " ```

``` cmake -- build ```a

Now we have our minisat executable as ``` minisat.exe ``` and we can now run our files using MiniSat.


## MacOS
Regarding this operating system, the only method we found so far, was by installing MiniSat using brew:

``` sudo brew install minisat```






# Original README
================================================================================
Quick Install

- Decide where to install the files . The simplest approach is to use
  GNU standard locations and just set a "prefix" for the root install
  directory (reffered to as $PREFIX below). More control can be
  achieved by overriding other of the GNU standard install locations
  (includedir, bindir, etc). Configuring with just a prefix:

  > make config prefix=$PREFIX

- Compiling and installing:

  > make install

================================================================================
Configuration

- Multiple configuration steps can be joined into one call to "make
  config" by appending multiple variable assignments on the same line.

- The configuration is stored in the file "config.mk". Look here if
  you want to know what the current configuration looks like.

- To reset from defaults simply remove the "config.mk" file or call
  "make distclean".

- Recompilation can be done without the configuration step.

  [ TODO: describe configartion possibilities for compile flags / modes ]

================================================================================
Building

  [ TODO: describe seperate build modes ]

================================================================================
Install

  [ TODO: ? ]

================================================================================
Directory Overview:

minisat/mtl/            Mini Template Library
minisat/utils/          Generic helper code (I/O, Parsing, CPU-time, etc)
minisat/core/           A core version of the solver
minisat/simp/           An extended solver with simplification capabilities
doc/                    Documentation
README
LICENSE

================================================================================
Examples:

Run minisat with same heuristics as version 2.0:

> minisat <cnf-file> -no-luby -rinc=1.5 -phase-saving=0 -rnd-freq=0.02
