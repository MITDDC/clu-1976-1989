.chapter "Language Requirements for Automatic Test Equipment"
.section "Automatic Test Equipment"
	The requirements imposed by the highly complex devices that
have resulted from technological advances in the defense industry,
avionics and communications have created a need for faster and more
sophisticated methods of testing.  No longer can the engineer depend solely
on the primitive, manual, bench-type set up that had prevailed in
earlier periods.  Automatic testing, which began in the 1950's, is a
response to the pressing needs of this new and more exacting 
technological growth.
	The original efforts in automatic testing were the results of
engineering attempts to duplicate man's actions on a one at a time basis.  After
World War II, industry began searching for better ways to handle the increasing 
complexity of electronics.  The engineer was often faced with the problem of how to
increase the test speed or the number of tests within a given time span
without sacrificing essentials such as accuracy or range tests.  The simplest
approach was to use recognized techniques and to mechanize the human functions
which were most often repeated [Lustig 73].
	These early efforts at automation were one step above the hand-held
manual checking of, say, each wire with a pair of leads hooked to a meter.
The logical outgrowth of this simple method was the replacement of the
manual operation with an electronically operated stepping switch which ran through
the entire checking procedure in less time than the manual method [Lustig 73].
	In the early 1950's, the thrust of automatic test stations was directed to
controling the test equipment through stepping switches, cam and motor setups and
relays.  The test stations were essentially electro-mechanical and
analog in nature [Lustig 73].
	With the advent of the computer, this picture changed.  The computer offered
more speed, greater capabitity
to perform a variety of operations, larger
storage capacities and more adaptablity to changing requirements than previous test
station configurations.  With these
important advantages in versatility and speed, the computer established the basis for
keeping pace with the advancing requirements of testing.  And so, the computer has
become an integral part of modern automatic test stations.
	Testing of an object, today as before,
involves the concept of applying a stimulus to the object
and analyzing the responses to this action.  This paradigm
is based on the assumption that a faulty device
will respond to a stimulus in a different manner than a good device.  The stimuli
applied to the object being tested may
be of many different types; electrical, mechanical or audio.
For example, on the U.S. Navy's SIMETS test station [ref] the devices being
tested will be placed on a centrifuge.  In this example, the stimulus is applied
to the entire device.  However, in other cases, stimuli may reasonably be
applied to only certain places on the object being tested or even one specific place
[Loveman 73].  Further, the equipment that receives and analyzes 
the responses from these stimuli are as varied as the stimuli themselves.  They can
include voltmeters, power supplies, signal generators or frequency meters to name a
few devices.
	The components of a modern automatic test station are depicted below in
Figure 1.
.begin_figure "An Automatic Test Station"
.sp 8
	computer			ATE				UUT
.sp 8
.finish_figure
The computer controls the operation of the test station.  It is usually a
minicomputer such as a Hewlett Packard 2100 or 21 MX or a Varion 622.  The
computer provides the test engineer with an interface to the test station.  Using
the computer, he
directs the tests he wishes to perform and receives the results of these tests.
	The computer sends and receives signals from the automatic test
equipment (ATE).  It sends signals guiding the performance of the test and
receives signals indicating the results of various phases of the test.
Physical ATE is highly varied.  For example, it can
include digital voltmeters, power supplies, time base generators or switching
matrices.  The type of equipment depends on the testing being performed and
the object being tested.
The computer controls the hookup of these devices to the unit under
test (UUT) and determines the signals that these devices will send and receive
from the UUT.
	The UUT is the object being testing.  In most current automatic test stations,
the UUT is modelled as a group of test points or pin locations where stimuli may be
applied or readings taken.  The UUT can be a piece of avionics
equipment such as an inertial measurement unit or a piece of electronic
equipment such as an electronic switching system.  Today, a myraid of different
objects are being tested on automatic test stations.
	The complexity of interaction between the components of an automatic
test station also varies greatly.  At one end of the spectrum, the testing could
be sequential in nature.  The computer could initiate an action, wait
for the result and then continue with another test.  At the other end, the testing
could be highly interactive.  A number of different 
tests might be performed simultaneously
on the UUT with the computer directing the operation of a group of devices.  Here,
the computer must be able to perform real-time processing.
	The computer learns the tests it must perform from the test engineer.  He,
usually, instructs the machine through a programming language called an ATE language.
These languages are a vehicle for the test engineer to specify his testing requirements
to the computer.  To be effective, these languages must not only be natural to the user,
but also must be oriented to the problem to be programmed.  How well suited an ATE
language is to both the user and the task at hand can significantly influence the
task of the test engineer.  A good ATE language can provide an easy bridge between the 
engineer and the computer.  A poor ATE language can hinder test development by
lengthening and complicating the test engineer's job.
It is therefore of paramount
importance that the ATE language be designed in such a manner that communication
can be both effective and simple.
.section "Evaluation Criteria for ATE Languages"
	In this section, we give some evaluation criteria for ATE languages.  An
ATE language must satisfy a number of requirements if it is to be useful.  The criteria
listed here, although not complete, should prove helpful in determining the
usefulness of an ATE language.  Some of these criteria have been previously proposed in
[Muntz 71].
.subsection "Ease of Learning"
	Usually, the test engineer will not be an experienced programmer and the ATE
language could be his first encounter with a programming language.  It is therefore
quite useful if it is possible to learn the ATE language easily and quickly.  The ATE
language should not contain any obscure constructs, have an easily remembered and
natural syntax plus clear and concise documentation.
.subsection "Ease of Use"
	It should be possible to write programs in the ATE language without undue
difficulty.  Two facets are of interest here: the difficulty of writing a program
in the first place, and the difficulty in knowing that the program performs the
task it was intended to accomplish properly.
	Constructibility is enhanced if the ATE language has a natural syntax,
powerful control structures such as if-then-else or while statements, block structure
and procedures.  Procedures also support the construction of modular programs.
	Modularity is an old idea in programming and consists of applying the
divide and conquer rule to a problem.  Modularization involves dividing a system into
subprograms (modules) which have connections with other modules.  The connections
between the modules are the assumptions which the modules make about each other.
Modularity permits a single function to be implemented and tested just once, thus
eliminating some duplication of effort and also standardizing the way such functions
are performed.  It also allows the efficient use of personnel since programmers can
implement and test different modules concurrently.  In these ways, it can assist in
minimizing the cost of automatic testing.
.subsection "Ease of Understanding"
	A person trained in the ATE language being used should be able to read a
program and then, with a minimum degree of difficulty, be able to determine what the
program does.  The syntax of an ATE language and the naturalness of its statement
constructs are
major factors in determining its comprehensibilty.
.subsection "Level of Abstraction"
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
[Liskov and Zilles 74].  In this manner, a good abstraction allows one to
concentrate on the essentials of a task without regard to unimportant factors.
	Clearly then, the type or level of abstraction supported by an ATE 
language is an important factor in judging its usefulness.  In this section, 
we present four levels of abstraction, taken from [Loveman 73], dealing with
ATE languages.  They are presented in order of increasing level of abstraction.
.subsubsection "Direct Control"
	At the direct programming level of abstraction, 
the programmer has detailed knowledge
of the test equipment and the software that drives these devices.  Testing
functions are performed by calling the software device drivers with the proper
arguments.  The programmer assumes the responsibility of knowing in detail the
characteristics of the ATE and how to make this equipment perform the desired testing
functions.  He must direct the connection of the test devices to the UUT.  This
is usually done by a switching matrix.
	A typical direct control ATE language is a convential programming language
such as ALGOL augmented with a run time package of test device control routines callable
from the host language.  For example, to read a dc voltage between 0  and 25 volts
on a digital multimeter designated DMM1 between locations or pins p1 and p2, one might
write
			CONNECT(DMM1,p1,p2)
			CALL DMM1(function=DC,range=25)
.subsubsection "ATE Orientation"
	Here, the programmer can use the test devices without having to know the
calling sequences of the device drivers.  He must still know the characteristics of the
specific peices of test equipment and their symbolic names; he thinks in terms of
actual test equipment and locations on the UUT.  However, he does not have to concern
himself with connecting the test equipment to the UUT.  Refering to the example
introduced above, one might write
	MEASURE DC VOLTS WITH MAXIMUM 25 BETWEEN p1 AND p2 USING DMM1
.subsubsection "UUT Orientation"
	In UUT oriented level of abstraction, the programmer specifies the
type of signal to be sent or received from the UUT without reference to the ATE at all.
This level of abstraction is quite ATE independent but, unfortunately, suffers from
some problems.  For example, if one wishes to apply a rather complex signal 
to the UUT or to make
a measurement subject to a special condition, it is more natural to think in
terms of a specific piece of test equipment rather than in terms of an abstract signal.
Furthermore,
there are times when one needs to insist that a certain device be used throughout
the test.  For instance, one may not be too concerned about inaccuracies if all
measurements are made using the same device and hence have the same degree of
inaccuracy.
	Refering to the example, one might write
			MEASURE DC VOLTAGE BETWEEN p1 AND p2
.subsubsection "Virtual Equipment"
	This is the highest level of abstraction.  In its simplest form, the
programmer describes a set of abstract or virtual test equipment needed to
perform his tests.  He then proceeds to program in a manner analogous to the
ATE oriented level of abstraction.  Once the program is completed, it then is necessary
to assign actual test equipment to perform the functions of the virtual
equipment. This resource allocation can be done by either the ATE language's compiler or
through a special facility in the language itself.  The intent here is to give the
programmer the ability to specify the test equipment necessary to perform his test,
and to
make this specification in a way that allows the resource
allocation of the actual ATE to
its virtual counterpart it be done simply, efficiently and as independently
of the real ATE as possible.
	At this level of abstraction, the programmer can optimize the use of the actual 
test equipment.  He does this by defining a set of virtual ATE that 
consists of independent, elemental components.  This is necessary since when 
a programmer is interested in
optimizing the use of the actual ATE, he must specify his virtual ATE in an
elementally manner and use the different parts of it independently.
One does not optimize the use of the actual equipment by only using a few pieces of
complicated equipment, but by using conceptually many pieces of simple test
equipment independently, and thus allowing a resource allocator greater flexibility in
implementing a set of virtual test equipment [Loveman 73].
	So, for the above example, one might write
			USE DC VM TO MEASURE VOLTS BETWEEN p1 AND p2
.section "Presentation"
	In the remainder of this report, we review programming languages for ATE.
This is done in Section 2.  Here, each language is described and critiqued using
the evaluation criteria developed in Section 1.2.  Section 2 also contains a brief
discussion of compiler generators for ATE langauges.  Finally, Section 3 discusses
the advantages and disadvantages of the various languages.
	This report only focuses on current ATE languages.  A discussion of the
early trends in automatic testing, along with an extensive bibliography, can be
found in [Lustig 73].  Also, early 
surveys of ATE languages were conducted by [Liguori 71]
and [Garcia-Aguilar 69].