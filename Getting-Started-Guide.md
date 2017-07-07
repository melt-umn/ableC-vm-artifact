# Getting Started Guide

This guide contains the set up instructions to evaluate our tool
artifact submission and initial tests of it to see that it works as
expected.  Further instructions for more testing are in
`Step-by-Step-Instructions.md`.

All documents are written in Markdown and thus readable as text
files.  The can also be read in their rendered HTML form on GitHub at
https://github.com/melt-umn/ableC-vm-artifact.

## Setup instructions

#### Start and access the VM.

The VirtualBox VM image is named `ableC_artifact_vm` and can be loaded
into the VirtualBox application and run in the expected way.  The
guest OS is Ubuntu Linux.  You can also run the image in "headless"
form from the command line only and instructions for this can be found
in the file `README.md`.

In an effort to keep the VM image small not much extra software has
been installed and thus it is best to simply SSH into the virtual
machine when it is running.  This will give a better console
experience than the non-scrolling colorless one in the VM.  To do, run
the following command:
```
ssh ubuntu@127.0.0.1 -p 2222
```

The username is
```
ubuntu
```
and the password is
```
ablec
```

#### Verify directory contents

Running `ls` in the home directory should list the following
directories:
`ableC`,
`ableC_sample_projects`,
`bin`,
`extensions`
`README`, and
`silver`.


## Basic testing

To verify `ableC` and the supporting tools work as they should please
run the following tests.

Please note that many of the directories are clones of GitHub
repositories an have Git and Jenkins related files.  Please just
disregard these.


### The parallel-tree-search example

Change to the `~/ableC_sample_projects/parallel_tree_search` directory
and run
```
make ableC.jar
```
This will build the extended C translator for the this example
program.  A "BUILD SUCCESSFUL" message should be displayed after many
lines of output.

(You may see a few errors reported at the beginning of this output.
If you do, please notice that Silver recovers from these errors with a
fall-back strategy so it is not actually a problem.)

Next run
```
make pts.out
```
to compile the example program in `pts.xc`.  This is a variant on the
example in Figure 1 of the paper.  

Now run the generated executable with
```
./pts.out -nproc 4
```
This should display the following:
```
Number of matches = 3 ... correct!
```


### The "down on the farm" example

This example is a rather contrived accounting example for a farm.
Information about animals is stored in an SQLite3 database which the
accounting program reads.  This `accounting.xc` program also uses
extensions that introduce algebraic datatype, condition tables, and
regular expression matching.  More discussion of this example is found
in the `Step-by-Step-Instructions.md` file.

First, the database needs to be created, so run this script as follows:
```
./create_database.sh
```

Next compile the program to populate the database with some
information and run it.  Note that this will trigger the composition
of the extensions to create the `ableC.jar` files as well.

```
make populate_table.out
./populate_table.out
```


Next, compile and run the accounting program.
```
make accounting.out
./accounting.out
```

This should generate the following output.

```
Accounting for "Contrived Examples" farm

Chicken: Stella
   expenses = 10.00
   income   = 0.00
Chicken: Ray
   expenses = 0.45
   income   = 0.50
Chicken: Winnie
   expenses = 1.75
   income   = 0.00
Chicken: Chirpy
   expenses = 0.41
   income   = 0.40
Goat: Edsger, birthday 24/04/2014
   expenses = 29.75
   income   = 51.00
Goat: Henk, birthday 21/10/2013
   expenses = 24.80
   income   = 40.80
Goat: Luitzen, birthday 11/11/2011
   expenses = 23.15
   income   = 37.40

Totals:
   expenses = 90.31
   income   = 130.10
```


If these two steps work, then everything should be installed and
working correctly.

Now move on to the `Step-by-Step-Instructions.md` file.
