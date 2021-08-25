.so clu/refman.insert
.nr chapter 9-1
.chapter "Exception Handling"
.section "Exceptions"
.
.para
A procedure is designed to perform a certain function, taking
some number and types of arguments and returning some
number and types of result objects.  However, in certain
cases (e.g., particular values of arguments), that function
may be impossible to perform.
In such a case, instead of returning normally (which would
imply successful performance of the intended task), the
procedure should notify its caller of its failure
by signalling an 2exception*.
.
.para
For example, consider integer division.  The int$div
procedure takes two integer arguments and returns one
integer result, which is the quotient of the two
arguments.  The type specification of such a procedure
is
.table
	proctype (int, int) returns (int)
.end_table
However, if the second argument to int$div is zero, then
there is no quotient.  In this case, instead of returning,
int$div signals the exception 2zero_divide*.
We include in the type specification of a procedure
a description of the exceptions it may signal, for example
.table
	proctype (int, int) returns (int) signals (zero_divide)
.end_table
which is the actual type specification of int$div.
.
.para
In this section, we will concentrate on exceptions signalled by
procedures.  Exceptions may also be signalled by iterators,
as described in section chapter.?, below.
.
.section "The Exception Handling Mechanism"
.
.para
The CLU exception handling mechanism consists of two parts,
signalling exceptions and handling exceptions.
Signalling is the way a procedure notifies its caller
that it has discovered an exceptional condition.
Handling is the way that the caller of the procedure
specifies what is to be done if the procedure signals
an exception.
.
.para
Signalling an exception is an alternative form of returning.
When a procedure signals an exception, the procedure
activation terminates and control is returned to an
exception handler in the caller.  The signaller may
return objects to the exception handler, to help explain
the exceptional condition.
.
.para
An exception is identified by a name.  A procedure may
signal zero or more exceptions (the names must be distinct),
each with an associated number and types of objects to
be returned to the caller.  An exception name and its
associated list of types is called an 2exception
specification*.  The specifications of the exceptions
signalled by a procedure are part of
the type of the procedure (see section ?).  In addition,
any procedure can signal the exception 2failure*, which
always takes an accompanying object of type string.
The 2failure* exception is implicitly part of all
procedure (and iterator) types; it may not be declared
explicitly.
.
.section "Signalling Exceptions"
.
.para
An exception is signalled by the signal statement, which
has the forms
.table
	signal name
	signal name ( expression lcurly, expression rcurly)
.end_table
The 2name* is the name of the exception to be signalled.
.
.para
The execution of a signal statement begins with the
evaluation of the expressions (if any), from left to right,
to produce a list of 2signal argument* objects.
The activation of the executing procedure is then terminated.
Execution continues as described in section
.nr x section+1
chapter.x, below.
.
.para
The named exception must be either 2failure* or one
of the exceptions listed in the procedure header.
If the exception is 2failure*, then there must be
exactly one signal argument expression, whose
syntactic type is string.  Otherwise, the number
of signal argument expressions must agree with the number
of types in the exception specification in the procedure
header, and the syntactic
types of those expressions must be included in the corresponding
types in the exception specification.
.
.para
A signal statement may appear anywhere in the body of a procedure
or an iterator.
.
.para
The following useless procedure contains a number of examples
of signal statements:
.table 8
.in 8
signaller = proc (i: int) 
signals (foo, bar (int), bletch (string, bool));

	if i < 0 then signal foo; end;
	if i > 0 then signal bar (i - 1); end;
	if i = 0 then signal bletch ("zero", true); end;
	signal failure ("unreachable statement executed");
	end signaller;
.in 0
.end_table
.
.section "Handling Exceptions"
.
.para
When a call to a procedure results in an exception being signalled,
the invocation terminates and the caller is notified of the exception.
The caller specifies what action should be taken
upon a signal by writing an exception handler, using the except
statement.
.
.para
The except statement has the form
.table
	statement except lcurly!handlerrcurly end
.end_table
where a 2handler* is
.table
	handled_list : body
.end_table
We will call the statement to which the handlers are attached S.
The handlers in the except statement handle exceptions
that are signalled by invocations in the statement S
(except those handled by except statements inside
that statement, see below).
Each handler specifies one or more exception names
(the 2handled_list*) and a set of statements
(the 2body*) to be executed if one of those exceptions
is signalled by an invocation within S.
.
.para
If a procedure called within S terminates by signalling an exception E,
and the exception E is not handled by an exception handler within S,
then the execution of S terminates and the attached handlers
are examined to see if any one of them will handle the exception E.
If so, then the corresponding statements in the body of the
handler are executed; when the body terminates, the entire except statement
terminates.  If there is no handler for the exception E,
then the except statement terminates and the search continues
for an exception handler in an enclosing except statement.
If there is no such exception handler in the procedure
or iterator containing S, then the activation of that procedure
or iterator is terminated and it signals the exception 2failure*.
If the exception E is itself 2failure*, then the string
argument associated with the original signal is passed along
as the argument of the new signal.  Otherwise, the name E
is made into a string of the form "unhandled`exception:`E"
(the exception name is in lower case),
and that string is made the argument of the new signal.
.
.para
Thus, when an invocation of a procedure P signals an exception E,
control is passed to the innermost exception handler in Q,
the caller of P, that handles the exception E.  If there is no
such exception handler in Q, then Q itself signals the 2failure*
exception, and the process repeats with the caller of Q.
.
.para
Recall that the infix and prefix operators are merely
syntactic sugar for procedure invocations.  Thus, the
execution of such operators can signal exceptions and these
exceptions can be handled by the procedure containing
the use of the operator.  Appendix ? describes the
primitive CLU procedures and the exceptions that they
signal.
.
.para
A 2handled_list* has the forms
.table
	when name lcurly, namercurly
	when name lcurly, namercurly ( decl lcurly, declrcurly)
	when name lcurly, namercurly ( * )
	others
	others ( idn : typespec )
.end_table
The when forms handle a particular set of exceptions.
The first form is used to handle exceptions with no associated
signal arguments.  The second form is used to handle exceptions
with signal arguments.  Each exception must have the same
number and types of arguments as specified in the formal
argument list.  Within the body of the handler, the
declared formal arguments may be used to access the actual
signal arguments.  The third form can be used to handle
any exception, regardless of whether or not there are
associated signal arguments.  Any actual signal arguments will
be thrown away.
.
.para
All of the exception names appearing in 2handled_list*s in
an except statement must be distinct.  Each exception
must be (potentially) signalled by some invocation
within the statement to which the handlers are attached.
.
.para
The others forms are optional.  At most one may be used in
an except statement, and it must appear last.  An others
handler handles any exception not handled by another
handler in the except statement.  If a formal argument is
declared, it will denote a string object which is the
name of the actual exception, in lower case.  Any signal
arguments will be thrown away.
.
.section "An Example"
.
.para
We now present an example demonstrating the use of
exception handlers.  We will write a procedure, 2sum_stream*,
which will read in a sequence of signed decimal
integers from a character
stream and return the sum of those integers.
2Sum_stream* has the form
.table
	sum_stream = proc (s: stream) returns (int)
			signals (overflow,
				unrepresentable_integer (string),
				bad_format (string));
		. . .
		end sum_stream;
.end_table
2Sum_stream* will signal 2overflow* if the sum of the
numbers is outside the implemented range of integers.
2Unrepresentable_integer* will be signalled if the stream contains
an individual number that is outside the implemented range of
integers.  (2Overflow* is not signalled because the sum
might have been within the implemented range of integers,
if it could have been computed.)  2Bad_format*
will be signalled if the stream contains a 
field that is not an integer.  (The stream is viewed
as containing a sequence of fields separated by spaces;
each field must consist of a non-empty sequence of
digits, optionally preceded by a single minus sign.)
.
.para
We will use the following operation of the 2stream* data type:
.table
	getc = proc (s: stream) returns (char) signals (end_of_file);
		. . .
		end getc;
.end_table
The 2stream$getc* operation returns the next character
from the stream and signals 2end_of_file* if the stream is empty.
.
.para
The following procedure is used to convert character strings to
integers:
.table
	s2i = proc (s: string) returns (int)
		signals (invalid_character (char),
			   bad_format,
			   unrepresentable_integer)
		. . .
		end s2i;
.end_table
2S2i* will signal 2invalid_character* if the string 2s*
contains a character other than a digit or a minus sign.
2Bad_format* will be signalled if 2s* contains
a minus sign following a digit, more than one minus
sign, or no digits.  2Unrepresentable_integer* will be
signalled if 2s* represents an integer that is outside
the implemented range of integers.
.
.para
We now present an implementation of 2sum_stream*:
.table
.in 8
sum_stream = proc (s: stream) returns (int)
		signals (overflow,
			unrepresentable_integer (string),
			bad_format (string));

	sum: int := 0;
	num: string := "";

	while true do
		c: char := stream$getc (s);
		except
		    when end_of_file:
			if (num = "") then return (sum);
			c := ' ';
			end;
		if c ~= ' ' then num := string$append (num, c);
		    elseif num ~= "" then
			sum := sum + s2i (num);
			num := "";
			end;
		end;
	except
	    when unrepresentable_integer:
		signal unrepresentable_integer (num);
	    when bad_format, invalid_character (*):
		signal bad_format (num);
	    when overflow:
		signal overflow;
		end;
	end sum_stream;
.in 0
.end_table
The 2end_of_file* handler is placed immediately after
the invocation of 2stream$getc*.  When end-of-file
occurs, if there is no number being accumulated, then
the handler returns the computed sum to the caller of 2sum_stream*.
Otherwise, execution continues with 2c* denoting a space.
The number 2num* will then be processed as if it had
been followed by a space in the stream.  When 2stream$getc*
is called again, 2end_of_file* will be signalled again,
and this time 2num* will be empty, so that the return
will be performed.
.
.para
We have chosen to place the remaining exception handlers outside
of the while statement, to avoid cluttering up the main
part of the algorithm.  Each of these exception handlers could also
have been placed after the particular statement containing
the invocation that signalled the corresponding
exception.  The (*) form is used
in the handler for the 2bad_format* and 2invalid_character*
exceptions
since the two exceptions have different numbers of signal
arguments and the signal arguments are not used.
Note that the 2overflow* handler catches exceptions
signalled by the int$add procedure, which is invoked
using the infix + notation.
.
.section "The Exception Handling Mechanism, Revisited"
.
.para
Any invocation of a procedure may terminate in one of two ways:
it may terminate normally, returning zero or more result
objects, or it may signal an exception, along with zero or
more signal arguments.  In the latter case, we will say that
the invocation may 2produce* the given exception.
The set of possible exceptions that may be produced by
a procedure invocation is determined from the type of the procedure.
This set always includes the 2failure* exception.
.
.para
If a procedure invocation is a
component of an expression, and the procedure terminates
by signalling an exception E (with associated signal
arguments), then the entire expression immediately terminates,
with the exception E and the associated signal arguments.
The set of possible exceptions that may be produced by an expression
is the set of all exceptions that may
be produced by procedure invocations within that expression.
.
.para
Expressions are embedded in statements.  If,
during the execution of a statement, an embedded expression
terminates with a exception E (with associated signal
arguments), then the statement itself immediately
terminates with the same exception E and signal arguments.
.
.para
Statements may be composed from smaller statements.  In general,
if a component statement terminates with an exception E, then the containing
statement also immediately terminates, with the exception E.
However, if the statement is an except statement, and
the except statement contains a handler that handles
the exception E, then the handler body is executed,
as described in the preceding section.
.
.para
The set of possible exceptions which may be produced by
a non-except statement is the union of the sets of possible
exceptions which may be produced by any component expression or statement.
The set of possible exceptions which may be produced
by an except statement consists of the
set of exceptions which may be produced by the
component statement, minus the set of exceptions handled
by the handlers, plus the set of exceptions that may be
produced by the handler bodies.
.
.para
Thus, any expression or statement may terminate either normally
or with some exception.  The set of possible exceptions
always includes the 2failure* exception.
We require that the set of exceptions that may be
produced by any expression or statement must be disjoint,
that is, for each exception name, there must be a unique
associated number
and types of signal arguments.  When constructing an
expression or a statement, one may use procedures that
signal a non-disjoint set of exceptions.  To
make the set disjoint, one must 2rename* some of the
exceptions, as we will now describe.
.
.section "Renaming Exceptions"
.
.para
Renaming is performed by a renaming clause
attached to the invocation.
The renaming clause has the forms
.table
	[ rename lcurly, renamercurly ]
	idn
.end_table
where a 2rename* has the form
.table
	name lcurly, namercurly to name
.end_table
The first form of 2renaming* specifies a particular set of renamings of
exceptions.  The second form must refer to a previously-defined
set of renamings.
.
.section "Exception Handling and Iterators"
.
.para
