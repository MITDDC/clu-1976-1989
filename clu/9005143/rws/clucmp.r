.dv xgp
.fo 0 fonts;25vg kst
.fo 1 fonts;25vgb kst
.fo 2 fonts;25vri kst
.fo 3 fonts;31vgb kst
.nr verbose 1
.so r;r macros
.ls 1.5
.tr ` 
An idealized scheme of compilation is that the parser produces a tree with
"forms" in it.
A form is an "unknown" idn appearing as an expression or constant
(in particular, as a type).
The legality of the form is unknown until equates are processed.
After equates have been processed (or as they are processed),
a new tree is built that contains no forms.
The type checker and code generator work on this new tree.

This is not a suitable implementation of compilation;
rebuilding the parse tree is expensive in time (it requires an extra pass)
and space.
The important decision to make is: when and how to process equates.
There are two possible ways to go.
One way is to process equates after parsing,
and make the parse tree (in particular, idns and typespecs) mutable
so that rebuilding the tree is not necessary.
The other way is to process equates during the parse.
This way,
only module headers need to be rebuilt,
and typespecs (and perhaps idns) can be immutable.

Before going on,
some background will be helpful.
For efficiency,
the parser needs to do two things (in addition to parsing):
canonicalize idns, and canonicalize typespecs.
Idns need to be canonicalized for declaration- and type- checking,
and for emitting (short, uniform) variable names.
Typespecs need to be canonicalized for efficient type comparison,
and for emitting (a minimal number of) type descriptors.
Canonicalization involves,
at the least,
inserting a unique (to the compilation) id in the idn or typespec,
and may also mean having a unique object for each idn or typespec.

If we process equates after parsing then we need mutable idns so that,
once we compute the value of an equate,
we can "substitute" the value everywhere in one fell swoop.
(For efficiency I want an idn to contain info, not just a pointer to info.)
We need mutable typespecs so that,
once we discover that x`=`int, we can substitute int for the typespec x
everywhere in the tree in one operation.
(I don't want to just change the idn contained in the typespec,
because this makes type comparison slower and more complicated.)
Note that equality on typespecs is now equality on uids,
not rep equality.
However,
the parser is fairly free of semantic information;
it knows about scope,
but that's all.
Canonicalizing idns allows declaration checking to be done along with type checking.

If we put declaration checking and equate processing into the "parser",
we get a cleaner type checker,
one that does not have to worry about the possibility that x is not a type
in x$foo.
However,
we have not gotten rid of any problems;
the parser still has to do the checking.
We could get immutable typespecs.
Idns might still be mutable,
but the only idns a typespec could contain are parameters,
and these could be represented by integers instead of actual idns.
The good thing about this scheme is that there is no tricky use of mutability.
One bad thing is that we have thrown a lot of semantic information into the "parser".
But even worse,
I think,
is that there are then two sets of abstract syntax equates for types and expressions,
and three sets of procedures for dealing with them.
(One for parsing equates and module headers,
one for rebuilding module headers,
and one for "normal" parsing.)
The addition of these procedures would double the size of the (existing) parser.

A question that is sort of related to all of this is,
how does the canonicalization of idns and typespecs interact with our notion of
using a compilation environment (CE), and using the library for type-checking?
A CE need not be the most obvious map from strings to values.
Rather,
we note that the parser uses two (hash) tables for canonicalizing idns and typespecs;
a CE can almost be represented by such a pair of tables.
However, the idn table cannot be used by the parser unless the parser does
both declaration checking and equate processing.
If the parser does not do these,
then a CE is represented by a type table and a map from strings to values.
A CE might contain information only down to DUs,
and the DU specs would have to be retrieved from the library,
or it might contain all of the specs, too,
in which case the library need not be accessed during type checking.
As for the representation of typespecs within DU specs,
it doesn't really matter if they are actual typespecs or just something like typespecs.
They will have to be (re-)canonicalized when read in,
so a recursive walk is necessary regardless of their representation.
Writing them out as actual typespecs puts out some "useless" info,
but not all that much.
