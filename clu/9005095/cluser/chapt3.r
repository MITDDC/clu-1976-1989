.chapter "A Language for Parnas Specifications"
	This chapter presents the syntax and semantics of a specification
language for Parnas modules called ALPS (A Language for Parnas Specifications). 
Section 3.1 describes the syntax of ALPS and Section 3.2 discusses its
semantics.
	The discussion here is concrete, dealing with a specific language and its
semantics.  This chapter is a complement to the abstract discussion in Chapter 2. 
It shows how an actual language can be used to specify Parnas modules and how its
semantics can be defined using the model in Chapter 2 as a guide.  The chapter
concludes with an example discussing a proof that a particular module is
well-defined and consistent.
.section "The Syntax of ALPS"
	An example of a Parnas module specification, described using ALPS,
is given below in Figure 1.  Here, the data abstraction
defined is a bounded integer stack with the following operations.
2Top* is a V-function that is defined as long as the stack is not empty
and returns the top of the stack.  2Depth* is another V-function that reflects
the number of integers in the stack.  2Push* and 2pop* are O-functions that
insert and delete, respectively, integers from the stack.
.begin_figure "Bounded Integer Stack"
.ls 1
.sp 2
		bounded_stack = 1Parnas_module is* push,pop,top,depth

			depth = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value*: 0
				1end* depth

			stack = 1hidden V-function*(i;integer) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value*: undefined
				1end* stack

			top = 1derived V-function*( ) 1returns* integer
			      1Appl. Cond.*: ~(depth = 0)
			      1Derivation*: top = stack(depth)
			      1end* top

			pop = 1O-function*( )
			      1Appl. Cond.*: ~(depth = 0)
		 	      1Effects*: depth = 'depth' - 1
		 	      1end* pop

			push = 1O-function*(a;integer)
				1Appl. Cond.*: 'depth' < 100
				1Effects*: depth = 'depth' + 1
				stack('depth' + 1) = a
				1end* push

		1end* bounded_stack


.finish_figure
	This specification illustrates the three major components of a Parnas
module described using ALPS: the defining abstractions,
the interface description and the definitions of the V-functions and O-functions. 
The interface description provides a brief description of the
V-functions and O-functions that users of the module may employ.  These functions,
along with the hidden V-functions, are fully defined in the body of the
module.  In these definitions, the defining abstractions are used.  Here, they
compose the domain and range of the V-functions and O-functions and, further,
through their associated functions, help specify the meaning of the
V-functions and O-functions.
.subsection "The Defining Abstractions"
	As was discussed in Chapter 1, a Parnas module uses
data abstractions that are distinct from the data abstraction defined by the module. 
These abstractions are called the 2defining abstractions*.  They are assumed to be
defined elsewhere.
	In the remainder of this thesis, in all example specifications,
we shall use the integers and Booleans 
as defining abstractions.  With the integers, we associate the arithmetic 
operations, +, *, -, the inequalities, =/, <, >, <_, >_, and equality =.  With the
Booleans, we associate the usual Boolean operations, ~, 7(*, 7)*, 
the inequality =/ and equality =.  Finally,
the set {@}, where @ is the empty string, will be used as the domain of 
nullary V-functions and O-functions.
	ALMS can, of course, have other defining abstractions besides these two.  We
will, however, leave the actual collection of defining abstractions unspecified and
only assume that it at least contains the integers and Booleans.
.subsection "The Interface Description"
	In ALPS, the 2interface description* of a Parnas module provides
a very brief description of the interface that the module presents
to the outside environment.  It consists of the name of the data abstraction
defined by the module and a list of the functions that users of the module
may employ;
		bounded_stack = 1Parnas_module is* push,pop,top,depth
.br
The list of functions contains the name of every non-derived V-function,
derived V-function and O-function in the module.  The names of hidden
V-functions may not appear in the interface description as they are not available
outside the module.
.subsection "V-functions"
	This section specifies the syntax for the three types of V-functions
of a Parnas module, the non-derived, hidden and derived V-functions.  In the next
section, the syntax of O-functions is given.  Recall
that non-derived V-functions are primitive aspects of the data abstraction defined
by the module.  Hidden V-functions are used to represent aspects of the state that
are not immediately observable and are inaccessible to users of the module.  However,
limited access to them is provided by the derived V-functions, which are defined in
terms of the non-derived and hidden V-functions.
.subsubsection "Non-derived V-functions"
	A non-derived V-function has three sections in its definition, a mapping 
description, an applicability section and an initial value section. The general
schema for defining non-derived V-functions in ALPS is given below in Figure 2.
.begin_figure "Syntax of a Non-derived V-function"


	<2name*> = 1non-derived V-function*(x1:t1;...;xn:tn) 1returns* r
		1Appl. Cond.:* 2Boolean expression for *<2name*>
		1Initial Value:* init
 		1end* <2name*>


where r,ti8*{integer,Boolean} and init8*r  {undefined}

.finish_figure

33.1.3.1.1   The Mapping Description of Non-derived V-functions*

	In ALPS, the 2mapping description* of a non-derived V-function specifies
its name, domain and range, plus the fact that it is a non-derived
V-function.  Its syntax is
		<2name*> = 1non-derived V-function*( ) 1returns* r
.br
for nullary V-functions such as depth in Figure 1 and
		<2name*> = 1non-derived V-function*(x1:t1;...;xn:tn) 1returns* r
.br
for n-ary non-derived V-functions.
	Here, r8*{integer,Boolean} is the 2range* of the V-function.
It is sometimes referred to as the 2type* of the V-function.  The xi are
the 2formal arguments* of the V-function.  They are distinct.  
Also, ti8*{integer,Boolean} is called
the 2type* of the formal argument xi.
	The 2domain* of a nullary non-derived V-function is {@}.  The 2domain*
of an n-ary non-derived V-function v is
			dom v = index(\x i=1 n) ti
.br
	For example, consider the mapping description of depth in Figure 1.
		depth = 1non-derived V-function*( ) 1returns* integer
.br
Here, dom depth = {@}  and  rng depth = integer.

33.1.3.1.2   The Applicability Condition of Non-derived V-functions*

	The 2applicability condition* of a non-derived V-function contains
a Boolean expression that determines the success of a call to the function.
	A Boolean expression is formed through the composition of the non-derived
and hidden V-functions of the module
and the functions associated with the
defining abstractions.  The syntactical correctness of a Boolean expression depends on
the V-function and, in turn, the Parnas module in which it appears.
	 We now turn to the definition of an expression.  Our definitions will be
written as though all expressions were written f(...) although we will use
expressions like x+y with infixes such as + in examples.
	First, let v be any V-function in a Parnas module
PM.  Then, we define an 2expression for v* recursively as follows:

	1)  An integer, Boolean or formal argument of v having type t is an expression
for v of type integer, Boolean or t, respectively.

	2)  If e1, ..., en are expressions for v of type t1, ..., tn
respectively and f is a non-derived V-function of PM, a hidden V-function of PM or
a function associated with one of the defining sets with domain t1 \x ... \x tn
and range r, then f(e1,...,en) is an expression for v of type r.

	Finally, a 2Boolean expression for v* is an expression for 
v of type Boolean.  An 2integer expression for v* is defined similarly.
	Thus, the abstract syntax of the applicability condition of a non-derived
V-function v is
		1Appl. Cond.:* Boolean expression for v

33.1.3.1.3   The Initial Value Section of Non-derived V-functions*

	In ALPS, the initial value section of a non-derived V-function specifies one
element of the V-function's range or contains the word undefined.  This restricts
the mapping associated with the V-function in the initial state of the module to be
either a constant, total function or a totally undefined function.  The latter case is
specified by undefined.
.subsubsection "Hidden V-functions"
	Hidden V-functions are specified in an analogous manner to non-derived
V-functions.  The only difference occurs in the syntax of the mapping description
which contains the word hidden instead of non-derived.  A hidden V-function's syntax
is illustrated below in Figure 3.
.begin_figure "Syntax of a Hidden V-function"


	<2name*> = 1hidden V-function*(x1:t1;...;xn:tn) 1returns* r
		1Appl. Cond.:* 2Boolean expression for *<2name*>
		1Initial Value:* init
 		1end* <2name*>


where r,ti8*{integer,Boolean} and init8*r  {undefined}

.finish_figure
.subsubsection "Derived V-functions"
	A derived V-function also 
has three sections in its definition. They are a mapping
description which only differs from the mapping description of a non-derived or hidden
V-function by use of the word non-derived, an applicability condition which exactly 
follows the syntax of the applicability condition of a non-derived or hidden V-function
and a derivation section which is unique to this type of function.
.begin_figure "Syntax of a Derived V-function"


	<2name*> = 1derived V-function*(x1:t1;...;xn:tn) 1returns* r
		1Appl. Cond.:* 2Boolean expression for *<2name*>
		1Derivation:* defining clause
 		1end* <2name*>


where r,ti8*{integer,Boolean}

.finish_figure

33.1.3.3.1   The Derivation Section of Derived V-functions*

	The 2derivation section* of a derived V-function v contains a clause which
defines v in terms of the other non-derived and hidden V-functions in the module.  Its
syntax is described as follows.
	First, let v be a derived V-function with formal arguments x1,..., xn
and type r.  Now, let e1 and e2 be expressions for v of type r and let b be a
Boolean expression for v.  Then the derivation section for v is of the form
.keep
		1Derivation:*  v(x1,...,xn) = e1
	or
		1Derivation:*  If b then v(x1,...,xn) = e1 else v(x1,...,xn) = e2
.end_keep
.br
	For example, consider the derivation section of top in Figure 1.
		1Derivation:* top = stack(depth)
.subsection "O-functions"
	An O-function also has three sections in its definition.  They are a mapping
description, an applicability condition and an effects section.  The general method of
specifying an O-function in ALPS is shown below in Figure 5.
.begin_figure "Syntax of an O-function"


	<2name*> = 1O-function*(x1:t1;...;xn:tn)
		1Appl. Cond.:* 2Boolean expression for *<2name*>
		1Effects:* equation1
			.
			.
			.
		       equationm
 		1end* <2name*>



where ti8*{integer,Boolean}

.finish_figure
.subsubsection "The Mapping Description of O-functions"
	In ALPS, the mapping description specifies the domain of the O-function and
identifies the particular function as an O-function.  Its syntax is
		<2name*> = 1O-function*( )
.br
for nullary O-functions such as pop and
		<2name*> = 1O-function*(x1:t1;...;xn:tn)
.br
where ti8*{integer,Boolean} for n-ary O-functions such as push.
	The xi are the 2formal arguments* of the O-function.  They are distinct.
Also, ti is the 2type* of the formal argument xi.
	The domain of a nullary O-function is {@}.  The domain of an n-ary O-function o
is
			dom o = index(\x i=1 n ) ti
	The range of the O-function is not specified by the mapping description since it
is understood that the range of any O-function is the state set of the Parnas module.
.subsubsection "The Applicability Condition of O-functions"
	The 2applicability condition* of an O-function contains a Boolean expression
for o.  Its syntax is
		1Appl. Cond.:* Boolean expression for o
	A Boolean expression for an O-function and also an integer expression for an
O-function differ slightly from those of a V-function.  In an expression for an
O-function, every non-derived or hidden V-function appears within single quotes.  For
example, push's applicability condition in Figure 1 is
		1Appl. Cond.:* 'depth'<100
	These quotes are used to represent the result returned by the V-function
before completion of the O-function call.
.subsubsection "The Effects Section of O-functions"
	In ALPS, the 2effects section* of an O-function o contains a group of 
equations which redefine the mappings of the non-derived and hidden V-functions. 
There are two types of equations; basic equations and conditional equations.  A
2basic equation for o* in a Parnas module PM is defined as follows.

	1)  Let v be a nullary non-derived or hidden V-function of PM having type
t and let e be an expression for o of type t.  Then,
			v = e
.br
is a 2basic equation for o*.

	2)  Let v be a n-ary (n>0) non-derived V-function or hidden V-function of
PM having type t with formal arguments xi of type ti.  Now let e be an
expression for o of type t and ei be expressions for o of type ti.  Then,
			v(e1,...,en) = e
.br
is a 2basic equation for o*.

	A conditional equation for o employs basic equations on its definition.
	Let eq1 and eq2 be basic equations for o and let b be a Boolean
expression for o.  Then,
			1if* b 1then* eq1
	and
			1if* b 1then* eq1 1else* eq2
.br
are 2conditional equations for o*.	
	Finally, the effects section 
of an O-function contains a listing of conditional and basic equations.
.ls 1
		1Effects*: eq1
			.
			.
			.
			eqm
.ls 1.5
.br
The ordering is immaterial.
	As an example, consider push's effects section which contains two basic
equations.
.br
.ls 1
		1Effects:*  depth = 'depth' + 1
			stack('depth' + 1) = a
.ls 1.5
.section "The Semantics of ALPS"
.subsection "The State Set"
	As previously mentioned in Chapter 2, a state of a Parnas module is completely
specified when the mapping associated with each non-derived and hidden V-function 
of the module is given.  Hence, we view the state set, SPM, of a Parnas module
PM in the following manner:

		SPM  [dom v1  rng v1] \x ... \x [dom vn  rng vn]

where {v1,...,vn} is the set of non-derived and hidden V-functions of PM.
.foot
Recall [A  B] = {f|f is a function and dom f = A and rng f = B}
.efoot
Note that dom vi and rng vi are defined in Sections 3.1.3.1.1 and 
3.1.3.2 on mapping descriptions.
	As before, we shall denote
[dom v1  rng v1] \x ... \x [dom vn  rng vn] by 9D*PM.
	Our purpose in this section is to define SPM.  Here, we shall use the same
generative approach outlined in Section 2.2.1. Recall this method uses the initial
state of the module, QPM, to 
generate the state set by means of the following construction:
.br
.ls 1
.keep
		1) QPM is an element of SPM.

		2) If q is an element of SPM and o is an O-function call,
		then the state q' obtained by applying o to q is an element of SPM.

		3) These are the only members of SPM.
.end_keep
.ls 1.5

So, to define SPM, it suffices to define the initial state of the module and
then to describe the state change caused by an O-function 
call.
	The initial state is defined as follows.

.ls 1
.keep
	Definition
	Let PM be a syntactically correct Parnas module specification written in ALPS.
	Let {v1,...,vn} be the set of non-derived and hidden V-functions of PM.
	Then,
		QPM = (initv1,...,initvn)
where


				0/			if vi's initial value section
							contains the word undefined

		initvi =

				{(a,b)|a8*dom vi}		if vi's initial value
							contains b8*rng vi


	is the 2initial state* of PM.
.end_keep
.ls 1.5


	To define the next state function of a Parnas module PM specifed 
in ALPS, it is necessary to define, in general, how an
O-function call maps one member of 9D*PM into another. We now turn to
this topic.
	The basic components of an O-function's effects section are the Boolean and 
arithmetic expressions which are used to build the basic equations and the
conditional equations.  These expressions are formed by composing the functions
associated with the integers and Booleans and the non-derived and hidden V-functions 
of PM.  So, the first step in defining the next state mapping is to specify the
meaning of these expressions.
	Their meaning 
is dependent on two items.  First, it depends
on the particular O-function call o(a), where a8*dom o, since, in general,
the expressions will contain formal arguments from the O-function's definition.  Actual
values must be substituted for these formal arguments.  Second, the meaning of the
expressions depends
on the member R8*9D*PM since R gives an interpretation to the 
non-derived and hidden V-functions.  Note that the functions 
associated with the integers
and Booleans have a constant fixed interpretation and are independent of members of
9D*PM.
	So, let R8*9D*PM and let o be an O-function of PM with
expression e appearing in some equation in o's effects section.  Finally, let
(a1,...,an)8*dom o.  Then to find the meaning of e, we can
proceed as follows.

	1)  First, substitute ai for every occurrence of its corresponding
formal argument in e, obtaining e'.  Note, if dom o = {@}, this step is 
unnecessary since o has no formal arguments.

.width |
.nr vbarwidth width
.de defchar
|
.nr hpos hpos-vbarwidth
A=*
.em
	2)  Now, to evaluaute e', we shall view R as an interpretation or
environment which specifies, for each symbol A, the value AR of A in R. 
If A is an integer, Boolean or one of their associated functions, then AR
is simply A.  If A is a non-derived or hidden V-function, then AR is the
function associated with A in R.  The value of E' = A(E1,..,Ek) in R, following
[Pratt 77], will be denoted by R defchar() E' and is defined by
		R defchar() A(E1,...,Ek) = AR(R defchar() E1,...,R defchar() Ek)
.br
Since the non-derived and hidden V-functions may not be associated with total functions
in R, it is possible that R defchar() E' is undefined.

	Thus, as outlined above, we can define a semantic function 6p*(R,e,o(a))
for R8*9D*PM, expressions e in o's effects section and 
a8*dom o such that
			6p*(R,e,o(a)) = R defchar() e'

	This function is used to specify the meaning of the equations in an
O-function's effects section.  These equations modify the mappings associated with
the various non-derived and hidden V-functions of the module by changing the value
associated with one element of their domain.
	Let R8*9D*PM and consider the basic equation
				v(w) = b
.br
appearing in an O-function o's effects section.  Then any call o(a) of o, where
a8*dom o, would change vR to the function

				6p*(R,b,o(a))	if x = 6p*(R,w,o(a))

		f(x) =

				vR(x)		if x =/ 6p*(R,w,o(a))

	To help indicate such a function, we shall use the notation bx,y
developed in Chapter 2.  Recall this notation has the value x if b is 1true*
and value y if b is 1false*.  So, for f above, we have
		f = @x.[(x=6p*(R,w,o(a)))6p*(R,b,o(a)),vR(x)]
	Using this notation, we define in Figure 6 an effects function
		E(R,o(a),Eq)
.br
mapping into 9D*PM,
which specifies the change equation Eq causes on R during the call o(a).
For example, consider R, o(a) and v(w) = b above.  Here, E(R,o(a),v(w) = b) = R'
where vR' = f and the mappings associated with the other non-derived and
hidden V-functions remain unchanged.
.begin_figure "Effects Function E"
.sp 1
	Definition
	Let PM be a syntactically correct Parnas module specification written in ALPS.
	Let R8*9D*PM.
	Let o be an O-function of PM with Eq appearing in o's effects section 
and let a8*dom o.
	Finally, let v1, ..., vn be the non-derived and hidden V-functions of PM.
	Then E(R,o(a),Eq) is defined as follows;

	   i) If Eq is a basic equation of the form  2vi = e*  where vi is a parameter-less V-function,

		E(R,o(a),Eq) =  (v1R,...,vi-1R,{@,6p*(R,e,o(a))},vi+1R,...,vnR)

	   ii) If Eq is a basic equation of the form  2vi(w) = e*  then

		E(R,o(a),Eq) =  (v1R,...,vi-1R,@x.[(x=6p*(R,w,o(a)))6p*(R,e,o(a)),viR(x)],vi+1R,...,vnR)

                                  
	   iii) If Eq is a conditional equation of the form  2if c then s*, then

					R		if 6p*(R,c,o(a)) = 1false*
                                 
	            E(R,o(a),Eq) = 
                                 
                                 
					E(R,o(a),s)	if 6p*(R,c,o(a)) = 1true*
                               


	   iv) If Eq is a conditional equation of the form  2if c then s1 else s2*, then


					E(R,o(a),s1)		if 6p*(R,c,o(a)) = 1false*                                   

                                   
	           E(R,o(a),Eq) =  

                                   
                                   
					E(R,o(a),s2)		if 6p*(R,c,o(a)) = 1true*
                                   

.finish_figure
	To define the next state function, we need an extended version of E which
takes into account the effect of a number of equations.

.ls 1
.keep
	Definition
	Let PM be a syntactically correct Parnas module specification written in ALPS.
	Let o be an O-function of PM with equations Eq1,...,Eqm in its
effects section.
	Let a8*dom`o.
     Then
           TE(R,o(a),Eq1,...,Eqm) = E(...E(E(R,o(a),Eq1),o(a),Eq2),...,Eqm)
.end_keep
.ls 1.5


	 TE(R,o(a),Eq1,...,Eqm) corresponds to 9T*o(R,a) in Chapter 2.
So, we can define the next state function as follows.

.ls 1
.keep
	Definition
	Let PM be a syntactically correct Parnas module specification written in ALPS.
	Let o be an O-function of PM with Boolean expression b in its applicability
condition
	and equations Eq1,...,Eqm in its effects section.
	Let a8*dom o and R8*9D*PM.
	Then,

					TE(R,o(a),Eq1,...,Eqm)		if 6p*(R,b,o(a))=1true*

		NEXT(R,o(a))  =

					R				if 6p*(R,b,o(a))=1false*
.end_keep
.ls 1.5


	Again, we must consider the question of whether or not NEXT is well-defined.
This is dependent on 6p* and TE.  Recall that 6p* is not necessarily a total function.  So, it is
possible for some state s and x8*dom o that 6p*(s,b,o(x)) is
undefined.  Also, TE is not necessarily total so we can encounter a similar situation.
These two cases correspond to the problem, discussed in Chapter 2, when 
9A*o(s,x) and 9T*o(s,x) are undefined.
	There is a further problem with TE(R,o(a),Eq1,...,Eqm) that we must
consider.  We have defining the ordering of the equations Eq1,...,Eqm as
immaterial.  However, it is possible for some state s and a8*dom o that
TE(R,o(a),Eq1,...,Eqm) =/ TE(R,o(a),Eq4p*(1),...,Eq4p*(m))
where 4p* is a permutation from {1,...,m} onto {1,...,m}.  In this case, TE
would be nondeterministic in the sense that its value depends on the choice of the
order of the equations Eq1,...,Eqm.
	To handle these situations, we must introduce the notion of a well-defined 
Parnas module.  Due to the last case, the definition differs slightly from that of
Chapter 2.

.ls 1
.keep
	Definition
	Let PM be a syntactically correct Parnas module specification written in ALPS.
	Then PM is 2well-defined* if for any sequence of O-function calls o1(a1),...,on(an)
	where ai8*dom oi, oi is an O-function of PM and n>_1,
	both
		1)   NEXT(...NEXT(NEXT(QPM,o1(a1)),o2(a2)),...,on(an)) is defined 
	and 
		2)   TE(S,on(an),Eq1,...,Eqm) = TE(S,on(an),Eq4p*(1),...,Eq4p*(m))
.br
			where equations Eq1,...,Eqm appear in on's effects section,
			S = NEXT(...NEXT(NEXT(QPM,o1(a1)),o2(a2)),...,on-1(an-1))
			and 4p* is any
permutation from {1,...,m} onto {1,..,m}.
.end_keep
.ls 1.5


	Finally, we can define the state set of a well-defined Parnas module.  The 
definition is the same as in Chapter 2.

.ls 1
.keep
	Definition
	Let PM be a well-defined Parnas module specification.
	Let 9O* be the set of O-functions of PM.
	Then the state set SPM of PM is defined as follows
	1) QPM8*SPM.
	2) If R8*SPM  and o8*9O*, then NEXT(R,o(a))8*SPM where a8*dom o.
	3) These are the only elements of SPM. 
.end_keep
.ls 1.5

	Note that in 2) above NEXT(R,o(a)) is always defined since PM is well-defined.


.section "The Semantics of V-functions and O-functions"
	With this definition of the state set SPM of a well-defined Parnas module
specification, it is now possible to formally define the meaning of
the O-functions and V-functions. As in Chapter`2, this will be done by defining
mappings V-Eval for V-functions and O-Eval
for O-functions such that
.keep

		V-Eval:[SPM \x NV]  [A  R]
	and
		O-Eval:[SPM \x NO]  [A  SPM]

.end_keep
where NV is the set of V-function names, A is the set of
arguments, R is the set of results and NO is the set of
O-function names. 
	O-Eval will be defined first.  Now, given a state s and an O-function
o of a well-defined Parnas module PM with Boolean expression b in its applicability
condition,
O-Eval returns a function from dom o into SPM  {error}.
So, using lambda notation,

	O-Eval(s,o) = @a.[6p*(s,b,o(a))NEXT(s,o(a)),error]

	Note that O-Eval(s,o) is always a total function since in a well-defined
Parnas module NEXT(s,o(a)) and 6p*(s,b,o(a)) are always defined.
	For any V-function v and state s, V-EVAL will return a function from
dom v into rng`v``{error}.
First, for a non-derived or hidden V-function v and a state s, recall that vs
denotes the function associated with v in state s.  Then for any non-derived or hidden
V-function v with expression b in its applicability condition,

	V-EVAL(s,v) = @a.[6p*(s,b,o(a))vs(a),error]

	Finally, for a derived V-function v with expression b in its
applicability condition, there are two cases.

	i) If v's derivation section contains 2v(x1,...,xn) = e*, then

	V-Eval(S,v) = @a.[6p*(s,b,o(a))6p*(s,e,o(a)),error]

	ii) If v's derivation section contains 2if B then v(x1,...,xn) = e1 
else v(x1,...,xn) = e2*, then

	V-Eval(S,v) = @a.[6p*(s,b,o(a))[6p*(s,B,o(a))6p*(s,e1,o(a)),6p*(s,e2,o(a))],error]

	As mentioned in Chapter 2, V-Eval(s,v) is not necessarily a total function
from dom v into rng`v``{error}.  When
this is not the case, we say the Parnas module is consistent.  The definition
is the same as in Chapter 2.

.ls 1
.keep
	Definition
	Let PM be a well-defined Parnas module specification.
	Then PM is 2consistent* if V-Eval(s,v) is a total function from dom v
into rng v  {error}
	for every state s8*SPM and V-function v of PM.
.end_keep
.ls 1.5

.section "An Example - To Be Completed"
	In this section, we present a proof that a particular Parnas module is
well-defined and consistent.  Our example specification is illustrated in Figure 7.
This data abstraction is a queue with three
operations;
.ls 1

	insert            adds an integer to the rear of the queue

	delete            removes the integer at the front of the queue

	first_element     returns the integer at the front of the queue

.ls 1.5
Note this queue can hold an arbitrary number of integers.
.begin_figure "Queue"
.sp 2
		queue = 1Parnas_module is* insert,delete,first_element

		     first_element = 1derived V-function*( ) 1returns* integer
		                     1Appl. Cond.:* ~(front = back - 1)
		                     1Derivation:* first_element = storage(front)
		                     end first_element

		     front = 1hidden V-function*( ) 1returns* integer
		             1Appl. Cond.: true*
		             1Initial Value:* -1
		             end front

		     back = 1hidden V-function*( ) 1returns* integer
		            1Appl. Cond.: true*
		            1Initial Value:* 0
		            end back

		     storage = 1hidden V-function*(i;integer) 1returns* integer
		               1Appl. Cond.: true*
		               1Initial Value:* undefined
		               end storage

		     insert = 1O-function*(i;integer)
		              1Appl. Cond.: true*
		              1Effects:* storage('back' - 1) = i
		                       back = 'back' - 1
		              end insert

		     delete = 1O-function*( )
		              1Appl. Cond.:* ~('front' = 'back' - 1)
		              1Effects:* front = 'front' - 1
		              end delete

		end queue
.finish_figure
