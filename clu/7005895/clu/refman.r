 to run off everything, say		:nr all=1 clu/refman.r
 to run off a few things, say, e.g.	:nr lex=1 stmts=1 io=1 clu/refman.r
.
.so clu;refman insert
.
.nd all 0
.
.de chap
. nd \1 all
. if \\1
.  nr chapter \0-1
.  so clu;\1 refman
. en
.em
.
.de pndx
. nd \1 all
. if \\1
.  nr appendix \0-1
.  so clu;\1 refman
. en
.em
.
.chap  1 part_a
.chap  7 gram
.chap  8 lex
.chap  9 types
.chap 10 e_d
.chap 11 action
.chap 12 exprs
.chap 13 stmts
.chap 14 except
.chap 15 module
.
.pndx  1 syntax
.pndx  2 opdefs
.pndx  3 io
.pndx  3 newio
