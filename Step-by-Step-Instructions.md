# Step by Step Instructions

These instructions consider AbleC and its extensions from the
perspective of the programmer who simply uses language extensions and
the extension developer who creates them.


## From the programmer's perspective.

As described in the paper, the idea with AbleC is that programmers can
use multiple indepedently-developed language extensions in the
application.  

We first revisit the parallel-tree-search example that was tested in
the Getting-Started phase.  This sample mini-project uses three primary
different language extensions:

1. Cilk-style parallelism
2. Algebraic Datatype
3. Regular expression matching

It also uses a forth, that allows regular expression matching to work
in pattern matching.

### Getting and testing extensions.

The first thing a programmer would do it is to download and test out
the proposed extensions.  We'll go through this process for the Cilk
extension.  The others would follow a similar pattern.

The Cilk extension, and the others, are already on the VM, so we go
look at it first. 
```
cd ~/extensions/ableC-cilk
```

Language extensions are expected to pass the modular analyses
described in the paper.  So an extension user would first like to
verify this.

First the Modular Determinism Analysis can be run as follows:
```
make mda
```
Check that some extensions pass the MDA and that their examples run
Generates different MDA tests for different sub-grammars.  Look for
```
   [copper] Modular determinism analysis passed.
```
in the output to verity that these did pass.

In some extensions, a warning message `warning: useless nonterminals`
is displayed.  This can be safely ignored.

Next the programmer would like the check that the Modular
Well-Definedness Analysis also passes.  This can be done with the
following command:
```
make mwda
```
Check that there are no errors (only `Generating Translation.`)
after the line
```
Checking For Errors.
```
If there are no errors, then the analysis passed.

### Experimenting with the extension.

To see what the extension provides one can see some examples in the
extension `examples` directory.  Extension writers may provide several
examplesl but we just provide one here to keep things simple.  First 
```
cd examples
```
and then run
```
make fib.out
```
This will cause the `ableC.jar` composed compiler to be generated and
then the Fibonacci program is compiled.

To run Cilk programs, a `-nproc` flag to indicate how many cores to
use.  This VM has just 4, so try the following:
```
time ./fib.out -nproc 4 40
time ./fib.out -nproc 1 40
```
to see the result (10233415) and the different `real` time needed.
You may need to choose a higher or lower number to show the speedups
based on the actual hardware you are using.


The programmer could repeat this process for the other extensions -
`ableC-algebraic-data-types` and `ableC-regex-lib`.

In the `ableC-algebraic-data-type` extension one can type
```
make analyses
```
to check both MDA and MWDA work.
Typing
```
make examples
```
will build an `ableC.jar` artifact and test all the examples.



### Using the extensions in a sample project.

Satisfied that extension might be useful, the programmer could use
them all in a single program.

Change to the `~/ableC_sample_projects/parallel_tree_search`
directory.
```
cd ~/ableC_sample_projects/parallel_tree_search
```

To compose these language extensions together the programmer needs to
write a short specification file to name the desired language
extensions and 
and 

Parallel-tree-search.

1. build artifact
2. compile pts.xc
3. run it




## From the extension developer's perspective

mention all the automatic includes ...

writing an extension is not something that can just be done

maybe a tour of some files - looking at syntax and semantics

then how the make files work


Go look at somethings in the appendix ...

artifact doesn't contain all extensions - this is OK



we are missing the construction DSL ....


Link to the tutorials in github.com or look at the raw Markdown files
in the ~ableC/tutorials directory.
