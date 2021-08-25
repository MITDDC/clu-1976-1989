.dv xgp
.
.nd big 0
.
.if big
.fo 0 fonts; 31vg kst
.fo 1 fonts; 31vgb kst
.fo 2 fonts; 31vgi kst
.fo 3 fonts; 40vg kst
.ef
.fo 0 fonts; 25vg kst
.fo 1 fonts; 25vgb kst
.fo 2 fonts; 25vgi kst
.fo 3 fonts; 40vg kst
.en
.
.sr list_left_margin 500m
.sr list_right_margin 500m
.nr chapter_starts_page 0
.nr verbose 1
.
.so r/r.macros
.
.sr newline 1newline*
.
.
.nr example 0
.de example
.begin example\+example
.nv font 2
..
.
.de end_example
.end
..
.
.nr operation 0
.de operation
.begin operation\+operation
.sp
.ne 5
.nv fill 0
.nv font 1
.nv indent 1000
.ti 0
..
.
.de operation_description
.sp
.nr fill 1
.nr indent 500
.nr font 0
..
.
.de end_operation
.sp
.ns
.end
..
.
.chapter "Introduction"
This document describes a proposal for a CLU I/O facility.
It is based on the author's experience with a number of
operating systems and attempts to write portable programs.
The proposed facility represents a minimal set of commonly-used
functions that have some meaning on most systems.  It also
provides a framework in which some other operations that are
not always available can be expressed.

The following are not yet included in this document:
formatted I/O.
.chapter "Basic Types"
The following basic types are proposed:
.table 4
	stream - provides access to files
	file_name - a naming scheme for files
	date - calendar date and time
.end_table
No type "file" is proposed, as will be explained.
.chapter "Files"
This proposal deals primarily with permanent information containers
called files.  There are three kinds of files:
.table 3
	text file
	character file
	integer file
.end_table
The three kinds of files may be incompatible.  However,
it may not be possible to determine what kind a given
file is.

A text file consists of a sequence of characters, which
is divided into lines terminated by newline characters.
The last line of a non-empty file will be terminated.
A text file will be stored in the (most appropriate)
standard text file format of the local operating
system.  As a result, certain characters (e.g. NUL,
CR, FF, ^C) may be ignored when written.  In addition,
a system may limit the maximum length of lines and
may remove trailing blanks from lines.

A character file is a vector of arbitrary characters.
If a character file is created by writing some sequence
of characters S, then the file will consist of the
sequence S, possibly followed by a bounded number of
arbitrary characters.  (I.e., the system may pad
the file with arbitrary characters in order to fill
out a word or record.)  Thus, the user must arrange
his own end-of-file detection.

An integer file is a vector of arbitrary integers.
The warning about user detection of end-of-file
applies here also.
.chapter "File Names"
File names are immutable objects which are used to name files.
The system file name format is viewed as consisting of
four string components:
.ilist 4
directory - specifies a file directory or device
.next
name - the primary name of the file (e.g. "thesis")
.next
suffix - a name normally indicating the type of
file (e.g. "clu" for a CLU source file)
.next
other - all other components of the system file name
form
.end_list
The directory and other components may have internal
syntax.  The name and suffix should be short, unstructured
identifiers.
.example
(For example, in the ITS file name "DEV:DIR;NAME1 NAME2",
the directory is "DEV:DIR;", the name is "NAME1",
the suffix is "NAME2", and there is no other.  In the
UNIX path name "/usr/snyder/doc/refman.r", the directory
is "/usr/snyder/doc", the name is "refman", the suffix
is "r", and there is no other.  Examples of "other"
are TENEX version numbers and GCOS passwords.
.end_example

A null component has the following interpretation:
.ilist 4
directory - denotes the current "working" directory.
.example
(For example, the "current directory" on UNIX and
the "SNAME" on ITS.)
.end_example
.next
name - may be illegal, have a unique interpretation,
or be ignored.
.example
(For example, on ITS, a null name is illegal for
most directories, but for some devices, the name
is ignored.)
.end_example
.next
suffix - may be illegal, have a unique interpretation,
imply a default, or be ignored.
.example
(For example, on UNIX, a null suffix is legal, as
in "/usr/snyder/foo"; on ITS, a null suffix is illegal,
but it is convenient to regard it as indicating the
default ">".)
.end_example
.next
other - has no standard interpretation; should imply
a reasonable default.
.end_list

The operations on file names are:
.
.operation
create (dir, name, suffix, other: string) => file_name
-> bad_format
.operation_description
This operation creates a file name from its components.
.end_operation
.
.operation
parse (name: string) => file_name
-> bad_format
.operation_description
This operation creates a file name given a string in
the system standard file name syntax.
.end_operation
.
.operation
unparse (name: file_name) => string
.operation_description
This operation transforms a file name into
the system standard file name syntax.
.end_operation
.
.operation
set_output (name: file_name, suffix: string) => file_name
.operation_description
This operation is used by programs which take input
from a file and write new files whose names are
based on the input file name.
The operation transforms the file name into
one which is suitable for output.  This is done
as follows: (1) the suffix is set to the given suffix;
(2) if the old directory is not suitable for writing,
then it is set to null; (3) the name, if null and
meaningless, is set to "output".
.example
(Examples of directories which are not suitable for
writing are ITS archive directories and directories which
involve transferring files over a slow network.)
.end_example
.end_operation
.
.operation
set_local_output (name: file_name, suffix: string) => file_name
.operation_description
This operation is like 2set_output* except that the
directory is always set to null.  Its usage is a matter
of personal preference.
.end_operation
.
.operation
make_temp (program_name, file_idn: string) => file_name
.operation_description
This operation creates a file name appropriate for a temporary
file, using the given program name and file identifier, plus
a per-process unique-id (obtained internally).
.example
(For example, the call make_temp ("sort", "a") might create
the file name "_SORT_ A27" on ITS and the file name "/tmp/sort4398a"
on UNIX.)
.end_example
Both the program name and the file identifier should be short
and alphabetic.
.end_operation
.chapter "A File Type?"
Although files are the basic information-containing object in this
proposal, we do not recommend that a file type be introduced.
The reason for this recommendation is that few, if any, systems
provide an adequate representation for files.

On many systems, the most reliable representation of a file (that is
accessible to the user) is a channel (stream) to that file.
However, this representation
is inappropriate for a CLU file type, since possession of a channel
to a file often implies locking that file.

The other possible representation is a file name.  However, file names
are one level indirect from files, via the file directory.  As a
result, the relationship of a file name to a file object is
time-varying.  Using file names as a representation for files would
imply that all file operations could signal 2non_existent_file*.
In addition, separating the creation of a file from the writing
of that file (via a stream) would prohibit use of the ITS feature
by which the creation of a file is effectively postponed until the
writing is complete.

Therefore, we propose that operations related to file objects
be performed by the stream cluster, and that operations related
to the directory system be performed by procedures.
.chapter "File System Procedures"
The file system procedures are:
.
.operation
open_file (name: file_name, access_mode, file_type: string) => stream
-> non_existent_file
-> not_possible (why: string)
-> bad_access_mode
-> bad_file_type
-> wrong_file_type
.operation_description
The possible access modes are "read", "write", and "append".
The possible file types are "text", "char", and "int".
The 2wrong_file_type* error is signalled in those cases
where the system is able to detect that the type of the specified
pre-existing file is different than the specified file type.

If the mode is "read", then the named file must exist.
A stream is returned upon which input operations
can be performed.

If the mode is "write", a new file is created or an old file is
rewritten.  A stream is returned upon which output
operations can be performed.

If the mode is "append", then if the named file does not exist,
one is created.  A stream is returned which is positioned at the
end of the file and upon which output operations can be performed.
In the case of character and integer files, or files which
represent terminal devices, input operations may also be allowed.
Exclusive access to the file should be enforced, if possible.
.end_operation
.
.operation
delete_file (file: file_name)
-> not_possible (why: string)
.operation_description
This procedure deletes the specified file.
.end_operation
.
No operations to rename files or to create links to files
are proposed.  These operations are so system-dependent
that it is hard to imagine a portable program which uses
them.
.chapter "Streams"
Streams provide the basic input/output operations, plus other
operations on file objects.  The operations which are allowed
on any particular stream depend upon the access mode and the file
type.  In addition, certain operations may essentially be null
in some implementations.

When an operation cannot be performed, because of incorrect file
type or access mode, because of implementation limitations, or
because of properties of an individual file or device, and
no null action is described, then the operation will signal
2not_possible*.  This condition can be determined for each
operation 2op* by the operation 2op*_possible, which
takes a stream and returns 1true* if the operation on that
stream appears possible.

The stream operations are:
.
.operation
getc (s: stream) => char
-> end_of_file
-> not_possible (why: string)
.operation_description
This input operation may be performed on text and character files.
.end_operation
.
.operation
peekc (s: stream) => char
-> end_of_file
-> not_possible (why: string)
.operation_description
This input operation is like getc, except that the character is
not removed from the stream.
.end_operation
.
.operation
putc (c: char, s: stream)
-> not_possible (why: string)
.operation_description
This output operation may be performed on text and character files.
For text files, writing a newline indicates the end of the current
line.
.end_operation
.
.operation
putc_image (c: char, s: stream)
-> not_possible (why: string)
.operation_description
This output operaton is like putc, except that an arbitrary character
may be written and the character is not interpreted by the CLU I/O
system.  (For character files, it is equivalent to putc.)
.example
(For example, the ITS XGP program expects a text file which contains
certain escape sequences.  An escape sequence consists of
a special character followed by a fixed number of
arbitrary characters.  These characters could be the same as a
end-of-line mark, but they are recognized as data by their context.
On a record-oriented system, such characters would be part of the data.
In either case, writing a newline in image mode would not be interpreted
by the CLU system as indicating an end-of-line.)
.end_example
.end_operation
.
.operation
getc_image (s: stream) => char
-> end_of_file
-> not_possible (why: string)
.operation_description
This operation is provided to read text files with escape sequences,
as might be written using putc_image.  Using this operation inhibits
the recognition of end-of-line marks, where used.
.end_operation
.
.operation
geti (s: stream) => int
-> end_of_file
-> not_possible (why: string)
.operation_description
This input operation may be used only on integer files.
.end_operation
.
.operation
puti (i: int, s: stream)
-> not_possible (why: string)
.operation_description
This output operation may be used only on integer files.
.end_operation
.
.operation
lineno (s: stream) => int
-> end_of_file
-> not_possible (why: string)
.operation_description
This input operation may be used only on text files.
It returns the line number of the current (being or about to
be read) line.  On systems which maintain explicit line numbers,
said line numbers are returned.  Otherwise, lines are implicitly
numbered, starting with 1.
.end_operation
.
.operation
set_lineno (s: stream, i: int)
-> not_possible (why: string)
.operation_description
This output operation may be used only on text files.
On systems which maintain explicit line numbers, this operation
sets the line number of the next (not yet started) line.
Otherwise, it is ignored.
.end_operation
.
.operation
rewind (s: stream)
-> not_possible (why: string)
.operation_description
This operation may be performed on all types of files.
It resets the stream so that the next input or output
operation will read or write the first item in the file.
.end_operation
.
.operation
tell (s: stream) => int
-> not_possible (why: string)
.operation_description
This operation may be used only on character and integer files.
It returns the position in the file of the current (next to be
read or written) character or integer.
The first item in the file is at position 0, the next at
position 1, etc.  
.end_operation
.
.operation
seek (s: stream, i: int)
-> not_possible (why: string)
.operation_description
This operation may be performed only on character or integer files.
In some cases, it may not be possible to perform.  Otherwise, its
effect is to set the current position, described above.  Setting
the position outside the bounds of the file will not cause an error
until an input or output operation is attempted.  A seek on an
output file may extend the size of the file.
.end_operation
.
.operation
size (s: stream) => int
-> not_possible (why: string)
.operation_description
This operation may be performed only on character or integer files.
In some cases, it may not be possible to perform.
Otherwise, it returns the number of items in the file (including
padding).
.end_operation
.
.operation
flush (s: stream)
.operation_description
Any buffered output is written to the file, if possible.
Otherwise, there is no effect.
.end_operation
.
.operation
date (s: stream) => date
-> not_possible (why: string)
.operation_description
This operation returns the date of the last modification of the
corresponding file.
.end_operation
.
.operation
set_date (s: stream, d: date)
-> not_possible (why: string)
.operation_description
This operation sets the modification date of the corresponding file.
.end_operation
.
.operation
file_name (s: stream) => file_name
.operation_description
This operation returns the name of the corresponding file.  It may
be different than the name used to open the file, in that defaults
have been resolved and link indirections have been followed.
.end_operation
.
.operation
close (s: stream)
.operation_description
This operation terminates I/O and removes the association between
the stream and the file.  Further use of operations that signal
2not_possible* will cause 2not_possible* errors.
.end_operation
.
.operation
is_closed (s: stream) => bool
.operation_description
This operation returns 1true* iff the stream is closed.
.end_operation
.
.operation
is_terminal (s: stream) => bool
.operation_description
This operation returns 1true* iff the stream is attached to
an interactive terminal.  Such streams should appear as text
files and allow both input and output operations.
.end_operation

The following operations are also useful:
.
.operation
get_line (s: stream) => string
-> end_of_file
-> not_possible (why: string)
.operation_description
This input operation may be performed only on text files.  It
reads and returns (the remainder of) the current input line and
reads but does not return the terminating newline.
.end_operation
.
.operation
put_line (l: string, s: stream)
-> not_possible (why: string)
.operation_description
This output operation may be performed only on text files.
It writes the characters of the string onto the stream, followed
by a newline.
.end_operation
.
.operation
gets (s: stream, terminator: char) => string
-> end_of_file
-> not_possible (why: string)
.operation_description
This input operation may be performed only on text and character
files.  It reads characters until the given terminating
character or end-of-file is seen; the characters (not including the
terminator character) are returned.  It signals 2end_of_file* only
if there were no characters and end-of-file was detected.
.end_operation
.
.operation
puts (data: string, s: stream)
-> not_possible (why: string)
.operation_description
This output operation may be performed only on text and character
files.  It simply writes the characters in the string using putc.
.end_operation
.
.chapter "Terminal I/O"
Terminal I/O is performed via streams attached to interactive
terminals.  Such a stream is normally obtained as a parameter
to the top-level procedure of a program.  A terminal stream
should be capable of performing both input and output
operations.  A number of additional operations are possible
on terminal streams, and a number of regular operations have
special interpretations.

Terminal input will normally be buffered so that the user
may perform editing functions, such as deleting the last
character on the current line, deleting the current line,
redisplaying the current line, and redisplaying the current
line after clearing the screen.  Specific characters for
causing these functions are not suggested.  In addition,
some means must be provided for the user to indicate
end-of-file.

Input buffering is normally provided on a line basis.
However, new input caused by the 2gets* operation
will be buffered as a unit.  In addition, when there is
no buffered input, the 2getc_image* operation will
read a character directly from the terminal, without
it being interpreted or echoed.  The user may specify
a prompt string to be printed whenever a new buffer
of input is requested; the prompt string will be
reprinted when redisplay of the current line is
requested.  However, if at the time that new input
is requested an unfinished line has been output,
then that string is used instead as a prompt.

The routine 2putc_image* can be used to cause
control functions, e.g. '\007' (bell) and '\p'
(clear-screen).

Terminal output may be buffered one line at a
time.  However, the buffer must be flushed when
new input is requested from the terminal.

New operations:
.
.operation
get_prompt (s: stream) => string
.operation_description
This operation returns the current prompt string.  The
prompt string is initially null.  A null string is
returned for non-terminal streams.
.end_operation
.
.operation
set_prompt (s: stream, prompt: string)
-> not_possible (why: string)
.operation_description
This operation sets the string to be used for
prompting.
.end_operation
.
.operation
get_buffered_input (s: stream) => bool
.operation_description
This operation returns 1true* iff the stream
is attached to a terminal and input is being buffered.
.end_operation
.
.operation
set_buffered_input (s: stream, buffered: bool)
-> not_possible (why: string)
.operation_description
This operation sets the input buffering mode.
.end_operation
.
.operation
get_buffered_output (s: stream) => bool
.operation_description
This operation returns 1true* iff the stream
is attached to a terminal and output is being buffered.
.end_operation
.
.operation
set_buffered_output (s: stream, buffered: bool)
-> not_possible (why: string)
.operation_description
This operation sets the output buffering mode.
.end_operation
.
.chapter "Miscellaneous Procedures"
.operation
user_name () => string
.operation_description
This operation returns some identification of the user who
is associated with the executing process.
.end_operation
.
.operation
now () => date
.operation_description
This operation returns the current date and time.
.end_operation
.
.chapter "Dates"
.
Dates are immutable objects which represent calendar dates
and times.  Suggested operations for dates are:
.
.operation
create (month, day, year, hours, minutes, seconds) => date
-> bad_format
.end_operation
.
.ta 4i
.operation
month (date) => int	(1 .. 12)
.in 0
day (date) => int	(1 .. 31)
year (date) => int	(1976 .. )
hours (date) => int	(0 .. 23)
minutes (date) => int	(0 .. 59)
seconds (date) => int	(0 .. 59)
.sp
unparse (date) => string	(e.g. "12 January 1977 01:36:59")
unparse_date (date) => string	(e.g. "12 January 1977")
unparse_time (date) => string	(e.g. "01:36:59")
.end_operation
.
.chapter "Alternatives"
.
It might be better to have three types of streams (text_stream,
char_stream, and int_stream).  This would require three open
procedures (open_text, open_char, and open_int).

