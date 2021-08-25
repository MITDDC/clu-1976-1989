 meta-symbols		(large boldface characters)


 string register		what it contains
   lbkt				[
   rbkt				]
   lcurly				{
   rcurly				}
   lparen				(
   rparen				)
   orbar				|
   etc				...
.
.
.fs A
.nr meta_offset fheight
.fs 0
.nr meta_offset (fheight-meta_offset)/4
.sr lbkt (meta_offset!m)A[*
.sr rbkt (meta_offset!m)A]*
.sr lcurly (meta_offset!m)A{*
.sr rcurly (meta_offset!m)A}*
.sr lparen (meta_offset!m)A(*
.sr rparen (meta_offset!m)A)*
.sr orbar (meta_offset!m)A|*
.sr etc A...*
