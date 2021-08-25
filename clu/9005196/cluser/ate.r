.chapter "A Survey of ATE Languages and Compiler Generators"
.section "ATE Langauges"
.subsection "ATLAS"
	The ATLAS programming language was developed under the sponsorship of
the Airlines Electronic Engineering Committee (AEEC) of Aeronautical Radio, Inc.
(ARINC) to provide for the exchange of test requirements between airline avionics
equipment suppliers and airline engineering and maintainence staffs.  From these
origins, it has grown into a language for stating both test requirements and writing 
test programs.  The acronym ATLAS originally stood for Abbrieviated Test Language for
Avionics Systems.  Later, the term "all" was substituted for the original term
"avionics" in recognition of the wider application of the langauge [ARINC 416].
	Here, we shall only focus on the programming aspects of ATLAS.  ATLAS was
designed to allow the definition of test requirements of the UUT with no reference to 
nor dependence upon the test devices at the test station.  This facilitates the
transportation of test programs from one station to another, providing that the
test requirements can be satisfied by the test devices used at each station.
	ATLAS programs are divided into two sections.  The first, the preamble
section, provides the definition of signals, sensors, loads and procedures for
subsequent reference and use in the actual test.  Statements in this portion of
the program do not actually cause execution of any testing but do simplify and
clarify the text of the second or procedural portion on an ATLAS program.  The
procedural section contains the actual statements necessary to execute the
test.
.begin_figure "ATLAS Program"
.sp 2
	100001	BEGIN, ATLAS PROGRAM$
	C	AUTOMATIC TEST PROGRAM FOR FD-129 PITCH COMPUTER
	C	SIGNAL REQUIREMENTS$
	100020	DEFINE,
	'ACS-1', SOURCE, AC SIGNAL, VOLTAGE ( ) RANGE 0V TO 26V BY 2MV ERRLMT +-1MV,
		FREQ 400HZ ERRLMT +-PC, CURRENT MAX 0.5A, IMP 10000+J0.0 OHM FOR 400 HZ,
		CNX HI ( ) LO ( ) $
	    22	DEFINE,
	'DCS-2', SOURCE, DC SIGNAL, VOLTAGE ( ) RANGE -3V TO 3V BY 2MV ERRLMT +-1MV,
		CURRENT MAX 0.5A, IMP 10000+J0.0 OHM FOR 400HZ,CNX HI ( ) LO ( ) $
	    24	DEFINE,
	'ACS-3', SOURCE, AC SIGNAL, VOLTAGE ( ) RANGE 0V TO 3V BY 2MV ERRLMT +-1MV,
		FREQ 400HZ ERRLMT +-PC, CURRENT MAX 0.5A, IMP 20000+J0.0 OHM FOR 400 HZ,
		CNX HI ( ) LO ( ) $
	C	LOGICAL SIGNAL REQUIREMENTS$
	100030	DEFINE,
	'DCL-1', SOURCE, DC SIGNAL, VOLTAGE ( ) RANGE 18V TO 30V BY 2MV ERRLMT +-0.5V,
		CURRENT MAX 0.5A, IMP 10000+J0.0 OHM FOR 400HZ,CNX HI ( ) LO ( ) CCMMON$

	C	SPEED COMMAND TEST$
	100900	REMOVE, SHORT, CNX HI P4A-30, LO GROUND$

		01 APPLY, 'ACS-1', 0.000V, PIB-30, P1B-20$
		02 REMOVE, 'DCS-2' 0.080V, P1B-32, P1B-22$
		06 VERIFY, (VOLTAGE), DC SIGNAL, LT 0.04V, CNX HI P1B-21 LO P1B-31$
		08 GO TO, STEP 105908 IF NOGO$
		10 APPLY, 'DCL-1', 28V, P1B-44$
		14 VERIFY, (VOLTAGE), DC SIGNAL, NOM 28V LL 24V LL 32V, CNX HI P1B-18
			LO P1B-16$
		16 GO TO, STEP 105916 IF NOGO$
	S$
		19 ADJUST, 'ACS-1', VOLTAGE RANGE 0.0V TO 4.0V BY 0.05V RATE
			50MV/SEC INCREASING
		20 TO MINIMIZE, (VOLTAGE), DC SIGNAL, CNX HI P1B-21 LO P1B-31$
		22 VERIFY, (VOLTAGE), DC SIGNAL, NOM 0.0V LL -0.50V UL 0.50V,
			CNX HI P1B-21 LO P1B-31$
		23 GO TO, STEP 105972 IF NOGO$
		26 VERIFY, (VOLTAGE), AC SIGNAL, NOM 2.8V LL 2.6V UL 3.0V,
			CNX HI P1B-30 LO P1B-20$
		28 GO TO, STEP 105928 IF NOGO$
.finish_figure
.subsection "EQUATE ATLAS"
	EQUATE  -  Electronic Quality Assurance Test Equipment  -  is an
automatic test station for use in the perfromance of acceptance testing
on a wide variety of electronic devices and systems and in the on-line
generation, editing and validation of test programs.  The system is designed
for use by an enginer inexperienced in computer programming [Kelley 72].  EQUATE
was developed by RCA for the U. S. Army Electronics Command [Turkington 75].
	The programming language used on an EQUATE test station is EQUATE ATLAS
[RCA`76],
an adaptation of ATLAS.  The standard vocabulary and syntax of ATLAS are used
almost entirely with minor differences to align the language to the stimulus
and measurement hardware of EQUATE.  
Noun modifiers, in most cases an appropriate modifier
from ATLAS, were selected for each programmable hardware device.  A few new modifiers
had to be designed for the unusual capabilities of EQUATE.  Some extensions to
ATLAS have also been incorporated into EQUATE ATLAS to make the language easier to
use [Kelley 72].
	Automatic resource allocation is not present in EQUATE ATLAS.  The test
programmer must specify the stimulus devices when an ambiguity exists.  This is
done by insertion of a device identifier into the noun field for those stimulus
function where a device ambiguity exists.  When only a single device exists,
the noun identifies it.  For example,
.ls 2
		APPLY DC-SIGNAL DC1, VOLTAGE --- $
.ls 1
		APPLY DC-SIGNAL DC2A, VOLTAGE --- $
		APPLY AC-SIGNAL, FREQ --- $
.ls 2
	EQUATE ATLAS allows a fine degree of control over a test procedure.
.ls 1.5
To allow the programmer the ability to cope with a finite number of stimulus supplies
and test points and with real time timing sequences, it includes the following simple
verbs: SETUP, CONNECT, DISCONNECT, CLOSE and OPEN.
	EQUATE ATLAS may be programmed to perform compuations using FORTRAN
mathematical expressions on measured values and to compute limit values or stimulus
values at run time.  Since these expressions may be used in any statement where a
variable is allowed, the CALCULATE verb, included for compatibility with ATLAS, is
not really needed [Kelley 72].
	Due to the simplification of resource allocation in EQUATE ATLAS, the
language is ATE oriented.  The programmer must think in terms of the test devices
present at the test station.  EQUATE ATLAS, when needed, does provide quite detailed
control of the actual hardware devices.  EQUATE ATLAS has extended the syntax and
semantics of ATLAS to reflect this orientation.
.subsection "VITAL"
	VITAL [Ellis 70] - VAST Interface Test Application Language - was
developed by PRD Electronics, Inc. for use on the U.S. Navy's VAST project.
The VAST - Versatile Avionic Shop Test - system is concerned with automated
general-purpose, real-time testing [Fuller 70].
	VITAL is an adaptation of ATLAS and allows both analog and digital testing.
In analog testing, signals are applied to the UUT and the response is measured.
This type of testing is supported in VITAL by the implementation of a number of
the ATLAS verbs.
	Digital testing is supported by the Digital Subsystem (DSS) of VAST.  This
subsystem was designed to test digital UUT's for logic circuit failures.
.foot
.ls 1
A general digital UUT may be defined as a black box with n input lines and m output
lines which are related by some known combinatorial or sequential logic.  The state
of the n input lines may be thought of as a stimulus to the UUT.  Each unique
combination of logic levels on the m output lines of the UUT may be defined as a
response pattern.  Each response pattern is a function of the UUT logic and the series
of stimulus patterns that have been applied to the UUT after some initial state.  A
logic circuit failure is defined as an output response which differs from correct
value for a given stimulus input [Fuller 70].
.efoot
.ls 1.5
It can
be called by a number of special VITAL verbs.
	During the development of VITAL, the designers were concerned with the
problem of choicing between a high level or low level language.  They recognized
that economy dictates the use of a high level language for general purpose ATE
in order to simplify the task of coding and debugging.  But, at the same time,
they realized that the use of such a language level appears to reduce direct
hardware control, and, as a result, the full hardware capabilities can not
be utilized due to software limitations [Ellis 71].  To solve this problem,
they implemented five different dialects in VITAL.  A dialect can be
considered as an alternative method, within a language, of representing the
same statement.  In this context, it merely means that rather than make the
choice between a high level or low level language, the language will contain
both levels and leave the choice up to the programmer.
	There are five dialects in VITAL.  They range from a UUT oriented to
direct control level of abstraction.  Three of the dialects are concerned with analog
testing.  The other two are concerned with digital testing.
	A VITAL program is divided into two
main sections: a preamble and the procedure.  The preamble section precedes
the procedure and is composed of nonexecutable statements defining the data structures
for the program.  It contains data lists, common core allocations for run time data,
subroutines to be used in the program and definitions of mnemonics to be used in
the procedural section.  VITAL supports character string, binary, hexadecimal, octal,
integer and real data types.  It further allows the definition of lists of these data
types.  The procedural section is the main body of the program and
contains the series of statements that actually execute the test.  It
references the preamble for data and subroutines.  The form of the statements in
the program depends on the dialect being used.
	VITAL supports the definition of subroutines and procedures.  The language is
not block structured and only has simple control constructs.  These include a GOTO,
a conditional GOTO, a DELAY statement and a REPEAT statement for iteration [VITAL 75].
	We shall now discuss the five dialects of VITAL.  The three analog dialects will
be described first.  Then, the two digital dialects will be discussed.
.subsubsection "Test Oriented Language (TOL)"
	TOL is the UUT oriented dialect of VITAL.
The use of TOL permits test requirements to be written in terms of
occurrences at the UUT instead of in terms of detailed commands to the
testing and control devices.
	The TOL dialect is structured very closely around ATLAS and, as such,
the basic language and syntax are almost identical to that of ATLAS.
However, it only contains a subset of ATLAS.  The TOL
verbs can be divided into two types: those implying a source or load function
and those implying a measurement.
	The basic syntax for a statement containing a verb is
	verb	noun	noun modifier	connections
.br
This general format is used throughout the three analog oriented dialects.
	Some of the TOL verbs are listed in Figure .  A few of the TOL nouns
with their modifiers are listed in Figure .  [Ellis 70] contains a larger list
of noun and noun modifiers.
.begin_page_figure "TOL Verbs"
.sp 3
Source and Load Verbs


	APPLY	Sets up a test device to its required mode and
			applies a signal.

	ADJUST	Changes the value of a stimulus parameter by specified increments
			until some desired event occurs.  The event is specified by the
			sensor verbs TO REACH, TO MAXIMIZE or TO MINIMIZE.

	REMOVE	Returns a test device to its quiescent state and removes all
			switching connections.

	SET UP	Reprograms a signal configuration which has already been
			described with an APPLY verb without changing the state of
			the connections.



Sensor Verbs


	MEASURE	Provides switching connections and ranging of one or more test
			devices so that a parameter can be measured.

	MONITOR	Sets a measuring device into a "continuous" or "repetitive" mode
			measurement mode to allow the operator to observe a reading on
			the CRT.

	WAIT FOR	Provides a minimum real-time program delay between statements
			or halts the program pending operator intervention.


	TO REACH
	TO MAXIMIZE	Described above
	TO MINIMIZE
.finish_figure
.begin_page_figure "TOL Nouns and Modifiers"
.sp 4
	NOUN			MODIFIER

	AC Signal		Amplitude
				Frequency
				Load impedance

	AM Signal		Carrier amplitude
				Modulation frequency
				Carrier frequency

	DC Signal		Amplitude
				Maximum current
				

	FM Signal		Modualtion
				Frequency deviation
				Carrier amplitude
				Carrier frequency

	Impedance		Resistance
				Inductance
				Capacitance

	Pulsed AC		Peak amplitude
				Pulse width
				Pulse repition
				Burst length
				Burst period
				Frequency

	Pulsed DC		Peak amplitude
				Pulse width
				Pulse repition
				Burst length
				Burst period
				Frequency
.finish_figure
.subsubsection "Building Block Oriented Language (BBOL)"
	To increase the programmer's control of test situations over that provided
by TOL, BBOL was developed.  It allows access to individual test devices.  While
access is provided, the dialect still retains many of the properties of TOL.
For example, automatic signal routing is provided from information in the connection
field and the verb vocabulary and definition remain essentially the same as in TOL.
In BBOL, however, one must use the actual symbolic name for a device in the noun field 
and so, the dialect is ATE oriented.  Furthermore,
the SET UP verb has a slightly different definition in that after
execution of this verb the output relays of a device will remain open.  This allows
an initialization condition which may later be applied by use of the BBOL verb CLOSE.
This relay action is reversed by the verb OPEN.
Control of the interface paths can be similarly effected by using the BBOL verbs
CONNECT and DISCONNECT [Ellis 70].
.subsubsection "Direct Control Oriented Language (DCOL)"
	The DCOL dialect is the VITAL language equivalent of machine code.  It supports
a direct control level of abstraction and allows
the programmer to exercise the full capabilities of the test devices.
This dialect has five features
which are not found in the other dialects [Ellis 70].
	*  Full control of interface switching is provided.
	*  Compensation for signal degradation may be omitted.
	*  Programming of internal self-check configurations is allowed.
	*  Direct addressing and programming of all test station devices is permitted.
	*  Test devices may be updated with all switches to the interface remaining closed.
.subsubsection "Digital Building Block Oriented Language (DBBOL)"
	The DBBOL dialect is intended for digital testing and is a
representation of the basic machine 
code of the DSS.  As such, it is complex, accessing the full capabilities of the
subsystem.  Basically, the dialect is constructed around an eight verb vocabulary:
START, STOP, CLEAR, LOAD, READ, CONFIGURE, SET UP and NO-OP.  The capabilities of the
language include real-time programming and buffering of data words up to 256 
bits wide at various selectable logic levels.  Its level of abstraction is direct 
control.
.subsubsection "Digital Test Oriented Language (DTOL)"
	DTOL was originally designed to supplement DBBOL and provide a simpler
language for digital testing.  It is also direct control oriented.
The DTOL dialect is, in effect, a library where subroutines
and a set of statement translators are stored.  These translators take 
the CALL instruction in VITAL and
transfer its associated parameters to the subroutine in question.  This approach was 
deemed appropriate since many types of digital tests are standard and with the provision
for entering parameters, standard subroutines can be used to perform the tests.
.subsubsection "Discussion"
	Figure ? shows the statements, taken from [Ellis 71],
necessary to apply a signal to the UUT in the three analog dialects of VITAL.
.begin_figure
.sp 3
	Amplitude-modulated sine wave, 1-volt rms carrier at 1 MHz, 20% modulation
at 10 kHz,
	UUT connections J-7 and J-8, UUT load impedance 50 ohms, J-8 grounded


					TOL			

1. APPLY, AM SIGNAL, 1V, 1MHZ, MOD 20PC, MOD-F 10KHZ, 50 OHM, CNX HI J-7 $


					BBOL

	1.  APPLY, BB20-1, 1.8V, 10KHZ, OFF, INT, HI (BB21,MIHA) $
	2.  APPLY, BB21, 1V, 1MHZ, MOD 20 PC, CNX HI J-7 MIHA (BB20-1, HI) $


					DCOL

		1.  SET UP DC20-1, 1.8V, 10KHZ, OFF, INT, $
		2.  SET UP DC21, 1V, 1MHZ, MOD 20PC $
		3.  CLOSE, BB01, FST, J16-FF, 2J25-L $
		4.  CLOSE, BB01, SLW, J3B05T, G5-4 $
		5.  CLOSE, BB20-1. HI $
		6.  CLOSE, BB21, MIHA $
		7.  CLOSE, BB21, HI $
.sp 3
.finish_figure
The symbols such as BB21 are the names of the test devices.  It is apparent that TOL
is the easiest dialect to understand and use and that DCOL is the most difficult.  The
incorporation of five dialects or languages, each with a different syntax, into one
language is a unique approach to varying
the level of abstraction of a language.  However, the appearance of these five distinct
languages in one language is rather disconcerting.  One would perfer unified constructs
and syntax.
CTL offers a different solution to this problem along these lines.
.subsection "CTL"
	CTL [Warshall 74], 
the Compass Test Language, was developed by Massachusetts Computer 
Associates.  Its design was influenced by ATLAS and contribiuted to the development
of OPAL.  It was designed specifically for the programming of large scale test
procedures to be run on automatic test equipment [Loveman 74] and it supports
the four levels of abstraction described in Section 1.2.
	CTL can describe test procedures for a wide class of UUT's.  One is not
restricted to avionic or electronic equipment.  The language 
contains many of the features found in modern high level programming
languages.  It has a form of block structuring, procedures and powerful control 
constructs.
	The unit of compilation in CTL is either a routine, which is a callable
external procedure, or a common, which is a collection of declarations.  By linking
together common data areas by means of reference statements, many types of data
access can be programmed such as FORTRAN-like COMMON or JOVIAL-like COMPOOLs.
	A routine in CTL consists of declarations, executable statements or internal
procedure definitions.  Declarations may be given for real, integer, boolean,
bitstring and character string variables, and arrays.  Arithmetic, boolean and
bitstring expressions are defined with the usual operators.
	CTL has no built in concept of units of measure.  However, it allows units
of measure to be defined by the programmer.  For example, the declaration:
.ls 2
		DECLARE VOLT, AMP : UNIT
.ls 1
			MV : UNIT .001*VOLT,
			WATT: UNIT VOLT:AMP;
.ls 2
.br
declares VOLT and AMP to basic units, MV to be a thousandth of a VOLT and WATT to
.ls 1.5
be the product of VOLT and AMP [Loveman 73].
	Executable statements may be labelled and branched to by use of a GOTO
statement.  Statements may be grouped together by the keywords DO ... END.
The assignment statement in CTL is preceded by the keyword LET.
Conditional statements are either of the simple form "IF boolean expression 
statement" or the full form "IF boolean expression THEN statement ELSE statement".
	There are several different iteration constructs in CTL.  One may repeat a
statement for a specified number of times, for a specified time period, while or until 
some boolean expression is true or by varying an index variable over a set of values.
	Unlike other testing languages, CTL has no predefined statement types such as
APPLY, MEASURE or ADJUST for expressing contact with the UUT.  Although, the
syntactic definition of CTL allows statements of the form:
.ls 2
	APPLY name WITH name TO name USING name
	REMOVE name FROM name
.br
     MEASURE name FROM name USING name READING component IN units INTO variable
.br
these statements have no meaning in the language.  However, any
.ls 1.5
implementation of CTL will have an underlying base system which has a predefined
meaning.  By use of a facility in CTL called rewrite, statements such as the above
APPLY can be translated into this base system.  The statements in this base system
would be at a direct control level of abstraction.  In most instances, they would be
calls to software driver routines that have been precoded in machine language.  By
using the rewrite facility, it is possible to define more abstract statements which
translate into a series of calls to these software drivers and thus
increase the level of abstraction of the language.
In this manner, CTL supports the four levels of abstraction discussed in Section 1.2.
	Although these statements may be given virtually any meaning by an appropriate
rewrite statement, it is intended that the programmer use them in certain ways.  The
APPLY statement is intended to instruct the system to attach an optionally named
signal source to a named location.  The REMOVE statement is intended to indicate the
detaching of a named signal source from a named location.  Finally, the MEASURE 
statement is designed to indicate the sensing of a certain component of a signal at a
named place and using a particular measuring device.
	In addition, the 
CTL programmer may use any number of named clocks in his program, starting
and recording them at will.  The START clock statement starts a clock at a given value.
The RECORD clock statement stores the current setting of a clock into a variable.  For
example;
.ls 2
	START TIMER1 AT 0 SEC
	RECORD TIMER1 IN MS INTO X
.br
The program may also be delayed for some period of time, until some condition is reached
.ls 1.5
or while a condition holds.
	CTL does not have generalized facilities for real time programming.  However, it
does have a monitoring facility.  A program can be executed while on the side certain
conditions are checked periodically.  If this monitoring indicates a serious condition,
the program is notified in such a way that it can abort the test, notify the operator or
take corrective action.
	CTL also has a powerful branching construct called a multiple choice decision
table.  The general form of a table is shown below in Figure ?.
.begin_figure "Decision Table"


			x1	x2	  ...	xn

		v1	r11	r12	  ...	r1n

		...	...	...	  ...	...

		vm	rm1	rm2	  ...	rmn


.finish_figure
	Each vi is a statement label.  Each xi is a variable and each rij is
a range name.  A range name is defined using the partition statement.
A partition statement describes a set of range names to be associated with a variable.
Each range name has a set of values which are identified with it.  The intent is to
divide the set of real numbers into a finite set of named ranges such that every real
number is within some range.  For example,
		PARTITION Z: LO<3<_ NOM <_ 7 < HI;
.br
The variables at the top of the table must be associated with some partition.
	The table is executed by processing its row, one at a time.  Each row is
processed as follows.  If every entry in the row is satisfied, then a branch is made to
the label at the beginning of the row.  Otherwise, no branch is made for that row.  Each
row is processed independently.
	A program writen in CTL, taken from [Warshall 74], is given below on Figure .  
.begin_page_figure "CTL Program"
.sp 2
ROUTINE OVERALL_GAIN

	REAL F1, F2 K, MIN, MAX, P;

	ROUTINE GAIN
		FOR 2 TIMES DO
			LET F1 = (RANDOM + 1) * 2 + K;
			LET F2 = F1 + .001;
			APPLY ANTENNA_INPUT WITH FREQ = F1 MHZ;
			OUTPUT F2 USING 'MC AND KC CONTROLS TO 00.00000
					PRESS PROCEED';
			DELAY UNTIL MANUAL=INTERVENTION;
			MEASURE OUTPUT_POWER IN WATTS INTO P;
			IF P>MAX THEN LET MAX = P
				ELSE IF P<MIN LET MIN = P END;
		END
	END GAIN;

	OUTPUT 'ADJUST UUT CONTROLS AS FOLLOWS:
		AGC TO ON
		SERVICE SELECTOR TO SSD NSK
		SQUELCH TO OFF
		FREQ VERNIER TO OFF
		AUDIO GAIN FULL CLOCKWISE
		VOX TO PUSH TO TALK
		MC AND KS CONTROLS TO 020000
		PRESS PROCEED' ;
	DELAY UNTIL MANUAL_INTERVENTION;
	APPLY PWR_1;
	DELAY 1 SEC;
	APPLY ANTENNA_INPUT WITH FREQ = 2 MHZ;
	MEASURE OUTPUT_POWER IN WATTS INTO P;
	IF NOT(1.8<_P<_2.2) OUTPUT P USING 'THE 2 WATT AUDIO OUTPUT FAILED
			WITH AUDIO GAIN CONTROL FULL CLOCKWISE.
			MEASURED VALUE #.## WATTS' ;
	LET MIN = P;
	LET MAX = P;
	FOR K = 2, 6, 10, 14, 18, 22, 25.99 CALL GAIN;
	IF MAX/MIN>4 OUTPUT 'OVERALL GAIN AT 1 KHZ EXCEEDS RATIO OF 
			4 TO 1 OVER THE FREQUENCY BAND';
	REMOVE PWR_1;

END OVERALL_GAIN
.finish_figure
The program performs an overall gain check on a receiver.  It checks that the audio
output from the receiver is 2.0 watts with the automatic gain control on when a
signal of 4 microvolts is fed into the antenna input jack.  Also, it determines that
the overall gain over the tuning range of 2.0000 to 29.9999 MHz does not exceed a
ratio of 4 to 1.
	CTL has two important characteristics: the general clarity and elegance of
its structure and its allowance of a varying level of abstraction.  CTL is block
structured and contains powerful looping constructs, conditional statements and 
decision tables.  Modularity is provided by separately compiled procedures, the
block structure of the language and the declarative facility.  Its
syntax is also natural.  Furthermore, it incorporates four levels of abstraction
using the same syntax.  This allows the programmer to defer to a lower level to specify
how a test is to be performed.
All these features contribute to the ease of use and understanding of CTL.
	One criticism of CTL is its rewrite facility.  Through this facility, one can
give the verbs APPLY, REMOVE and MEASURE any possible meaning.  This allows two
implementations of CTL to have verbs with entirely different meanings.  But then, this
feature does allow one to configure a CTL implementation to a given test station.
.subsection "GOAL"
	GOAL [Dickinson 73] -  Ground 
Operations Aerospace Language  -  is a high level test language
developed for NASA by IBM.  
It was designed to perform ground checkout operations in a space
vehicle test and launch environment.  It encompasses a wide range of testing, including
vehicle system and subsystem perflight checkout and ground perflight operations.
	A GOAL program can contain both subroutines and macro definitions.  The two
major components of a GOAL program are declaration statements and
procedural statements.
.subsubsection "Declarations"
	A declaration statement is a non-test action statement that 
declares the type of a 
data item and informs
the compiler to reserve storage and supply initial values for the data.
	GOAL supports four basic data types, called numbers, quantities, texts and
states.  These types are not standard and differ from the data types found in most ATE
languages and high level programming languages.  
When a variable is declared to be of one of these types, it may be initialized
in the declaration statement.
	Numbers, quantities and texts are somewhat similar to stnadard types.
A number is either a positive or negative integer or real number.
A quantity is a number with a unit of measure or
dimensional identifier attached to it or a time
value.  For example,
	 DECLARE QUANTITY (OFFSET) = .5 VOLTS
	 DECLARE QUANTITY (TIME) = 0 SEC
.br
Dimensions are allowed to promote the readability of the statement using or referencing
the data associated with the given dimension.  They associate a number with a particular
unit of measure.  Some of the allowed dimensions in GOAL are listed in Figure /.
.begin_figure "Dimensions in GOAL"
.sp 1
		volt		watt
		ampere		degrees centigrade
		hertz		foot
		ohm		inch
		farad
.finish_figure
A time value allows for a numerical representation of days, hours, minutes, seconds
or milliseconds.
	An element of type text is a character string.
A text data entry may be of fixed length for use as a precanned program message
or be declared as a specific number of characters which may be used to recieve storage
for messages that are input to a test procedure during execution.
	A state represents a boolean constant.  However, instead of the usual two names 
TRUE and FALSE,  GOAL
allows six names for its boolean constants.  They are ON, OFF,
OPEN, CLOSED, TRUE or FALSE.  ON, CLOSED and TRUE are equivalent as are OFF, OPEN and
FALSE.  Thus, GOAL has multiple names for the same boolean constant.
	Besides these basic types, GOAL also supports lists and tables.  A list is in
essence a one dimensional array.  Lists of numbers quantities, states and texts may be
declared with initial values.
	A table is used when it is desired to group information pertaining to a
function designator in one place.  Function designators are items which interface with
the UUT.  Tables are two dimensional arrays.  The first column of the table contains
the function designators.  The remaining columns contains the information associated
with the function designator.  Tables of numbers, quantities, states and texts can be
declared.  This information is initialized on declaration of the table and may not be
changed during execution of the program.
.subsubsection "Procedural Statements"
	Procedural statements are executable statements.  These statements control the
testing sequence by issuing commands, acquiring data from the UUT, controlling the
internal program execution sequence and manipulating data.  There are six types of
procedural statements.
		*  External Test Action
		*  Internal Sequence Control
		*  Arithmetic and Logical Operations
		*  Execution Control
		*  Interrupt Control
		*  Table Control
	External test action statements provide an interface with the UUT.  This group
of statements is divided into two categories; command statements and response
statements.
	Command statements stimulate the UUT.  Command statements access test points on 
the UUT by use of the function designators discussed above.  The classes of command
statements of GOAL are listed in Figure.
.begin_figure "Command Statements"
.sp 2
	APPLY ANALOG		Allows an analog stimuli to be sent to
					the UUT.

	ISSUE DIGITAL PATTERN	Issues a digital pattern to the UUT.

	SET DISCRETE		Allows discrete (ON/OFF) type states to be
					sent to the UUT.

	RECORD DATA		Provides for the output of information to
					a selected peripheral device.
	
.finish_figure
Within ecah class, there are a number of allowable statements.  For example, both
	APPLY 10V TO <RELAY NO. 101>
	SEND (POWER) TO <HYDRAULI SYSTEM>
.br
are APPLY ANALOG statements.  The words within angle brackets are function designators.
	Response statements acquire data from the UUT or the operator.  There are 
three classes of response statements a shown in Figure.
.begin_figure "Response Statements"
.sp 2
	AVERAGE			Provides a convenient means of averaging
					a group of measurements acquired form the UUT.

	READ				Acquires data form the UUT and stores it.

	REQUEST KEYBOARD	Allows the test procedure to request data from
					the test opeator and saves the input for future use.

.finish_figure
	Internal sequence control statements control the execution of the test program.
GOAL contains a DELAY stattements which will delay execution of the next sequential
statement.  Both conditional and unconditional delays are allowed.  GOAL also contains
a GOTO statement and a REPEAT statement which allows the repetition of a single
statement or a group of statements for a specified number of times.
	GOAL provides the capability of manual intervention during execution of a test.
This is done by the STOP statement.  The STOP statement has two options; restricted mode
or unrestricted mode.  The restricted mode option
allows the test program to be restarted only
at perselected points.  Unrestricted mode allows the tset program to be restarted at any
procedural statement within the test program.
	Logical and arithmetic statements in GOAL consist of an IF THEN statement and
an assignment statement.  One can set states to various values and also perform any
necessary mathematical computations.
	GOAL also allows concurrent execution of parts of the test program.  This is 
done by the execution control statements CONCURRENT and RELEASE.  The CONCURRENT
statement allows parallel operations.  This statement has three main options; perform
program, record and verify.  The perform program option allows for concurrent
execution of a test program.  A time value may be specified to achieve a cyclic
execution of a concurrent program.  The record option provides a data monitoring
capability.  A time value may be used to specify the monitoring rate.  The verify
option provides an exception monotoring capability.  A tiem value is used to specify the
monitoring rate.  This statements checks the current reading against a data limit every
cycle but no action is taken unless the current reading falls outside the limit.
Concurrent action can be stopped by the RELEASE CONCURRENT statement.
	The interrupt control statements provide assignment of an interrupt status.
Interrupts, as defined in the test program, can only be honored when they are in an
active status.  There are two statements in the interrupt control group.
	The WHEN INTERRUPT statements enables a language level interrupt.  Only
function designators can be identified as interrupts and this function designator
must also be specified in the data bank as an interrupt.  This statements has two
options; a go to and a subroutine call.  When the WHEN INTERRUPT statement is reached
during execution of the test program, the specified interrupt is activated, but the
referenced subroutine or the go to is not executed at this point.  After execution of
this statement, the remaining procedural statements are executed in their normal
sequence.  However, if the interrupt conditions are met, the nprmal execution of
the program is stopped.  Control is then passed to the statement identified in the go to
or the appropriate subroutine is called.  In the case of a go to, normal execution 
resumes at the target of the go to.  With the subroutine, there are a number of options
as to where execution may resume.
	The DISBALE INTERRUPT statement disbales the interrupt enabled by a WHEN
INTERRUPT statement.  Thus, this statement is the complement of the WHEN INTERRUPT
statement.
	Function designators
can also be assigned active or inactive status by use of the table
control statements.  The ACTIVATE TABLE statement assigns an active status to a table
or individual rows of a table.  This statement only deals with the function designators
and not the data positions.  The INHIBIT TABLE statement is the complement of the ACTIVE
TABLE statement.
.subsection "OPAL"
	OPAL [OPAL 77]  -  Operational Performance Analysis Language  -  is being
developed to
provide a standard ATE language for the U.S. Army.  Its design was based on the ATE
langauges ATLAS, CTL, and GOAL and the programming languages FORTRAN, ALGOL 60 and
PL/I.  The specific contribution of these langauges is outlined in [Brachman 74].
OPAL is still under development.  This summary describes OPAL as it was defined in
January of 1977.
	OPAL is being designed to permit testing in many different areas: electronic, 
mechanical, hydralic or optical.  A program written in OPAL describes a test of
a particular UUT and is independent of the automatic test equipment.  In many respects,
OPAL is similar to a modern high level programming language.
	Statements in OPAL may be categorized as either descriptive or executable.
A descriptive statement gives information to the programming system about the nature
of the named objects with which the program must deal.  An executable statement
describes some activity that the programmer wishes the computer to perform.
.subsubsection "Descriptive Statements"
	Descriptive statements allow the programmer to define five different entities;
		*  data types
		*  procedures
		*  resources
		*  parts of the UUT
		*  ranges of values
	Elements of a data type are declared through the DECLARE statement.
The basic data types of OPAL with their associated operators are given below in Figure ?.
.begin_page_figure "Data Types and Associated Operations"
.sp 2
	integer

		addition		multiplication
		subtraction		exponentiation
		absolute value		max of a finite set
		integer division		min of a finite set


	real

		addition		multiplication
		subtraction		exponentiation
		absolute value		max of a finite set
		division		min of a finite set

	The inequalities <, >, <_, >_ and =/ are equality = which return boolean values
are also defined over the integers and reals.


	boolean

		and			or
		=			=/


	complex

		addition		multiplication
		subtraction		division


	bitstring

		and			or
		exculsive or
		shift left, right
		rotate left, right


	character string

		no operations		
.finish_figure
Besides these basic types, integer, real, complex, boolean, bitstring and character
arrays can be constructed by using the declaration statement.
The DECLARE statement
statement specifies the name of the object, explicitly or by default its initial
value and its type.  If the element being defined is a real variable, a unit of
measure may be associated with it.  OPAL provides an extensive set of built-in units
of measure and has well-defined conversion and consistency checking of units.
	A DEFINE statement gives the properties and definitions of functions and
subroutines.  A function is a procedure which returns a value.  Units of measure may
be associated with this value.  A subroutine does not return a value.  It operates
through side effects on variables.  Subroutines can be given multiple exits by using
the ESCAPE statement.
	The REQUIRE statement establishes the name of a virtual resource device needed
to conduct a UUT test and defines the device characteristics as used in the test
procedure.  Every rsource will, before execution of an OPAL program, be identified
with an actual hardware device.  The REQUIRE statement gives the OPAL compiler the
information necessary to chose an appropriate device.  As an example, consider
.ls 2
	REQUIRE ACS SINE_WAVE VOLTAGE SOURCE
.ls 1
		WITH CONTROL VOLTAGE=1 VOLT TO 10 VOLT BY 100 MV,
				FREQ=50 HZ TO 400 HZ
			CAPABILITY CURRENT <_ 5 AMP
			LIMIT CURRENT=2 AMP
		CNX A IS HI, B IS LO
.ls 2
	In OPAL, the UUT is modeled as a set of test points.  The SPECIFY statement is
.ls 1.5
used to identify the test points on the UUT and the constraints, if any, imposed on 
these test points.
	OPAL also has a PARTITION statement which is similar to the PARTITION statement
in CTL.
.subsubsection "Executable Statements"
	OPAL has a rich variety of control flow statements.  Conditional statements are
either of the form
	IF boolean expression THEN statements END IF
.br
or
	IF boolean expression THEN statements ELSE statements END IF
.br
OPAL allows groups of statements to appear following the THEN and the ELSE.
	OPAL also
has numerous iteration constructs.  One can repeat a group of statements
while or until some condition is true, for a certain time period or by iterating
over an index variable.  OPAL, also, has a LEAVE statement which allows controlled
exit from a compound statement such as a loop or if statment.  The LEAVE statement
causes program execution to resume at the statement following the compound
statement.
	OPAL does have a GOTO statement.  It can not pass control into the range
of another compond statement nor transfer control out of a function, subroutine
or compound statement.  In this manner, OPAL is designed to encourage the use
of structured programming.
	OPAL has a table statement similar to that of CTL.  However, instead of only
allowing a branch to occur when a row of the table is satisfied as in CTL, OPAL
allows any statement to be executed.
	Contact with the UUT in OPAL is accomplished through single action or
multiple action test statements or verbs.  The twelve single action and seven
multiple action test statements are listed in Figure .  Single action test statements
.begin_figure "OPAL Test Statements"
.sp 3
Single Action Test Statements


	SETUP		Causes a named resource to be initialized in a
				specific way.  It commits a virtual device.

	CONNECT		Joins the interface points of the resource to the
				specified interface points on the UUT.

	CLOSE		Causes the signal path to be completed.
	
	START		Causes the named resources to be placed in the active
				state and gates the resources to the UUT causing it to
				operate.

	SENSE			Causes the current value being sensed by the named sensor
				to be read and stored into a specified location.

	STOP			Causes the named resource to be inhibited.

	OPEN			Opens the signal path.

	DISCONNECT		Eliminates the specifed interconnections between connection
				points on the resource and test points on the UUT.

	RESET			Causes the resource to be reset to the quiescent state.

	CHANGE		Causes the value of one or more characteristics of the
				named resource to be changed to a specified value.

	SYNC			Relates a slave device to the corresponding reference device
				and defines the reference point or condition and the
				synchronized point.

	TRIGGER		Relates a slave device to the corresponding reference device
				and defines the reference point or condition and the
				triggered point.

.sp 7
Multiple Action Test Statements



	APPLY		Causes a resource with indicated limitations to be
				connected to a test point.

	INITIATE		Similar to APPLY.

	READ			Causes the current value of a sensor to be recorded
				into a given location.

	MEASURE		Causes a characteristic of the UUT to be measured.

	MONITOR		Causes a characteristic of the UUT to be repeatedly
				measured until the operator intervenes.

	REMOVE		Causes a resource to be disconnected from the UUT.

	RUN			Permits precise time control between CHANGE and READ
				actions.

.finish_figure
allow the programmer to have fairly complete control over his test.  Using them
is somewhat similar to programming in a direct control language.  Here, the
programmer must worry about connecting and disconnecting test devices and verifing that
these operations are done in their proper sequence.  The multiple action test
statements are semantically equivalent to sequences of single action test
statements.  For example, APPLY is semantically equivalent to
.ls 2
		SETUP
.ls 1
		CONNECT
		CLOSE
		START
.ls 2
.br
Through their greater power, they simplify the programmer's task by
.ls 1.5
freeing him from concerning himself with the proper calling sequence of the devices.
	OPAL is still under development and has not yet been implemented.  Additional
work is underway to add an interrupt facility, digital test statements and constructs
and other facilities.  OPAL is being designed to encourage the use of the principles of
structured programming.  Programs written in OPAL may be broken down into labelled
modules which nay be compiled and debugged as self-contained entities.  Commentray may
be included throughout each program unit to enhance its clarity.  OPAL is ATE 
independent and supports a virtual equipment level of abstraction.  Special care is
being taken in its design to insure that all its constructs can be implemented.  Its
documentation [OPAL 77] is well written and easy to understand.  In general, OPAL is
easy to read, write and understand.
.subsection "PROTEST"
	PROTEST [Gill 73]
was developed by ITT Europe with the
intent of designing an understandable and interchangeable language.  
PROTEST is simple in design and uses terms easily recognized by 
engineers.  The language is used for factory testing of printed circuit boards for
semi-electronic switching systems.
	The PROTEST compiler uses two separate passes.  The first pass
performs syntactical analysis.  It checks each language statement for self-consistency
and correct usage.  The second pass performs semantic analysis and code generation.
It does this by using modules from a module library.  If the test facility is 
changed due to a design modification 
or an improved version of the test equipment, it is only
necessary to modify the modules in the module library to adapt the compiler to the 
change.  These modules are changed by using a compiler generation system.  This 
system, when given a group of macro instructions, generates the required modules.
	An example of a PROTEST program, taken from [Gill 73], is given below.
.begin_figure



			1	SEQ
			2	CON	12V	P2	P3
			3	CON	2V	INPUT	P3
			4	READ	1V/1.5V	P4	P3
			5	ACT




.finish_figure
	This program connects power between pins P2 and P3, applies an input voltage
and then checks that the output measured on pin P4 is within the range of 1 volt
to 1.5 volts.  Each statement contains a meaningful word known as an operator.
For example,
CON makes a connection and READ takes a reading.  The operator is followed by suitable
parameters.  For example, the second line of the program contains a command to
connect 12 volts across pins P2 and P3.  The syntactical correctness of these 
parameters is checked by the first pass of the compiler.  The assembly code to execute
this command is generated by the second pass.
	The last statement is an ACT statement.  This command connects the test
devices to the UUT and allows them time to settle.  The measurements are then taken
and the limits checked.  Any failures detected are recorded by the test equipment.
	Other PROTEST operators are given below in Figure ?.
.begin_page_figure "PROTEST Operators"
.ls 1



Test Operators


	SEQ		Marks the start of a test sequence

	CON		Connects a test bay stimulus device to the UUT

	READ		Measures a value and checks that it lies between the
			specified limits

	ACT		Marks the end of a test sequence specification and
			starts the test hardware performing the required
			functions

	WAIT		Delays the action of all operators which follow

	PRINT		Causes test hardware to print a message



Programming Operators


	CALL		Obtains a subroutine from the library and executes it

	LIST 		Allows a name to be given to a string of pin names

	EQUATE	Relates pin names on the plug of the unit to
			user names which may be more convenient for
			the routine writer



Branching Operators


	IF		Conditional branch.  Condition is the success or
			failure of the test sequence

	GOCYCL	Unconditional branch to a cycle operator


.finish_figure
PROTEST is a very simple langauge and does not
provide the programmer with powerful programming language constructs as found in
ATLAS or OPAL.  This could complicate its use in performing involved tests.  On the
other hand, this simplicity makes the language easy to learn and understand.  PROTEST's
syntax appears natural and its mnemonics seem easy to remember.  The language also
supports a UUT oriented level of abstraction.
.subsection "GAELIC"
	The GAELIC language [Stolov 72] - Grumman 
Aerospace Engineering Langauge for Instructional
Checkout - was written for the test engineer who does not possess a detailed
understanding of the composition and operation of the test system.  It was developed
to perform the test and checkout of the aircraft replaceable
assemblies on the EA-6B aircraft.  Two main parts of the GAELIC software are the 
following
		*  the data set compiler
		*  the GAELIC or translational compiler
	The purpose of the data set compiler is to tabulate all the functions of the
station and the commands to execute them.  By initially performing a data set compile
of function names and test station commands, the system engineer presets the compiler 
into its permanent station configuration.  This operation is performed only once when
the design of the station is firm.  Test programs may then be compiled as
available.  If the test station hardware is changed, the test programs are unaffected 
since only a new data set compile would be necessary.  Subsequent recompilation of the
GAELIC programs would then allow them to run on the new facility.
	The basic programming construct in GAELIC is the test sentence.  A test
sentence consists of a verb and a series of pairs of nouns and nouns-modifiers.
These sentences are translated by the GAELIC compiler.  The compiler translates
test sentences into two types of commands;
		*  Test Station Commands
		*  Station Computer Commands
	Test station commands are executable statements that interact with the
test devices.  Some commands are
		connect		readin
		disconnect	reset
		execute		command
		program
	Station computer commands are statements that are operated on by the test 
station computer to further manipulate and convert both input and output data.
		compare		display
		compute		convert
		delay			shift
		if			call
		return
	A GAELIC program consists of a sequence of test sentences.  As stated above,
these sentences consist of a verb and a series of pairs of nouns and noun-modifiers.
The noun can refer to test devices at the test station and the noun-modifiers can
describe actions to be done to these devices.  Consider the following two GAELIC
sentences
		readin		pwrpulse,dvmdata
		compare	pwrpulse,value=dec'27.000,delta=dec'02.000
	The first sentence reads from the digital voltmeter (dvm) a value and stores it
in the variable pwrpulse.  This value is then checked to be within the range
27.000 _+ 2.000.  These two sentences must be preceded by statements which program the
dvm to perform these functions.  GAELIC's level of abstraction is ATE oriented.
	GAELIC, like PROTEST, is a simple language.  It does not contain many constructs
to aid the programmer in coding his routines.  Further, the examples in [Stolov 72]
indicate that its syntax is somewhat cryptic.
.section "Compiler Generators"
	A compiler generator is any program or set of programs which aids in writing
a compiler.  The purpose of the compiler generator is, of course, to simplify the
implementation of a compiler and to that end a compiler generator will contain 
primitives for the types of operations most compilers perform [Gries 68].  A compiler
developed using a compiler generator will most certainly use more memory and compile
programs more slowly than an equivalent compiler developed directly but should ease
development time.
.subsection "UTEC"
	UTEC [Mattison 68], a Universal 
Test Equipment Compiler, is not an ATE language but rather a
compiler generator for automatic test equipment languages.  UTEC was developed by RCA.
The compiler operates in two phases.  In the
generation phase, it accepts the configuration of the test station as well as the
description of the source language and intermediate language.  This information is then
processed and stored into various tables.  Using these tables, the compiler can
operate in a translational phase.  This phase uses the tables to transform the
source language program into an intermediate language
program configured to the desired ATE
system.  This intermediate language program is then fed to an assembler which
generates machine code for the computer used at the test station.
	The flow of information through the UTEC system is depicted below in Figure ?
taken from [Matttison 68].
.begin_figure
.sp 29
.finish_figure
The source language description plus the ATE hardware description is defined to
UTEC using the meta-language SYNSEM (SYNtax and SEMantics) and is input to the
generator.  SYNSEM supports the definition of ATE languages which are tabular in
format, having fixed fields that are generally adhered to, with one field set aside
for function or verb and the remaining fields for modifiers of various types.  Due 
to this restriction, UTEC is only useful for the generation of very simple ATE
languages.  For example, the folllowing sentence [Mattison 68] is from a language
developed using UTEC.
	CONNECT	14.6	VDC	J101-42	J16-23
.br
(Connect 14.6 volts DC between pins J101-41 and J16-23.)  UTEC seems capable of
developing a language in the spirit of PROTEST but incapable of developing a language
like GAELIC which does not have fixed fields.
	From the SYNSEM input, the generator outputs translation tables and equipment
tables for use in the translational phase.  The translator uses the translation tables
to develop intermediate code ready for assembly when given a test program as input.
Whenever ATE equipment must be
specified by the translator, it inserts a symbolic name into the intermediate code.
It also forms a table of these symbolic names matched to the requested equipment.
The equipment designator processes this table, using the equipment table, to
produce equipment assignments for ecah symbolic name.  The assembler processes the
intermediate code from the translator and replaces the equipment symbols with
actual equipment code as supplied by the equipment designator.  This assembler is
dependent on the computer that will control the test equipment.  Note that if the
computer at the test station is changed, it is only necessary to change the assembler.
.subsection "PLACE"
	PLACE - Programming Language for Automatic Checkout Equipment - was developed
by the Battelle Memorial Institute to speed and simplify the development and
implementation of compilers for ATE languages.  Compilers are implemented by means of 
the PLACE processor which operates on the IBM 360 and CDC 6000 series computers.  It
contains extremely powerful and flexible statement definition and code generation
facilities.  The PLACE language itself is concerned solely with these facilities.  It
provides a means for defining the programming statements and for describing how they are
to be translated into code which can be run on the test station computer.  The PLACE
language does not specify the meaning of words as they apply to automatic testing.  The
compiler developer, through the statement definition and code generation facilities,
specifies the meaning of the words and statements and thus develops a compiler 
[Went`71].
	Two primary functions which the compiler must perform are to recognize
syntactically correct statements and to supply the meaning of these statements in
terms of the code of the machine on which the program is to be run.  The compiler
developer implements these operations using the PLACE processor.
	The syntax definition facilities in PLACE are rather unique.  Within the
syntactical definition of the PLACE langauge, there is the full sytnax of an 
ATE language.  So, if the language designer is pleased with the syntax of this basic
PLACE ATE language, he can use it and does not have to concern himself with writing
syntax rules.  On the other hand, if he does not like the basic PLACE ATE syntax, he
can change it as he desires by using the macro definition facility of PLACE.  This
facility translates the new or added statements into statements in the basic PLACE
ATE language.
	The semantics of the basic PLACE ATE language are not defined in the PLACE
system.  They must be defined by the compiler developer.  This is done using form
definitions.  Each form definition is paired with a syntactic construct in the basic
PLACE ATE language.
	A form definition is used to produce the machine code to control a particular
function in the test equipment and is conceptually similar to a subroutine.  A form
has a unique name and may have parameters.  Within the form, there are statements
that test for the absence or presence of parameters, compare parameter values to other
values and specify that particular machine codes be generated as a function of the
parameters and their values.
	A compiler developed using PLACE is made up of the PLACE processor and the
appropriate form and macro definitions.  This system operates as follows.  First, a
statement is recognized using the basic syntax definition and the macro definitions.
Then, the matching form definition is found and the statement is translated into machine
code.
	Figure ? illustrates a program, from [Liguori 71], in the basic PLACE ATE
language.
.begin_figure "Basic PLACE"
.sp 4
		(DCM.,RESET),(TP.,OUT=2530,IN=1936,L=1)$
		(TP.,OUT=2031,IN=1831,L=2)$
		(TP.,OUT=2334,IN=1330,L=3)$
		(DCPWR.,LV1=RESET,LV2=28)$
		(DCM.,R=100,MODE=NORM,SCS=IM)$
		(COMP.,UL=2950,LL=2650,HOLD,CC=IM)$
.sp 4
.finish_figure
It performs a DC voltage test.  Note that the basic PLACE langauge is very cryptic.
	The same program in a language developed using the macro definition facility
is shown in Figure ?.
.begin_figure "Adapted PLACE"
.sp 4
		CONNECT MULTIMETER $	
		TP 51-JJ,TPRET J1-EC $
		USE LINE 3 CONNECT DC SUP LV2 TO J1-11 $
		(DCPWR,LV1=RESET,LV2=28) $
		MEAS PLUS 28VDC PLUS 1.5 MINUS 1.5 $
.sp 4
.finish_figure
	As a final comment, a study by Went [Went 71] has determined that about 75%
of the statements in the ARINC ATLAS specification of March 1971 could be defined
using PLACE with minor variations.