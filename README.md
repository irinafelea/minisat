# Project description
This project focuses on studying the MiniSat solver for benchmarks from the SAT 2024 competition, focusing on conflict-driven clause learning (CDCL) algorithm and variable ordering heuristics. We propose enhancements to MiniSat's functionality, focusing on memory allocation improvements. Preliminary results indicate performance gains in execution time and memory usage, tested across two different configurations. 

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

# How to run a CNF file using MiniSat
To run files using MiniSat, we need those files to be in DIMACS format. After we are sure that the file we want to run is in DIMACS format, we can run that file using the following command

```minisat file.cnf file.out > file.stats ```

- *minisat* is the name of the program that we are using to run the file
- *file.cnf* is the name of the input file in the DIMACS format
- *file.out* is the output file that contains the result as *SAT + model*, *UNSAT* or *INDET*
- *file.stats* is the output file containing the run statistics. In this file we can see the number of conflicts, decisions, propagation, conflict literals and status.

# Benchmark description *(scheduling family)*
The text discusses two planning problem types. The first involves school timetable planning, where courses are assigned to professors, classrooms, and timeslots while satisfying constraints like avoiding conflicts in schedules or room availability and respecting teachers' qualifications and availability. ***Using MapleLCMDistChronoBT*** solver, 20 instances were tested, with one satisfiable instance involving 272 courses, 52 professors, 18 classes, and 32 rooms solved in 80.65 seconds.

The second topic focuses on optimal scheduling of parallel tasks, defining a ${P||C_{max}}$ problem with tasks distributed to identical processors. Constraints were expressed using logical formulas and binary decision diagrams (BDD). Instances with tasks ranging from 20 to 220 were tested using the ***KISSAT*** solver. While some instances were unsatisfiable, others yielded satisfiable results within 13–54 seconds.

# How we worked on this project
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
#### studied MiniSat code
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