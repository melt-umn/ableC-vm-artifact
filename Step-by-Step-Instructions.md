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



### Using the extensions in a sample "parallel-tree-search" project 

Satisfied that extension might be useful, the programmer could use
them all in a single program.

Change to the `~/ableC_sample_projects/parallel_tree_search`
directory.
```
cd ~/ableC_sample_projects/parallel_tree_search
```

To compose these language extensions together the programmer needs to
write a short specification file to name the desired language
extensions and use Silver to compile this specification into an
`ableC.jar` file that is implementation of the translator for this
custom extended version of C.

For this project, this specification can be found in
`artifact/Artifact.sv`.  This is a boiler-plate Silver specification.
The only parts that a programmer would need to edit are between the
curly-braces after `parser extendedParser :: cst:Root`.

The paper describes a small extension composition DSL that eliminates
the surrounding boiler-plate Silver code.  We decided to eschew that
DSL for the artifact since it is not so useful and seeing the actual
Silver code strengthens, we believe, our claim that composing language
extensions is (nearly) automatic and reliable if the MDA and MWDA
pass for all extensions.

Let's now consider the contents of this file inside the specified
curly braces.

One should first notice the first 5 lines which indicate the language
specifications that are to be composed.  These include the AbleC host
language on the first line, `edu:umn:cs:melt:ableC:concretesyntax`.  
The next 4 are the extensions to be used in this project.

Both the algebraic datatypes and the regular expression extension
introduce a new "marking" terminal `match`.   As the paper describes,
this is a lexical ambiguity.  It is easy for the progarmmer to
disambiguate it.  No other lexical ambiguities are possible.

The `prefix with` clause give the string that will precede the
ambiguous `match` keyword if the default one is not used.  In the
`pts.xc` file on line 64 you will see a comment showing how one would
write `RX::match` to indicate that the regular expression `match`
keyword was meant, not the `match` keyword from the algebraic datatype
extension that appears on line 55.

The example currently uses the extension-introduced infix operator
`=~`.

Feel free to try both version of the condition on line 61: the one
there now or the one in the comment.

The final bit, on line 17 of `Artifact.sv` determines which `match`
keyword is the default one.  What is written now indicates that the
algebraic datatype `match` is preferred over the regex `match.
Unfortunately the full name of the offending terminal symbol must be
typed here.

To build this artifact, make sure you are in the
`parallel-tree-search` directory and type
```
make ableC.jar
```
then compile the sample program with
```
make pts.out
```
then run it with
```
./pts.out -nproc 4
```

This can be repeated for any changes to the `Artifact.sv` or `pts.xc`
files that are mad.e


### The "down-on-the-farm" project

As discussed in the Getting-Started-Guide, this example is a rather
contrived accounting example for a farm.  Information about animals is
stored in an SQLite3 database which the accounting program reads.
This `accounting.xc` program also uses extensions that introduce
algebraic datatype, condition tables, and regular expression matching.

Be sure to have completed the steps in the Getting-Started-Guide for
this project first.  After that, return to this document.

Again, take a look at the `artfact/Artifact.sv` file.  It has a form
very similar to the one from the parallel-tree-search.  You can see
that it is only the bits between the curly braces after the `parser`
construct that changes.

This sample is divided up into 6 steps.  It forms a demonstration that
we've given a few times and evolves the programs starting with
`accounting-step1.xc` up the final version in `accounting-step6.xc`.
(Note that `accounting.xc` is just a copy of the final
`accounting-step6.xc` version.)

Looking at `accounting.xc` one can see uses of the SQLite, algebraic
datatypes, regular expressions, and condition-tables extension.  The
constructs introduced by the extensions are discussed in the body and
appendices of the paper.

It provides another example of a composition of several different
language extensions.




## From the extension developer's perspective

The second perspective from which to consider AbleC is from that of
the person developing language extensions.

There are many aspects to writing language extensions for C, in
AbleC.  In order to keep the evaluation process a reasonable one we
focus on just a few aspects of writing extensions here.

1. concrete syntax

   show a bit of condition tables,

2. abstract syntax

   same

3. examples
  
   consider the `altitude_switch.xc` example.

   Extension designers may create similar examples to illustrate what
   they perceive are the useful features of their extension.

4. Analysis
   consider files for MDA and MWDA



Then advanced stuff, consider the tutorials.  These are in
`~/ableC/tutorials` or online in their rendered HMTL form at
https://github.com/melt-umn/ableC/tree/develop/tutorials



New infix operators

Operator overloading for intervals



mention all the automatic includes ...

writing an extension is not something that can just be done

maybe a tour of some files - looking at syntax and semantics

then how the make files work


Go look at somethings in the appendix ...

artifact doesn't contain all extensions - this is OK



we are missing the construction DSL ....


Link to the tutorials in github.com or look at the raw Markdown files
in the ~ableC/tutorials directory.
