.DV XGP
.fo 0 fonts;30vr kst
.FO 1 FONTS;30vrb kst
.fo 2 fonts;30vri kst
.fo 3 fonts;37vrb kst
.so as;r macros
.sr left_heading  Immutable Groupings 
.sr right_heading August 16, 1976
.nf c
.sp 1i
3 MASSACHUSETTS INSTITUTE OF TECHNOLOGY
Laboratory for Computer Science
.sp 1i
.nf l
CLU Design Note 60  August 16, 1976
.nf c
.sp 1i

IMMUTABLE  GROUPINGS

by

Toby Bloom
*
.nf l
.fi
.sp 2i
.ls 2
      The addition of immutable type generators
to CLU is discussed.  A proposal for two such grouping mechanisms,
sequences and structures, is presented.
.bp
       At present, CLU has only two grouping mechanisms,
arrays and records, both of which are mutable.  The addition
of immutable type generators to CLU has been discussed in
the past, but the proposal was rejected ( see Design Note 47
for the reasons).  Since we are now becoming increasingly concerned
with verification, and since the use of immutable groupings
can greatly simplify proofs, we are again considering
adding these type generators to the language.
       The following example provides some motivation
for adding immutable groupings to CLU.
.nf

list=cluster is create, first, rest, add, equal, copy, empty, size;
rep=oneof[l:record[s:string, l:list], n:null];
% the full list cluster is not important here
.fi

LIST is, in fact, immutable. However, because
the rep is mutable, in order to verify this
immutability, you have to prove that none of the
cluster operations use state-changing operations
of records.  If records  were 
immutable, it would follow automatically
that LIST was immutable.  
       So if verification
is considered a goal in CLU, strong
consideration should be given to adding
immutable type generators to the language.
The following is a proposal for two such grouping mechanisms,
sequences and structures.

3Sequences
*

      Sequences are intended to be 'immutable arrays'.
However, they are also very similar to strings.
Strings essentially become sequence[char].

      The major problem here seems to be one of
syntax.  If we are going to have two such
similar constructs  as arrays
and sequences, how similar should the syntax
be ?  In one sense, we would like some
degree of uniformity in the language.  Since the
operation names in no way imply the mutablility
or immutability of the type, no clarity
seems to be added by using (for instance) 'extend' for arrays
but 'append' for sequences.
On the other hand, we would like to emphasize
the differences between the two types. The 
user should be aware that array[t]$extendh
will behave differently from
sequence[t]$extendh.  In this note, I have
taken the view that requiring the type name
to precede the operation name, as in array[t]$extendh,
is sufficient to ensure that the user is
reminded of the type of the object being
manipulated.  Beyond that, I don't think
that using distinct operation names will
suggest the behavioral differences any
more clearly.  So most of the operation names will remain the
same.

      The following are the operations 
proposed for sequences.  They are for
the most part the same as those in
Design Note 47, and are a combination
of array and string operations.

(Assume that s1 and s2 are variables of type seq[t],
i1 and i2 are integers, v1 and v2 are of type t, and
a is of type array[t].)

 
.ls 1

1) create()

returns the empty sequence.


2) concat(s1,s2)

returns a  sequence which is the 
concatenation of s1 and s2. The two input
sequences remain unchanged.


3) extendh(s1, v1)

returns a  sequence which 
has v1 added on to the end of
s1. s1 remains unchanged.


4) extendl(s1, v1)

returns a sequence which
has v1 as its first element
and s1 as the rest of the
sequence.


5) retracth(s1)

returns a sequence which
contains all but the last element
of s1.


6) retractl(s1)

returns a sequence with
all but the first element of
s1.


7) subseq(s1, i1, i2)

returns a sequence of length 
i2, which occurs in s1 starting
at position i1.


8) replace(s1, i1, v1)

returns a sequence with the i1
element equal to v1, and all other
elements being the same as in s1.


9) size(s1)

returns the number of elements in the sequence.


10) fetch(s1, i1)

returns the element in position i1 in
s1.  Syntactic sugar for this
operation is s1[i1].


11) equal(s1, s2)

returns true if s1 and s2 are the same
sequence, (that is, if s1 and s2 are element 
by element 'equal'), and returns false otherwise.
Since sequences are immutable,
two sequences with equal elements are
indistinguishable.


12) similar(s1,s2)

if s1 and s2 are element by
element similar, then true, else false.


13) empty( s1)

if size(s1) = 0 then true, else false.


14) s2a(s1)

creates an array which is element
by element equal to s1.


15) a2s(a)

returns a sequence which is 
element by element equal to
a.


16) index( s1, s2)

returns n integer which is the index of the beginning of the first
occurrence of s2 in s1. if s2 does not occur in s1, returns -1.

17) first( s1)

this is equivalent to fetch(s1,0)
and is included for consistency with
the string cluster.


18) last(s1)

this is the same as fetch(s1,size(s1)-1)


19) rest(s1)

same as retractl(s1)


20) fill(i1,v1)

returns a sequence of length i1,
all of whose elements = v1.


21) copy(s1) 

returns a sequence s2 such that
every element of s2 is a copy
of the corresponding element of s1.
(if t is immutable, s2 cannot be 
distinguished from s1).


.ls 2

SOME COMMENTS ON THE DIFFERENCES BETWEEN
ARRAYS AND SEQUENCES.

     The 'equiv' operation
has intentionally been omitted,
since it is identical to 'equal'.
Copy1 is unnecessary since sequences
with equal elements cannot be distinguished from
one another.We might want to include 'equiv' and 'copy1'
for consistency.

It is important to realize that
the functionality of operations
on sequences is not the same as that of the
corresponding array operations.  For
example, since seq[t] is immutable,
st$extendh(s,v), where st= seq[t],
does not change s.  It is an expression whose
value is a new sequence, and can
therefore be used as:

s2:=st$extendh(s1,v1)

in contrast to the imperative way array[t]$extendh(a,v)
is used.

Indexing is implicit in sequences.  All
sequences are assumed to begin at position 0.
The user may reference elements by their position,
but may not specify the lower bound of the sequence,
as may be done with arrays.  This also means that certain
of the cluster operations return sequences in which
the index of any given element is not the same as
the index of that element in the input sequence.
For example, extendl(s,v) will return a sequence
in which v is in position 0, and s[0] is in position
1, etc. (In other words, each element of the old sequence
is contained in the new sequence, but in a different
position.)  It must be stressed that the original sequence remains
unchanged.  In contrast, array[t]$extendh does change
the original array, but the index of any given element
remains the same.  This behavior in sequences is
consistent with the behavior of strings.


SEQUENCE CONSTRUCTORS

    We will, of course, want a sequence constructor,
corresponding to the array and record constructors
which exist for mutable type generators.  This 
brings up another syntactic problem.  Array
constructors have the form:

[i:e1,e1....en] or just [e1,e2,....,en].

If we use the same syntax for sequence constructors,
there would be no way to tell the type of the constructor
from the syntax of the expression.  So
we need a different syntax.  There are two
options that I can see.  One is to find another
special symbol to denote a sequence constructor.
I don't like this for two reasons. First, we're
going to run out of ASCII characters soon. 
Secondly, I  think using additional special
characters will detract from
the readability of the
language (admittedly, this is personal opinion).
The other option is to include the type in the constructor.
Since constructors are in reality syntactic sugar
for a series of operations of the type, anyway,
it seems fairly consistent to express the type of
the constructor in the same way as the type of
cluster operations.  Sequence constructors would
then be written as:
.nf
st$[e1,e2,...,en]  where st=seq[t]
and array constructors as:
at$[i:e1,e2...en] or at$[e1,e2,...,en]  
     where at=array[t]
.fi

ITERATORS

     Iterators for sequences are very much
like iterators for arrays.  The
iterator 'elements' can be defined as:
.nf
.ls 1
elements=iterator(s:seq[t]) yields (t);

for i:int:=0 to size(s)-1
do yield (s[i]);
end elements;
.fi
.ls 2
.sp 1i
3Structures
*

     Structures are immutable groupings similar
to records.  The operations for structures are:
(Assuming str1,str2:struct[s1:t1,...,sn:tn]; 
r:record[s1:t1,...,sn:tn]; v1 through
vn are of types t1 through tn; s1 through sn are selectors.)

.ls 1

1) create(v1,...,vn)

This returns the structure with the given 
components. As in record$create, the operation
is implicit in the constructor, and
is not available to users.


2) get_si(str1)

returns the si component of str1.


3) put_si(str1,vi)

returns a structure with si-component equal to vi,
and all other components equal to corresponding components
of str1.


4) equal(str1, str2)

returns true if str1 and str2 are 
the same structure, thatis, 
component by component equal. Returns
false otherwise.


5) similar(str1, str2)

returns true if str1 and str2 are component
by component similar, false otherwise.


6) copy(str1)

returns a structure in which each component
is a copy of the corresponding component of 
str1. If all the ti's are immutable, the
resulting structure is indistinguishable
from str1.


7) s2r(str1)

creates a record which is component by
component equal to str1.


8) r2s(r)

returns a structure which is component by component
equal to r.
.ls 2


Note: 'equiv' and 'copy1' have been omitted
for the same reasons discussed in the section on sequences.



CONTRUCTORS

     As with sequences and arrays, the best
choice here seems to be modifying the syntax
of record constructors to include a type
specification.

Record constructors will now look like:

rt${s1:e1,...,sn:en}
     where rt=record[s1:t1,...,sn:tn]

and structure constructors will be written as:

st${s1:e1,...,sn:en}
     where st=struct[s1:t1,...,sn:tn]

It should be noted that there is no longer
any need for different syntax for record and array
constructors.  The square-bracket notation
could be used for all constructors now, and
it might be a good idea to make the syntax
uniform.


CONCLUSIONS



    A proposal for two types of immutable
groupings has been presented.  The 
ability to verify assertions about
programs more easily with immutable 
groupings, and, in fact, the ability
to prove stronger assertions about
certain programs, makes the addition of
immutable groupings to CLU seem fairly
attractive.  Further work is required 
before final decisions about some of the syntax
problems can be reached.

      As a result of defining more explicitly
the behavior of immutable groupings, it
now seems that sequences are less
redundant than originally thought.  In
many ways, they are an extension of strings,
and may prove useful in other ways than
just verification.  Structures have turned
out to be essentially very similar to records,
and will prove useful, for the most part, in
cases where mutability isn't needed, and
therefore, the additional verification ability
may be utilized.


ACKNOWLEDGEMENTS

      I would like to thank Russ Atkinson, Eliot Moss,
and Craig Schaffert for their many helpful suggestions.
