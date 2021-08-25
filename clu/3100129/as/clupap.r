. CLU paper
.
. set csg_memo to 0 for paper version
. set it to csg memo number for csg memo version
.
. set narrow to 1 for map version
. and insert ;SIZE 14 at the beginning of the XGP file
.
.nr narrow 0
.nr csg_memo 0
.
.so as/clupap.header
.so as/clup0.r
.so as/clup1.r
.so as/clup2.r
.so as/clup3.r
.so as/clup4.r
.so as/clup5.r
.so as/clup6.r
.so as/clup7.r
.if narrow
.ns p
.en
.insert_refs
