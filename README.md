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

``` cmake -- build ```

Now we have our minisat executable as ``` minisat.exe ``` and we can now run our files using MiniSat.


## MacOS
Regarding this operating system, the only method we found so far, was by installing MiniSat using brew:

``` sudo brew install minisat```

## How we worked on this project
### Berindeie Adrian
- created a script that download the files from SAT Competition website
- created a script for preparing and running the files
- analysed obtained data
- wrote the steps for installation on Linux operating system


### Buzuriu Roxana
- studied scientific papers
- studied division into families
- structured the report
- worked on introduction
- wrote the steps for installation on Windows operating system

### Constantinescu Mihai
#### studied Minisat code
- analyzed general structure of the code
- analyzed the data structures used
- analyzed the main function used in the program
- made the diagrams

### Felea Irina
- analyzed the parameters used to run files
- studied division into families
- studied the families
- studied the scientific papers in which are described the problems addressed in the chosen family
- ran the benchmark
- generated the license