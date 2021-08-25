.if version>0&version<29
.nx clu;clusym r28
.en
.
 meta-symbols and nonterminals
.
.pf A
.nr meta_offset fheight
.pf 0
.nr meta_offset (fheight-meta_offset)/2
.sr lbkt (meta_offset!m)A[*A^*
.sr rbkt (meta_offset!m)A]*A^*
.sr lcurly (meta_offset!m)A{*A^*
.sr rcurly (meta_offset!m)A}*A^*
.sr lparen (meta_offset!m)A(*A^*
.sr rparen (meta_offset!m)A)*A^*
.sr vbar (meta_offset!m)A|*A^*
.pf 5
.nr meta_offset fheight
.pf 0
.nr meta_offset (fheight-meta_offset)/2
.sr orbar (meta_offset!m)5|*5^*
