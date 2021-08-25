.so clu/6170.header
.
.
.problem 3 "14 October 1977"
.
.
.sec "Problem Statement"
We would like you to write a program called 2xref*, which
produces an index for some document.  The document is a text
file (produced by the editor) consisting of a number of lines.
Each line is a sequence of letters, spaces, and punctuation.
A contiguous sequence of letters is called a word.  Spaces,
punctuation, and line-breaks serve to separate words.
.
.para
An index for a document is an alphabetical listing of the words
in the document.  Following each word in the index is a list of
the numbers of the lines on which that word occurs in the input
document.  The lines in document are numbered consecutively
from 1.  The index should have no more than one entry for any
word.  The line number lists should each be in increasing
order and contain no duplicate line numbers.
.
.para
In constructing an index, you should consider only words longer
than one letter.  In addition, you should not distinguish
between upper and lower case letters.  For example, the
document
.table 4
	A stitch in time
	saves nine?
	Nine mem in a
	30' boat; a Boat
.end_table
produces the index
.table 7
	boat	4
	in	1  3
	men	3
	nine	2  3
	saves	2
	stitch	1
	time	1
.end_table
The document is to be read using input procedures that we will
provide (see Handout ?).  These procedures return characters
one at a time, with the special 1newline* character separating
lines.  The index is to be output to a segment, using PL/I list
I/O.
.sec Modifications
When designing a program, one should anticpate possible modifications
that might be made to the program later and, where feasible,
design the program to facilitate those later modifications.
A useful technique is to encapsulate knowledge that might change
in some abstraction, either a procedure or a data abstraction.
.
.para
In designing the 2xref* program, we want you to consider
the modifications listed below.  2Do not implement these
modifications.*  However, you should include in your writeup
a sketch of how these modifications would be made to your program
and how your design facilitiates making the modifications.
.
.para
The modifications are:
.ilist 4
1.	Modify the program to handle multi-page files.  Such files
consist of pages separated by special NEWPAGE characters.
The line numbers in the index should have two components, the
page number and the line number on the page.
.next
2.	Modify the program to produce indexes for sets of input
files.  For each word, the index should list line numbers for each file
that the word appears in.  A file name should appear at most once
for each word in the index.
.next
3.	Modify the program to produce an index of the procedures
defined and called in a program.  Assume the input files are
in some programming language with specific rules for determining
what pieces of the input files correspond to procedure names.
.next
4.	Modify the program as described in (3), but in addition,
each index entry should list the location where the procedure
is defined.
.end_list
.
.sec "Comments"
.ilist 4
1.	The above problem statement is incomplete.  Try to think
of things that we haven't stipulated.
.next
2.	There are several possible data abstractions in the program.
You should attempt to identify useful abstractions and use them
explicitly in your program.
.next
3.	Do not be overly concerned with efficiency.  Wherever
possible, choose a simple, slow implementation over a faster,
more complex one.
.end_list
