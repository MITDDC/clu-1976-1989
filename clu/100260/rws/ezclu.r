.	^   ==>    exp
.dv xgp
.fo 0 ai:common;25vgx rwskst
.fo 3 fonts;31vgb kst
.fo 4 fonts;sup kst
.fo 5 fonts;sub kst
.fo 6 fonts;25vmic kst
.nr verbose 1
.nr chapter_starts_page 0
.nr tty_table_of_contents 1
.nr both_sides 1
.sr right_heading DRAFT
.sr left_heading DRAFT
.nr print_page1_headings 1
.so r;r macros
.so r;div rmac
.so rws;ezclu rmacs
.ls 1.1
.chapter "EZ_CLU Syntax"

.d Module
procedure  |  iterator  |  cluster

.d Procedure
idn = p_head stmt^ END

.d P_head
PROC [ parm^ ] ( arg^ ) RETURNS ( type^ ) SIGNALS ( except^ ) WHERE restrict^

.d Iterator
idn = i_head stmt^ END

.d I_head
ITER [ parm^ ] ( arg^ ) YIELDS ( type^ ) SIGNALS ( except^ ) WHERE restrict^

.d Cluster
idn = c_head section^ END

.d C_head
CLUSTER [ parm^ ] IS idn^ WHERE restrict^ REP type

.d Parm
idn : type

.d Arg
idn : type

.d Except
name ( type^ )

.d Restrict
idn HAS oper_decl^

.d Oper_decl
name [ const^ ] : type

.keep
.d Const
expr
.or
type
..
.end_keep

.d Section
procedure  |  iterator

.keep
.d Type
NULL  |  BOOL  |  INT  |  CHAR  |  STRING  |  ANY  |  TYPE
.or
ARRAY [ type ]
.or
RECORD [ field^ ]
.or
ONEOF [ field^ ]
.or
PROCTYPE ( type^ ) RETURNS ( type^ ) SIGNALS ( except^ )
.or
ITERTYPE ( type^ ) YIELDS ( type^ ) SIGNALS ( except^ )
.or
ABSTRACT idn [ const^ ]
.or
idn
..
.end_keep

.d Field
name : type

.keep
.d Expr
null_id  |  bool_id  |  int_id  |  char_id  |  string_id
.or
idn [ const^ ]
.or
type $ name [ const^ ]
.or
idn
.or
FORCE [ type ]
.or
UP ( expr )
.or
DOWN ( expr )
.or
( expr CAND expr )
.or
( expr COR expr )
.or
invoke
..
.end_keep

.d Invoke
expr ( expr^ ) ! [ rename^ ]

.d Rename
name TO name

.keep
.d Stmt
decl
.or
decl := expr
.or
idn^ := expr^
.or
idn^ := invoke
.or
decl^ := invoke
.or
invoke
.or
IF expr THEN stmt^ ELSE stmt^ END
.or
WHILE expr DO stmt^ END
.or
RETURN expr^
.or
SIGNAL name ( expr^ )
.or
BREAK
.or
YIELD expr^
.or
BEGIN stmt^ END
.or
TAGCASE expr tagarm^ END
.or
FOR idn^ IN invoke DO stmt^ END
.or
FOR decl^ IN invoke DO stmt^ END
.or
stmt EXCEPT whenarm^ END
..
.end_keep

.keep
.d Tagarm
TAG name ( decl ) : stmt^
.or
OTHERS : stmt^
..
.end_keep

.keep
.d Whenarm
WHEN name ( decl^ ) : stmt^
.or
OTHERS ( idn : STRING ) : stmt^
..
.end_keep

.d Decl
idn : type

.d Null_id
NIL
.d Bool_id
TRUE  |  FALSE
.d Int_id
.d Char_id
.d String_id
.d Name
.d Idn
.translate
.chapter "Semantic Domains"

.width Components
.nr cstop hpos+ll-width
.nr hpos cstop
Components
.d Null
NIL
.d Bool
TRUE + FALSE
.d Int
.d Char
.d String
Char^
.d Oneof
Name & Val
.nr hpos cstop
n, v
.d Proc
Apply & Name
.nr hpos cstop
a, n
.d Iter
[Apply > Apply] & Name
.nr hpos cstop
a, n
.d Apply
Val^ > State > Result
.d Array
Uid
.d Record
Uid
.d Typeobj
Name > Val^ > Val
.d Obj
Null + Bool + Int + Char + String + Oneof +
.br
.nr hpos d_stop2
Proc + Iter + Array + Record + Typeobj
.d Val
Obj & Typeobj
.nr hpos cstop
o, t
.d State
Lmap & Amap & Rmap & Uid & Loc
.nr hpos cstop
l, a, r, u, c
.d Lmap
Loc > Val
.d Amap
Array > Int & Val^
.d Rmap
Record > Val^
.d Cond
NORMAL + RETURN + BREAK + Signal + Error + Special
.d Special
RETURN + BREAK + Signal + Error
.d Env
Imap & Mmap & Typeobj & Typeobj & Apply
.nr hpos cstop
i, m, u, d, a
.d Imap
Idn > Loc
.d Mmap
Idn > Mod
.d Mod
Val^ > Val
.d Result
Cond & Val^ & State
.nr hpos cstop
c, v, s
.d Final
Cond & Val^ & State & Env
.nr hpos cstop
c, v, s, e
.chapter "Semantic Functions"

.d 6E*
(Expr + Invoke + Expr^) > Env > State > Result
.d 6S*
(Stmt + Invoke + Stmt^) > Env > State > Final
.d 6C*
Const > Env > State > Val
.d 6T*
Type > Env > State > Typeobj
.d 6M*
Module > Env > Mod
.d 6P*
Module^ > Mmap > Mmap

.semantic
.section "Star Extensions"

.d 6C*
Const^ > Env > State > Val^
.d 6T*
Type^ > Env > State > Typeobj^
.d 6M*
Module^ > Env > Mod^

.keep
c(const^ e s) # rec 
.if_
const^ is Constzero
.then
nil
.else
Cons(c(Head(const^) e s), c(Tail(const^) e s))
..
.end_keep

.keep
t(type^ e s) # rec 
.if_
type^ is Typezero
.then
nil in Typeobj^
.else
Cons(t(Head(type^) e s), t(Tail(type^) e s))
..
.end_keep

.keep
m(module^ e) # rec 
.if_
module^ is Modulezero
.then
nil in Mod^
.else
Cons(m(Head(module^) e), m(Tail(module^) e))
..
.end_keep
.section "Auxiliary Functions"
 
.d Nr
Result > Result > Result
.d Nf
Result > Env > Final > Final

.keep
Nr(r1, r2) #
.if_
r1!c is NORMAL
.then
r2
.else
r1
..
.end_keep

.keep
Nf(r, e, f) #
.if_
r!c is NORMAL
.then
f
.else
[r!c; r!v; r!s; e]
..
.end_keep
.chapter "Const Clauses"

.keep
c(expr e s) #
r!v to Val
.where r
e(expr e s)
..
.end_keep

c(type e s) #
[t(type e s); Type_type]
.chapter "Type Clauses"

t(NULL e s) #
Null_type

t(BOOL e s) #
Bool_type

t(INT e s) #
Int_type

t(CHAR e s) #
Char_type

t(STRING e s) #
String_type

t(ANY e s) #
Any_type

t(TYPE e s) #
Type_type

t(ARRAY[type] e s) #
Array_type(t(type e s))

t(RECORD[field^] e s) #
Record_type(Field{field^}(e s))

t(ONEOF[field^] e s) #
Oneof_type(Field{field^}(e, s))

.keep
t(PROCTYPE`(type1^)`RETURNS`(type2^)`SIGNALS`(except^) e s) #
		Proc_type(t(type1^ e s), t(type2^ e s), Except{except^}(e, s))
..
.end_keep

.keep
t(ITERTYPE`(type1^)`YIELDS`(type2^)`SIGNALS`(except^) e s) #
		Iter_type(t(type1^ e s), t(type2^ e s), Except{except^}(e, s))
..
.end_keep

.keep
t(ABSTRACT`idn[const^] e s) #
v!o to Typeobj
.where v
(e!m){idn}(c(const^ e s))
..
.end_keep

.keep
t(idn e s) #
v!o to Typeobj
.where v
(s!l)((e!i){idn})
..
.end_keep
.chapter "Expr Clauses"

e(null_id e s) #
[NORMAL; Null_create{null_id} in Val^; s]

e(bool_id e s) #
[NORMAL; Bool_create{bool_id} in Val^; s]

e(int_id e s) #
[NORMAL; Int_create{int_id} in Val^; s]

e(char_id e s) #
[NORMAL; Char_create{char_id} in Val^; s]

e(string_id e s) #
[NORMAL; String_create{string_id} in Val^; s]

.keep
e(idn[const^] e s) #
[NORMAL; v in Val^; s]
.where v
(e!m){idn}(c(const^ e s))
..
.end_keep

.keep
e(type$name[const^] e s) #
[NORMAL; v in Val^; s]
.where v
t{name}(c(const^ e s))
.and t
t(type e s)
..
.end_keep

.keep
e(idn e s) #
.if_
l is Bad
.then
[failure_of_mechanism in Signal; nil; s]
.else
[NORMAL; (s!l)(l) in Val^; s]
.where l
(e!i){idn}
..
.end_keep

.keep
e(FORCE[type] e s) #
[NORMAL; Force(t) in Val^; s]
.where t
t(type e s)
..
.end_keep

.keep
e(UP(expr) e s) #
Nr(r, [NORMAL; replace(v e!u t) in Val^; r!s])
.where v
r!v to Val
.and r
e(expr e s)
..
.end_keep

.keep
e(DOWN(expr) e s) #
Nr(r, [NORMAL; replace(v e!d t) in Val^; r!s])
.where v
r!v to Val
.and r
e(expr e s)
..
.end_keep

.keep
e((expr1`CAND`expr2) e s) #
Nr(r, 
.if_
r!v to Val to Bool
.then
e(expr2 e r!s)
.else
r)
.where r
e(expr1 e s)
..
.end_keep

.keep
e((expr1`COR`expr2) e s) #
Nr(r, 
.if_
r!v to Val to Bool
.then
r
.else
e(expr2 e r!s))
.where r
e(expr1 e s)
..
.end_keep

.keep
e(expr(expr^)![rename^] e s) #
Nr(r2, 
.if_
r3!c is Error
.then
replace(r3 c c)
.else
r3)
.where c
Change{rename^}(r3!c to Error to Name) to Error to Cond
.and r3
(p!a)(r2!v, r2!s)
.and p
v!o to Proc
.and v
r1!v to Val
.and r2
Nr(r1, e(expr^ e r1!s))
.and r1
e(expr e s)
..
.end_keep

.keep
Change{rename^}(n) #
rec
.if_
rename^ is Renamezero
.then
n
.else
.if_
r!1 = n
.then
r!2
.else
Change{Tail(rename^)}(n)
.where r
Head(rename^)
..
.end_keep

.keep
e(expr^ e s) #
rec 
.if_
expr^ is Exprzero
.then
[NORMAL; nil; s]
.else
Nr(r2, [NORMAL; Cons(r1!v to Val, r2!v); r2!s])
.where r2
Nr(r1, e(Tail(expr^) e r1!s)
.and r1
e(Head(expr^) e s)
..
.end_keep
.chapter "Stmt Clauses"

s(decl e s) #
[NORMAL; nil; s; e]

.keep
s(decl`:=`expr e s) #
Nf(r, e, [NORMAL; nil; r!s; e1])
.where e1
[update((e!d) decl!1 r!v`to`Val); update((e!b) decl!1 TRUE)]
.and r
e(expr e s)
..
.end_keep

.keep
s(idn^`:=`expr^ e s) #
Nf(r, e, [NORMAL; nil; r!s; e1])
.where e1
[update((e!d) idn^ r!v); update((e!b) idn^ TRUEinf)]
.and r
e(expr^ e s)
..
.end_keep

.keep
s(idn^`:=`invoke e s) #
Nf(r, e, [NORMAL; nil; r!s; e1])
.where e1
[update((e!d) idn^ r!v); update((e!b) idn^ TRUEinf)]
.and r
e(invoke e s)
..
.end_keep

.keep
s(decl^`:=`invoke e s) #
Nf(r, e, [NORMAL; nil; r!s; e1])
.where e1
[update((e!d) decl^!!1 r!v); update((e!b) decl^!!1 TRUEinf)]
.and r
e(invoke e s)
..
.end_keep

.keep
s(invoke e s) #
Nf(r, e, [NORMAL; nil; r!s; e])
.where r
e(invoke e s)
..
.end_keep

.keep
s(IF`expr`THEN`stmt1^`ELSE`stmt2^`END e s) #
Nf(r, e, 
.if_
r!v to Val to Bool
.then
s(stmt1^ e r!s)
.else
s(stmt2^ e r!s))
.where r
e(expr e s)
..
.end_keep

.keep
s(WHILE`expr`DO`stmt^`END e s) #
		rec Nf(r, e, 
.if_
r!v to Val to Bool
.then
.if_
f!c is NORMAL
.then
s(WHILE`expr`DO`stmt^`END f!e f!s)
.else
f
.else
[NORMAL; nil; r!s; e])
.where f
s(stmt^ e r!s)
.and r
e(expr e s)
..
.end_keep

.keep
s(RETURN`expr^ e s) #
Nf(r, e, [RETURN; r!v; r!s; e])
.where r
e(expr^ e s)
..
.end_keep

.keep
s(SIGNAL`name(expr^) e s) #
Nf(r, e, [name in Signal; r!v; r!s; e])
.where r
e(expr^ e s)
..
.end_keep

s(BREAK e s) #
[BREAK; nil; s; e]

.keep
s(YIELD`expr^ e s) #
Nf(r1, e, 
.if_
r2!c is NORMAL
.then
[NORMAL; nil; r2!s; e]
.else
[r2!c in Special; r2!v; r2!s; e]
.where r2
(e!a)(r1!v, r1!s)
.and r1
e(expr^ e s)
..
.end_keep

s(BEGIN`stmt^`END e s) #
s(stmt^ e s)

.keep
s(TAGCASE`expr`tagarm^`END e s) #
		Nf(r, e, Tag_match{tagarm^}(e, r!s, r!v to Val to Oneof))
.where r
e(expr e s)
..
.end_keep

.keep
s(FOR`idn^`IN`invoke`DO`stmt^`END e s) #
replace(f2 s3 s)
.where s3
replace((f2!s) s!l l)
.and f2
s(invoke e replace2(s x l e e))
.and x
rec /(e2, v^, s1) . [f1!c; f1!v; replace(f1!s f1!e e)]
.and f1
s(stmt^ e3 s1)
.and e3
[update((e2!d) idn^ v^); update((e2!b) idn^ TRUEinf)]
..
.end_keep

.keep
s(FOR`decl^`IN`invoke`DO`stmt^`END e s) #
replace(f2 s3 s)
.where s3
replace((f2!s) s!l l)
.and f2
s(invoke e replace2(s x l e e))
.and x
rec /(e2, v^, s1) . [f1!c; f1!v; replace(f1!s f1!e e)]
.and f1
s(stmt^ e3 s1)
.and e3
[update((e2!d) decl^!!1 v^); update((e2!b) decl^!!1 TRUEinf)]
..
.end_keep

.keep
s(stmt`EXCEPT`whenarm^`END e s) #
.if_
f!c is Error
.then
When_match{whenarm^}(f)
.else
f
.where f
s(stmt e s)
..
.end_keep

.keep
s(stmt^ e s) #
rec replace(f2 e1 e)
.where e1
replace((f2!e) e!b b)
.and f2
.if_
stmt^ is Stmtzero
.then
[NORMAL; nil; s; e]
.else
.if_
f1!c is NORMAL
.then
s(Tail(stmt^) f1!e f1!s)
.else
f1
.and f1
s(Head(stmt^) e s)
..
.end_keep
