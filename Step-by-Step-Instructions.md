# Step by Step Instructions

These instructions consider AbleC and its extensions from the
perspective of the programmer who simply uses language extensions and
the extension developer who creates them.


## From the programmer's perspective.

As described in the paper, the idea with AbleC is that programmers can
use multiple independently-developed language extensions in the
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
examples but we just provide one here to keep things simple.  First 
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
this is a lexical ambiguity.  It is easy for the programmer to
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

Again, take a look at the `artifact/Artifact.sv` file.  It has a form
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

From the perspective of the extension user (the programmer) described
above, this user need not understand the underlying tools such as
Silver and Copper that are used to implement language extensions.

In this section, we consider the second perspective of the person
developing language extensions. This person must understand these
tools and the underlying techniques.

There are many aspects to writing language extensions for C, in
AbleC.  In order to keep the evaluation process a reasonable one we
focus on just a few aspects of writing extensions here.


We'll first look at some aspects of the `ableC-condition-tables`
extension, described in the appendix of the paper.


(Note that we've used some Makefiles that automatically access any
`include` or library files provided by extensions.  This simplifies
the Makefiles but does mean that on occasion an extension may build
and reference another one that seems to not be needed.  This can be
disregarded.)


### Writing concrete syntax

Language extensions can add new concrete syntax to a language.  Let us
go to that directory:
```
cd ~/extensions/ableC-condition-tables
```

The Silver grammars that form an extension specification are in the
`grammars` directory in which the grammar name is based on the URL of
the developer to keep them distinct.
```
cd grammars/edu.umn.cs.melt.exts.ableC-condition-tables
```
then
```
cd concretesyntax
```
to see the file `Tables.sv` with these specifications.  All Silver
files end with a `.sv` extension.

Open up this `Tables.sv` file and we can see that it imports parts of
the host language grammar before defining some terminal symbols for
keywords that are added to the language.  

The extension designer has written several `concrete` productions to
define the concrete syntax of this extension.  To those familiar with
EBNF forms of grammars these look as expected and as described in the
paper.

One interesting bit is the disambiguation function on line 16.  This
is to accommodate the lexical ambiguity between the two 'new line'
terminals.  It is an example of the kind of disambiguation and
'grammar tweaking' that an extension writer may need to do to get
their extension to pass the modular determinism analysis.


### Writing abstract syntax

Extension writers also need to define the abstract syntax and semantic
analysis of their extension constructs.  These are stored in the
`abstractsyntax` directory, so
```
cd ../abstractsyntax
```
and open `Tables.sv`

Here are the `abstract` productions that define attributes for
language extensions.

An example of some error checking that this extension performs is to
see that all the rows in a condition-table have the same number of
true/false/star flags.

Please see lines 38 and 39 of this file.  Here the `errors` attribute
is collecting error messages from the component rows (line 38) and
adding a new error if the row `trow` and those in `trowtail` (yes the
naming is a bit backward here) do not have the same length.

On line 15 of this file we see where the table construct translate
down to plain C code using the `forwards to` construct of Silver.
Here we collect any declarations generated, fold them up, and compute
the large and/or nested expression that implements the table.  This is
done inside these function, but an example of the generated code can
be seen in Figure 14 of A.3 in the paper.

This exemplifies the sort semantic analysis and translation to C code
that is done by language extensions.


### Providing some examples.

Extension designers may create similar examples to illustrate what
they perceive are the useful features of their extension.  These are
in the `examples` directory, so
```
cd ~/extensions/ableC-condition-tables/examples
```

Here an example in `altitude_switch.xc` motivates the usefulness of
condition tables.  Please take a look to see how this particular
construct can be used.


### Modular analyses.

As described in the paper, Silver and Copper provide modular analyses
that ensure the composition of language extensions will be successful.

To demonstrate that the analyses do pass for this extension the
extension designer may create, as suggested, a `modular_analysis`
directory in their extension for this purpose.  A `Makefile` here
shows how to run each analysis.

In this directory is a directory for each kind of analysis.  

In `determinism` is a file with a `copper_mda` test specification.  It
lists the host language grammar and the extension grammar that on
which the analysis is performed.

In `well-definedness` is a Silver specification that extends the host
language with the condition-table extension.  In running this
analysis, the `--warn-all` flag is used (in the `Makefile`) to
trigger the modular well-definedness analysis.

The extension writer will construct these so that the user can verify
for themselves that the extension passes the modular analyses.



### An advanced feature.

One of the additional features that an extension writer might like to
use in their extension is operator overloading.  This is discussed in
Section 8.1.

To see this, we look at the abstract syntax specification for the
interval type extensions.  Thus,
```
cd ~/extensions/ableC-interval/grammars/edu.umn.cs.melt.exts.ableC.interval/abstractsyntax/
```

The implementation in the paper is a simplification of what is
actually needed to specify operator overloading, but not much of one.

Instead of writing an `aspect production` as in Figure 7(b) one writes
an `aspect function`, as seen on line 14 in the `AbstractSyntax.sv`
file.   This has essentially the same effect but simplifies the
specification of overloading in the host language.  We describe the
alternative in the paper as it allows us to avoid introducing the new
concept of `aspect function` there.

(Note it is called `unaryMinus` in the paper but `NegativeOp` in
the specification.) 

But the body of the aspect production in the figure and the aspect
function are essentially the same.  Both contribute to an `overloads`
collection attribute with the name of the module and the function to
construct the AST for the overloading operation.  In the paper it is
just the name of a production.  In the specification the function is
written as a lambda expression that then uses the `negInterval`
production in its application.  This production can be see on line 119
of this file.  It uses some convenience functions that elide some of
the details, but ends up forwarding, when there are no errors, to a
call to a library function named `inv_interval`.




### Additional tutorials.

As stated, we've refrained from demonstrating all the advanced
features in the paper.  But those extensions that use them are part of
the artifact and can be explored.  Extensions have the same file and
directory structure so navigating these should not be too difficult.

There are also a number of tutorials for writing language extensions.
These are not yet complete but several useful tutorials are available.
These are in `~/ableC/tutorials` or online in their rendered HMTL form
at https://github.com/melt-umn/ableC/tree/develop/tutorials

If further demonstrations are of interest please take a look at these.




