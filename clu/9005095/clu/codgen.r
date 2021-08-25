 DO NOT MODIFY THIS FILE.  IT HAS BEEN PRODUCED MECHANICALLY.
.dv xgp
.fo 0 20fg
.de hd
.ev header
.rs
.nf
.nr _page \+_page
.vp 0.5i
- \_page -\_name
.ev
'vp 1i
'sp
.ns
.em
.de ft
'bp
.em
.st hd 0
.st ft 10.5i
.eo .75i
.oo .75i
.ll 7.25i
'nf
.sr _name GDEFN
.nr _page 0
.ne 3
       GDEFN CLU

       CLU Compiler Version 3: definition generator

.ne 13
The basic strategy is to transform the abstract syntax into
appropriate macro calls, which can then be compiled with MIDAS.
The following forms will be used in describing the code:
       c{S1;...;Sn} => code for modules or (partial) statements Si
       d{T1;...;Tn} => code for generating descriptors T$i for Ti
       p{E1;...;En} => code for evaluating Ei's and pushing results on the stack
       r{E @ Loc} => code for evaluating E and leaving the result in location Loc
       a{V1,...,Vn} => code for assigning results to named variables
       v{C} => value of a constant C
In general, named objects have both an external (CLU) and an interal (CLUMAC)
name.  If the external name is denoted by Z1, Z2, etc., then the internal name
is denoted by Z$1, Z$2, etc.  Vi denotes a variable, OVi an own variable,
Xi a variable or own variable, Ii a parameter, Ti a type.

.ne 4
If the definition is a procedure or iterator, we get an internal name
for it, and start up a fake cluster if necessary.
At present selector and applytype clusters cannot be generated.  They are
used only in setting up DU specs.

.ne 8
c{C=cluster[I1:T1,...,In:Tn]...;<body>;end C} =>
       d{T1;...;Tn;I1;...;In;up_type;down_type}
       CLUSTER C,up$type,down$type,[I$1,...,I$n]
       c{<body>}
       RETSULC C

up_type and down_type are from the checker.
<body> includes all operations, and any own variables.

.ne 4
d{Ii:Ti} => cpdesc I$i,T$i,i.		for cluster parameters
d{Ii:Ti} => ppdesc I$i,T$i,i.		for procedure and iterator parameters

The last arg is the actual position of the parameter (starting from 1)

.ne 16
c{P=proc[I1:IT1,...In:ITn]...;<body>;end P;} =>
       d{IT1;...;ITn;I1;...;In;proc_type}
       ODUSE
       PROC P$,[I$1,...I$n],[V$1,...,V$m],[TBAD,...TBAD],proc$type
       c{<body>}
       $RTNC $NONE
       CORP P,[V1,...,Vm]

For iterators, ITER and RETI are used in place of PROC and CORP.
We allocate all local variables on module entry. All local variables
are listed in the header (V$i); the TBAD's are their initial values.
The module's type is from the checker.  ODUSE is output if the module
declares own variables, or if the containing cluster has own variables.
$RTNC $NONE is output for all iterators, and for those procedures that
do not return anything. If this is an operation of a cluster 'foo',
then the external name is foo$P instead of P.

.ne 2
The internal names of variables are actually offsets from
the environment register (ER).

.ne 7
c{<OWN statements of a cluster 'foo'>} =>
       ODLINK CF$1,TBOOL+TRUE
       ODUSE
       PROC P$1
       c{<OWN statements with flag CF$1>}
       $RTNC $NONE
       CORP FOO$%%INIT

.ne 14
If a cluster 'foo' has own variables, then the following code is
placed at the beginning of every operation:

       ODGET RR,CF$1
       $IFT; $THEN
       c{foo$%%init()}
       $FI

c{<OWN statements of a procedure or iterator>} =>
       ODLINK PF$1,TBOOL+TRUE
       ODGET RR,PF$1
       $IFT; $THEN
       c{<OWN statements with flag PF$1>}
       $FI

.ne 12
c{<OWN statements with flag F} =>
       c{<OWN statements>}
       ASSN RR,$FALSE
       ODSET RR,F

c{OWN OV1:T1,...,OVn:Tn := E} =>
       ODLINK OV$1,TBAD
       ...
       ODLINK OV$n,TBAD
       c{OV1,...,OVn := E}

In addition, non-anyized objects assigned to variables of type ANY must be anyized.

.ne 3
The internal names of own variables are offsets into the
own data section.  The offset OV$i is defined, and the
variable initialized to 'init', via ODLINK OV$i,init.

.ne 2
To assign to an own variable OV$i, first get the value into RR,
and then do an ODSET RR,OV$i.

.ne 1
To get the value of own variable OV$i into RR, do an ODGET RR,OV$i.

.sr _name GSTMT
.nr _page 0
.bp
.ne 3
       GSTMT CLU

       CLU Compiler Version 3: statement generator

.ne 7
c{V1:T1 := E} => r{E @ V$1(ER)}

c{V1:T1,...,Vn:Tn := E} =>
       r{E @ RR}
       MASSN [V$n(ER),...,V$1(ER)]

In addition, non-anyized objects assigned to variables of type ANY must be anyized.

.ne 16
c{V1 := E} => r{E @ V$1(ER)}

c{OV1 := E} =>
       r{E @ RR}
       a{OV1}

c{X1,...Xn := E} =>
       r{E @ RR}
       MCHECK n.
       a{X1,...,Xn}

c{X1,...,Xn := E1,...En} =>
       p{E1;...;En}
       a{X1,...,Xn}

In addition, non-anyized objects assigned to variables of type ANY must be anyized.

.ne 10
a{V1} => ASSN V$1(ER),RR

a{OV1} => ODSET RR,OV$1

a{V1,...,Vn} => POPS [V$n(ER),...,V$1(ER)]

a{V1,...,Vi,OVj,Vk,...,Vn} =>
       POPS [V$n,...,V$k,RR]
       ODSET RR,OV$j
       POPS [V$i,...,V$1]

.ne 5
c{<invocation>} =>
       r{<invocation> @ RR}
       MFLUSH

MFLUSH is output only if the invocation returns more than one object.

.ne 9
c{while E do <body> end} =>
       $LOOP
       r{E @ RR}
       $IFF;$THEN $GO L1;$FI
       c{<body>}
       $POOL
       $LABEL L1

The test is not output if E is simply TRUE.

.ne 13
c{for <vars> := <invocation> do <body> end} =>
       r{<invocation> @ RR}
       $FOR L1,[]
       c{assignments to vars}
       c{<body>}
       $ROF L1

       <vars>			c{assignements to vars}
       ---------------------------------------------------
       V1:T1			ASSN V$1(ER),RR
       V1:T1,...,Vn:Tn		MASSN [V$n(ER),...,V$1(ER)}
       X1			a{X1}
       X1,...,Xn		MCHECK n.; a{X1,...,Xn}

.ne 11
After an object of type T1 is assigned to a variable V1 of type ANY:

       d{T1}
       ANYIZE V$i(ER),T$1

or for OVi:

       d{T1}
       ODGET RR,OV$i
       ANYIZE RR,T$1
       ODSET RR,OV$i

.ne 15
c{if E then <body1> <elseifs> else <body2> end} =>
       $IF
       r{E @ RR}
       $TEST; $THEN
       c{<body1>}
       c{<elseifs>}
       $ELSE
       c{<body2>}
       $FI

c{elseif E then <body>} =>
       $ELF
       r{E @ RR}
       $TEST; $THEN
       c{<body>}

.ne 18
c{tagcase E <tagarms> end} =>
       r{E @ RR}
       $TAGCASE RR
       c{<tagarms>}
       $ETAGCASE

c{TAG S1,...Sn : <body>} =>
       $TAG [N1,...,Nn]
       c{<body>}

c{TAG S1,...,Sn (V1: T1): <body>} =>
       $TAG [N1,...,Nn]
       ASSN V$1(ER),RR
       c{<body>}

c{OTHERS : <body>} =>
       $TAG []
       c{<body>}

.ne 2
We output selector names as integers; the integer is simply the index
of the selector in the sorted sequence of selector names.

.ne 2
In order to generate code for a tagcase statement, we need to know
the exact type of the tagcase expression.

.ne 9
c{return} => $RTNC $NONE

c{return(E)} =>
       r{E @ RR}
       $RTN RR

c{return(E1,...,En)} =>
       p{E1;...;En}
       $MRTN n.

.ne 10
c{yield} => $YIELD $NONE

c{yield(E)} =>
       r{E @ RR}
       $YIELD RR

c{yield(E1,...,En)} =>
       $FAKEF
       p{E1;...;En}
       $MYIELD n.

.ne 6
c{signal ID(E1,...,En)} =>
       d{cond_type}
       p{E1;...;En}
       SIGNAL cond$type,n.

cond_type is ID(T1,...,Tn) where Ti is the type of Ei.

.ne 5
c{exit ID(E1,...,En)} =>
       p{E1;...;En}
       $GO L1

L1 is a label attached to an $EXCEPT macro.

.ne 4
c{break} => $GO L1			for while loops
c{break} => $ITPOP; $GO L1		for FOR statements

L1 is the label for the end of the innermost loop.

.ne 2
c{continue} => $CONT			for while loops
c{continue} => $RESUME		for FOR statements

.ne 1
c{<stmt1>;...;<stmtN>} => c{<stmt1>};...;c{<stmtN>}

.ne 7
c{<stmt> except <handlers> end} =>
       $CATCH M$1(ER)
       c{<stmt>}
       c{<handlers>}
       $UNCATCH M$1(ER)

We use a temporary variable M$1 to hold the stack pointer

.ne 10
c{WHEN S1,...,Sn (V1:T1,...,Vm:Tm) : <body>} =>
       $EXCEPT M$1(ER),[v{S1},...,v{Sn}],[V$m(ER),...,V$1(ER)],[Li,...,Lj]
       c{<body>}

c{WHEN S1,...,Sn (*) : <body>} =>
       $EXCEPT M$1(ER),[v{S1},...,v{Sn}],[],[Li,...,Lj]
       c{<body>}

M$1 is the temporary used in the $CATCH macro.  The Li are
labels for the Si that have been EXITed to.

.ne 7
c{OTHERS : <body>} =>
       $EXCEPT M$1(ER),[],[]
       c{<body>}

c{OTHERS (V1: T1): <body>} =>
       $EXCEPT M$1(ER),[],[V$1(er)]
       c{<body>}

.ne 1
The force statement is not implemented yet.

.sr _name GEXPR
.nr _page 0
.bp
.ne 3
       GEXPR	CLU

       CLU Compiler Version 3: expression generator

.ne 16
In general:	r{E @ Loc} => r{E @ RR}; ASSN Loc,RR		for Loc ~= RR
       	p{E} => r{E @ RR}; ARGS [RR]
However, there are a few exceptions, which are noted as they appear.

r{V1 @ Loc} => ASSN Loc,V$1(ER)
p{V1} => ARGS [V$1(ER)]

r{<non-type const> @ Loc} =>
       LINK C$1,v{<non-type const>}
       ASSN Loc,C$1(LR)

p{<non-type const>} =>
       LINK C$1,v{<non-type const>}
       ARGS [C$1(LR)]

Except $nil, $true, $false, $neg1, $zero, $one, $two and $nulls are used.

.ne 1
To push Loc onto the stack:	ARGS [Loc]

.ne 1
To move Res to Loc:	ASSN Loc,Res

.ne 1
p{E1;...;En} => p{E1}; ...; p{En}

.ne 7
r{anyize(E) @ RR} =>

       d{T1}
       r{E @ RR}
       ANYIZE RR,T$1

where T1 is the type of E

.ne 11
r{(E1 cand E2) @ RR} =>
       r{E1 @ RR}
       $IFT; $THEN
       r{E2 @ RR}
       $FI

r{(E1 cor En) @ RR} =>
       r{E1 @ RR}
       $IFF; $THEN
       r{E2 @ RR}
       $FI

.ne 11
r{P[C1,...,Cn](E1,...,Em) @ RR} =>
       p{E1;...;Em}
       d{P[C1,...,Cn],m}
       PCALL F$1

r{T$P[C1,...,Cn](E1,...,Em) @ RR} =>
       p{E1;...;Em}
       d{T$P[C1,...,Cn],m}
       PCALL F$1

F$1 is the name for the call block descriptor from the d{...}.

.ne 4
r{force[T1](E) @ RR} =>
       r{E @ RR}
       d{T1}
       FORCE RR,T$1

.ne 4
r{E(E1,...,En) @ RR} =>
       r{E @ M$1(ER)}
       p{E1;...;En}
       XCALL M$1(ER),n.

.ne 3
r{T1$[E1 : E2,...,En] @ RR} =>
       p{E1;E2;...;En}
       ARRGEN n.

.ne 5
r{T1${S1:E1,...,Sn:En} @ RR} =>
       p{E1;...;En}
       RECGEN [Nn,...,N1]

where Ni is the index of Si in the ordered sequence of selector names.

.ne 15
r{P[C1,...,Cn] @ Loc} =>
       d{P[C1,...,Cn]}
       TYPREG Loc,F$1

r{T$P[C1,...,Cn] @ Loc} =>
       d{T$P[C1,...,Cn]}
       TYPREG Loc,F$1

p{P[C1,...,Cn]} =>
       d{P[C1,...,Cn]}
       TYPARG [F$1]

p{T$P[C1,...,Cn]} =>
       d{T$P[C1,...,Cn]}
       TYPARG [F$1]

.ne 7
r{T1 @ Loc} =>
       d{T1}
       TYPREG RR,T$1

p{T1} =>
       d{T1}
       TYPARG [T$1]

.ne 3
r{type_of(E) @ RR} =>
       r{E @ RR}
       GETTYP RR,RR

.ne 3
r{up(E) @ RR} =>
       r{E @ RR}
       CVTUP RR

.ne 3
r{down(E) @ RR} =>
       r{E @ RR}
       CVTDOWN RR

.sr _name GCONST
.nr _page 0
.bp
.ne 3
       GCONST CLU

       CLU Compiler Version 3: constant and type descriptor generator

.ne 9
v{nil} => TNULL+(REFBIT)+NULL$
v{true} => TBOOL+TRUE
v{false} => TBOOL+FALSE
v{<integer>} => TINT+<integer>			if integer >= 0
v{<integer>} => TINT+<integer>&777777			if integer < 0
v{<char>} => TCHAR+<int>
v{""} => tstr+(refbit)+nulls$
v{<non-empty string>} => S$1		from		STRING S$1,<non-empty string>
v{T1} => T$1				from		d{T1}

.ne 1
For v{<string>}, all 'funny' characters must be turned into escape sequences.

.ne 8
d{null} => ttype(tnull)
d{bool} => ttype(tbool)
d{int} => ttype(tint)
d{real} => ttype(treal)
d{char} => ttype(tchar)
d{string} => ttype(tstr)
d{type} => ttype
d{any} => ttype(tany)

.ne 1
d{D[C1,...,Cn]} => TDESC T$1,D,[v{C1},...,v{Cn}]

.ne 3
d{D[S1:T1,...,Sn:Tn]} =>
       d{T1;...;Tn}
       SDESC T$0,D,[v{S1},T$1,...,v{Sn},T$n]

.ne 9
d{proctype (T1,...,Tn) returns (R1,...,Rm) signals (C1,...,Cp)} =>
       d{T1;...;Tn;R1;...;Rm}
       d{C1;...;Cp}
       PTDESC [T$1,...,T$n],[R$1,...,R$m],[C$1,...,C$p]

d{itertype (T1,...,Tn) yields (Y1,...,Ym) signals (C1,...,Cp)} =>
       d{T1;...;Tn;Y1;...;Ym}
       d{C1;...;Cp}
       ITDESC [T$1,...,T$n],[Y$1,...,Y$m],[C$1,...,C$p]

.ne 1
d{T1;...;Tn} => d{T1}; ...; d{Tn}

.ne 3
d{N(T1,...,Tn)} =>
       d{T1;...,Tn}
       EDESC C$1,<altmode>v{N},[T$1,...,T$n]

.ne 3
d{return_type_of(<mod>)} =>
       d{<mod>}
       RTDESC T$1,F$1

