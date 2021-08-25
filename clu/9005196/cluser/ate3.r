.chapter "Summary"
	Of the eight languages surveyed in this report, three, CTL, OPAL and
ATLAS, were designed as standard or universal ATE languages.  Each of the other
five languages was designed for use on a specific automatic test station.  All
these languages provide both a conceptual framework for thinking about tests and a
means for expressing those tests for machine execution.  The language's conceptual
framework is its level of abstraction.  The
level of abstraction of the languages in this report is summarized below in Figure .
.begin_figure "Levels of Abstraction"
.sp 3
   Direct Control               ATE Oriented              UUT Oriented              Virtual Equipment

        CTL                           CTL                        CTL                       CTL
        VITAL (DCOL)          VITAL (BBOL)              VITAL (TOL)             ATLAS
        VITAL (DBBOL)            GAELIC                   PROTEST                  OPAL
        VITAL (DTOL)               GOAL
                                   EQUATE ATLAS


.finish_figure
	There are tradeoffs between these different levels of abstraction.  It is easier
to use and understand programs written in a language with a high level of abstraction
such as OPAL or ATLAS.  However, these languages have their disadvantages.
The model of virtual test equipment works well for electronic testing in
which, for example, various sources are switchable among various accepters.  But,
the model becomes awkward for testing non-electronic items.  Consider setting the
throttle of a jeep in a virtual equipment oriented language.  One might write
	APPLY THROTTLE_PUSHER WITH PUSH = 40% TO THROTTLE
.br
One would presumably be happier with a statement such as
	APPLY THROTTLE_PUSHER WITH PUSH = 40%
.br
knowing that THROTTLE_PUSHER is always connected to THROTTLE [Loveman 73].  In this
instance, the virtual equipment orientation of the language requires one to restate
the obvious.
	A UUT oriented language does not suffer from this deficiency but has other
problems.  Sometimes, it is more natural to think in terms of a specific piece of
test equipment rather than an abstract signal.  Also, there are times when one
needs to insist that the same signal source is used throughout a test.
	Furthermore, there are occasions when even finer control is needed over a test.
Here, the direct control and ATE oriented languages are best.  They free the programmer
from the restrictions inherent in a language with a high level of abstraction and give
the programmer total control over the test.  But, this very freedom creates 
difficulties.  Programs become more complex and greater in length.  Further, they
usually require more time to develop.
	There are also tradeoffs in development costs.  
By their very nature, virtual equipment and UUT oriented languages are usually
extensive and flexible languages that can serve the needs of many automatic test 
stations.  On the other hand, direct control and ATE oriented languages tend to be
more restricted languages that can only handle the testing requirements anticipated
for a particular test station or family of test stations.
The former languages obviously require much more effort in development
but further suffer from unnecessary complexity for a given application on an
individual test station.  The latter languages are more economical to develop and
better suited to the needs of a specific test station but may not be usable for
any other test station.
	A language's level of abstraction also has an impact on the language's ease
of use and understanding through its influence on the types of statements that appear in
the language.  An ATE language should be an aid to the programmer long before he
reaches the actual coding stage in programming.  Further, it should provide him with a
clear, simple and unified set of concepts that he can use as primitives in developing
tests.  To this end, it is desirable to have a minimum number of different concepts,
with the rules for their combination being as simple and regular as possible.  Subtle
and capricious language constraints should be avoided and, of course, 
the language should be unambiguous.
	All of the ATE languages in this report meet these criteria of semantic clarity
fairly well.  ATLAS and VITAL, however, probably fare a little worse than the others.  
ATLAS is
intended to be both a test specification and test programming language.  Some of the
test specification constructs are not needed and should not be used in test programming.
They are ony intended for writing tests specifications.  From a programmer's point of
view, this aspect of the language is undesirable.  VITAL's five dialects do not allow
the language to have unified concepts and syntax.  Within an individual dialect there
is no problem but outside the dialect the programmer is presented with a great number
of different concepts.
	Clearly related to but quite different from the idea of semantic clarity of an
ATE language is the concept of the syntactic clarity of programs written in the
language.  The snytax of an ATE language greatly effects the ease with which programs
may be written and later understood and modified.  A language should not contain
syntactic constructs which are likely to lead to programmer errors.  But more
important than this is having a syntax which when properly used allows the program
structure to reflect the underlying logical structure of the test.
	With regard to this issue, OPAL, CTL and ATLAS are the best languages.  They
all have the appropriate constructs to allow a programmer to accomplish this
structuring.  The DCOL, DBBOL and DTOL dialects of VITAL are the worst in this regard.  They
obscure the test that is programmed.  The other languages fall in between these two
extremes. They do not have the rich structures of, say, OPAL but do give the
programmer more powerful constructs than found in the direct control langauges.
	From this discussion, it should be apparent that there are many factors
involved in evaluating an ATE language.  This report has surveyed eight ATE languages
and introduced the concepts found in each language.  With this background, it is hoped
that the reader can make a judicious choice of any ATE language he is considering.
