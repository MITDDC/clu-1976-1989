.chapter "Introduction"
.section "Motivation"
	In the development of our understanding of complex phenomena,
the most powerful tool available to enhance our comprehension is
abstraction. Abstraction arises from the recognition of similarities
between certain objects or processes, and the decision to
concentrate on these correspondences and to ignore, for the
present, their differences [Hoare 72]. In focusing on similarities,
one tends to regard them as fundamental and intrinsic, and to view
the differences as trivial.
	Abstraction from all nonessentials can uncover the kernel of
a subject matter and be of great aid in those cases where a
decisive role is played by the properties picked out and
preserved by the abstraction. But, chiefly, what we desire in an
abstraction is a mechanism which permits the expression of
relevant details and the suppression of irrelevant details
[Liskov and Zilles 74].  In this manner, a good abstraction allows ont to
concenetrate on the essentials of a task without regard to unimportant factors.
	One of the earliest recognized and most useful aids to
abstraction in programming is the self-contained subroutine or
procedure. Procedures appeared as early as 1945 in Zuse's
programming language, Plancalculus [Knuth 76]. Besides, early
developers of programming languages recognized the utility of the
concept of a procedure. Curry, in 1950, described the advantages
of including procedures in the programming languages being
developed at that time by pointing out that the decomposition
mechanism provided by a procedure would allow keener insight into
a problem by permitting consideration of its separate, distinct
parts [Curry 50].
	The existence of procedures goes quite far toward capturing
the meaning of abstraction [Liskov and Zilles 74]. At the point
of its invocation, a procedure may be treated as a "black box",
which performs a specific function by means of an unprescribed
algorithm. Thus, at the level of its invocation, a procedure
separates the relevant detail of what it accomplishes from the
irrelevant detail of how it is implemented. Furthermore, at the
level of its implementation, a procedure facilitates understanding
of how it accomplishes its task by freeing the programmer from
considering why it is invoked.
	However, procedures alone do not provide a sufficiently rich
vocabulary of abstractions [Liskov and Zilles 75]. Procedures,
while well suited to the description of abstract processes or
events, do not accommodate the description of abstract objects. To
alleviate this problem the concept of a data abstraction was
introduced. This comprises a group of related functions or
operations which act upon a particular class of objects with the
constraint that objects in this class can only be observed or
modified by the application of its related operations [Liskov and
Zilles 75].
	A typical example of a data abstraction is a "push down
stack". Here, the class of objects consists of all possible stacks
and the collection of related operations includes the usual stack
operations, like push and pop, and an operation to create new
stacks.
	A data abstraction provides the same aids to abstraction as a
procedure and allows one to separate the implementation details of
a data object from its behavior. At the level of its use or
invocation, the data abstraction isolates the attributes that
specify the names and define the abstract meaning of the associated
operations. At the level of its implementation, the data
abstraction isolates the attributes that describe the representation
of objects and the implementation of the operations that
act upon these objects. Though these different attributes of use
and implementation are, in practice, highly interdependent, they
represent logically independent concepts [Guttag 75].
	My main concern is the first group of attributes which deal
with the specification of the data abstraction. Specification is
important because it describes the abstract object which has been
conceived in someone's mind. It can be used as a communication
medium among designers and implementors to insure that an
implementor understands the designer's intentions about the data
abstraction he is coding [Liskov and Zilles 75].
	Moreover, if a formal specification technique, one with
an explicitly and precisely defined syntax and semantics, is used,
even further benefits can be derived. Formal specifications can be
studied mathematically so that questions, such as the equivalence
of two different specifications, may be posed and rigorously
answered. Also, formal specifications can serve as the basis for
proofs of correctness of programs. If a programming language's
semantics are defined formally [Marcotty`76], properties of a
program written in this language can be formally proved. The
correctness of the program can then be proved by establishing the
equivalence of these properties and the specification. Finally,
formal specifications can be meaningfully processed by a computer
[Liskov and Zilles 75], [Liskov and Berzins 76]. Since this processing
can be done in advance of implementation, it can provide
design and configuration guidelines during program development.
.section "A Prelude to The Parnas Module Specification Technique"
	The information contained in the specification of a data
abstraction can de divided into a syntactic part and a semantic
part [Liskov and Zilles 75]. The syntactic part provides a vocabulary
of terms or symbols which are used by the semantic part to
express the actual meaning or behavior of the data abstraction.
Two different approaches are used in capturing this meaning;
either an explicit, abstract model is supplied for the class of
objects and its associated operations are defined in terms of this
model, or the class of objects is defined implicitly via descriptions
of the operations [Liskov and Zilles 75].
	Parnas [Parnas 72b] has developed a technique and notation,
called a Parnas module, for writing specifications based on the
implicit approach. His specification scheme was devised with the
following goals in mind [Parnas 72b]:
.nofill_list
         1)  The specification must provide to the intended user
         all the information that he will need to correctly use
         the object specified, and nothing more.

.next
         2)  The specification must provide to the implementor all
         the information about the intended use of the object
         specified that he needs to implement the specification,
         and no additional information.

.next
         3)  The specification should discuss the object specified
         in the terms normally used by user and implementor alike
         rather than in some other area of discourse.
.end_list
	When using the Parnas technique, each data object is viewed
as the state of an abstract (and not necessarily finite) state
machine and, in the Parnas module, this state set is implicitly
defined. The basic idea is to separate the operations of the data
abstraction into two distinct groups; those which do not change
the state but allow some aspect of the state to be observed, the
value returning or V-functions, and those which change the state,
the operation or O-functions. The specifications are then written
by stating the effect of each O-function on the result of each
V-function. This implicitly defines the smallest set of states
necessary to distinguish the variations in the results of the
V-functions [Liskov and Zilles 75].
	A problem with this approach is that certain O-functions may
have delayed effects on the V-functions. In other words, some
property of the state will be observed by a V-function only after
some O-function has been used. For example, consider a push down
stack with the operations PUSH, POP and TOP. PUSH has a delayed
effect on TOP in the sense that after a new element has been
pushed on the stack, the former top of the stack element is no
longer observable by TOP but it will be if POP is used.
	Parnas used an informal language to express these delayed
effects [Parnas 72b,75]. In his specifications, he included a
section, called Module Properties, for describing delayed effects
in English, at times interlaced with simple mathematical formulae
[Parnas 75]. For example, to specify the interaction of push and
pop on a stack, Parnas used the phrase "The sequence PUSH(a);POP
has no net effect if no error calls occur" [Parnas 75].
	One method to formally describe delayed effects is to introduce
hidden V-functions to represent aspects of the state which
are not immediately observable. For example, in the specification of a push down stack,
one could introduce a hidden V-function to store the former top of the stack element.
This approach has been followed
by researchers at the Stanford Research Institute [Robinson
75a],[Spitzen 76]. However, their main concern with Parnas modules
is their use in a general methodology for the design, implementation
and proof of large software systems [Robinson 75b],
[Neumann 74].  With this goal in mind, they have designed a
specification language, called SPECIAL, for describing Parnas
modules [Roubine 76]. But, no formal semantics have been provided
for SPECIAL.
	An example of a Parnas module specification using hidden
V-functions is given below in figure 1. Here, the data abstraction
defined is a bounded integer stack with the following operations;
.ls 1
.nofill_list
         push              pushes an integer on a stack
.next
         pop               pops the top of a stack
.next
         top               returns the integer on top of a stack
.next
         depth             returns the number of elements in a stack
.end_list
.begin_figure "Bounded Integer Stack"
.ls 1
.sp 2
		bounded_stack = 1Parnas_module is* push, pop, top, depth

			depth = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value*: 0
				1end* depth

			stack = 1hidden V-function*(i:integer) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value*: undefined
				1end* stack

			top = 1derived V-function*( ) 1returns* integer
				1Appl. Cond.*: ~(depth = 0)
				1Derivation*: top = stack(depth)
				1end* top

			pop = 1O-function*( )
				1Appl. Cond.*: ~(depth = 0)
		 		1Effects*: 'depth' = depth - 1
		 		1end* pop

			push = 1O-function*(a:integer)
				1Appl. Cond.*: depth < 100
				1Effects*: 'depth' = depth + 1
				'stack'(depth + 1) = a
				1end* push

		1end* bounded_stack


.finish_figure
	A Parnas module specification consists of two parts; an
interface description and a collection of function definitions.
	The interface description of a Parnas module provides a very
brief description of the interface which the module presents to
the outside environment. It consists of the name of the data
abstraction being specified by the module and a list of the
functions that users of the data abstraction may employ;

		bounded_stack = Parnas_module is push,pop,top,depth

	The name specified in the interface description, besides
being the name of the data abstraction defined by the module, is
also called, following [Guttag 75], the type of interest.  Users
of a particular Parnas module specification view objects of the
type of interest as indivisible, non-decomposable entities.
However, inside the module, objects are viewed as decomposable
states of the abstract machine implicitly defined by the module.
	Notice that stack is not included in the interface description.
This means it is hidden from users of the module and
can not be accessed by them. Its inclusion in the body of the
module is necessary to describe the delayed effects discussed
above.
	The body of a Parnas module consists of the function
definitions which specify the actions allowed on the type of
interest. A function definition must be given for every action
named in the interface description.
	There are two kinds of functions defined in the body of a
Parnas module, V-functions and O-functions.
	A V-function is defined by first writing its name and then
its mapping description;

			depth = V-function( ) returns integer

The mapping description specifies the type of the function's
parameters and the type of the values it returns. Note that
certain V-functions such as depth and top require no parameters.
Furthermore, the mapping description states which particular type
of V-function, derived, non-derived or hidden, is being defined.
	A non-derived or hidden V-function is a primitive, intrinsic
aspect of the type of interest. However, hidden V-functions
differ from non-derived V-functions in that they can not be
accessed by users of the type of interest. Furthermore, they may
not appear in a module's interface description. In contrast,
derived V-functions are not primitive aspects of the type of
interest but are defined in terms of the other V-functions of the
module.
	After the mapping description, the applicability condition
of a V-function is defined.  This is a Boolean expression which
governs when a call of the V-function succeeds. This expression
may not contain any derived V-functions and must evaluate to true
for any call to succeed. Hidden V-functions are always applicable
(their applicability condition must always be defined as true).
	The applicability condition may constrain a V-function so
that it is only a partial function; i.e. it is not defined for
all elements of its domain. When a V-function is passed a set of
arguments for which it is not defined, an error condition is
raised telling the user what has occurred. However, how the error
condition is handled is viewed here as the responsibility of the
user. The Parnas module only specifies when an error condition is
raised.
	Finally, a section which determines the specific values
returned by a V-function is given. For a non-derived or hidden
V-function, this is the initial value section which specifies the
value returned by calls of this particular V-function in the
initial state of the abstract machine implicitly defined by the
module. The initial value is the basis for the values returned by
the V-function in the other states of the abstract machine.
.keep
	For derived V-functions, a derivation section is given.

			Derivation: top=stack(depth)

..
.end_keep
This section defines the function in terms of the other
non-derived and hidden V-functions of the module.
	An O-function is specified by first defining its name and
mapping description

			push = O-function(a;integer)

and then specifying its applicability condition. As with
V-functions, a call of an O-function only succeeds if its
applicability condition is satisfied, otherwise an error
condition is raised. O-functions do not return any values. They
only change the state of the abstract machine implicitly defined
by the module.
	Now recall that objects of the type of interest are viewed
inside the module as states of this abstract machine.  This point
helps to explain the interpretation of the quotes around the
V-functions in an O-function's applicability condition and
effects section. These quotes are used to represent the result
returned by the V-function in the state of the machine before
completion of an O-function call. An unquoted V-function
represents the function in the new state produced after
completion of the call. This new state is defined by the
equations in an O-function's effects section which redefine the
mappings of certain V-functions in terms of the previous state.
Only non-derived or hidden V-functions may appear in an equation
in an O-function's effects section. Furthermore, non-derived or
hidden V-functions which do not appear on the left hand side of
any equation remain unchanged in the new state.
	Together, the non-derived V-functions, hidden V-functions and
the O-functions implicitly define the state set of a Parnas
module. Note that since the derived V-functions are defined in
terms of the other V-functions, they are not needed to define
this state set. Their main use is to allow users of the module
restricted access to the hidden V-functions. Thus, they help
support Parnas's principle of information hiding [Parnas 72a].
