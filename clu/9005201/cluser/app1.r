.appendix "Undecidable Properties of State Machines"
	In this appendix, we shall show that the problem of determining whether a
state machine, specifed in ALMS, is well-defined or consistent is undecidable.
This is established by reducing both problems to the 2blank tape halting problem*
for Turing machines.  The blank tape halting problem is the problem of determining,
given a particular Turing machine T, whether or not T halts when started on blank
tape.
	The definition of a Turing machine used here is given by [Hennie 77].  A
Turing machine is represented by a group of quintuples of the following form
			qi sj sk dl qh
.br
.sr el 8*
where	qi is the current state
	sj is the symbol under the tape head
	sk is the symbol to be printed on the tape
	dlel!{right , left} is the direction of the head's movement
	qh is the next state
.br
Thus, the machine moves right or left on evrey step of its computation.
	So, assume we are given a Turing machine M with quintuples
			qi1 sj1 sk1 dl1 qh1
.ls 1
			.			.
			.			.
			.			.
			qin sjn skn dln qhn
.ls 2
	Now, consider the state machine given in Figure 1.
.begin_figure
.sp 2
 		M* = 1Parnas_module is* tape, state, head_pos, move

		     state = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.:* 1true*
				1Initial Value:* qi1
				end state

		     head_pos = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value:* 0
				end head_pos

		     tape = 1non-derived V-function*(i:integer) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value:* 7h*
				end tape

		     well_defined = 1hidden V-function*( ) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value:* undefined
				end well_defined

		     move = 1O-function*( )
				1Appl. Cond.: true* 
				1Effects:
				if* state = qi1  tape(head_pos) = sj1 1then* 'state'=qh1
				1if* state = qi1  tape(head_pos) = sj1 1then* 'head_pos'=head=pos + c(dl1)
				1if* state = qi1  tape(head_pos) = sj1 1then* 'tape'(head_pos)=sk1
				.
				.
				.
				1if* state = qin  tape(head_pos) = sjn 1then* 'state'=qhn
				1if* state = qin  tape(head_pos) = sjn 1then* 'head_pos'=head=pos + c(dln)
				1if* state = qin  tape(head_pos) = sjn 1then* 'tape'(head_pos)=skn
				1if* ~((state = qi1  tape(head_pos) = sj1) ... (state = qin  tape(head_pos) = sjn)) 1then* 'tape'(head_pos)=well_defined
				end move

		end M*
.finish_figure
.begin_figure
.sp 2
 		M* = 1Parnas_module is* tape, state, consistent, head_pos, move

		     state = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.:* 1true*
				1Initial Value:* qi1
				end state

		     head_pos = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value:* 0
				end head_pos

		     tape = 1non-derived V-function*(i:integer) 1returns* integer
				1Appl. Cond.: true*
				1Initial Value:* 7h*
				end tape

		     consistent = 1non-derived V-function*( ) 1returns* integer
				1Appl. Cond.:* switch
				1Initial Value:* undefined
				end well_defined

		     switch = 1hidden V-function*( ) 1returns* Boolean
				1Appl. Cond.: true*
				1Initial Value: false*
				end switch

		     move = 1O-function*( )
				1Appl. Cond.: true* 
				1Effects:
				if* state = qi1  tape(head_pos) = sj1 1then* 'state'=qh1
				1if* state = qi1  tape(head_pos) = sj1 1then* 'head_pos'=head=pos + c(dl1)
				1if* state = qi1  tape(head_pos) = sj1 1then* 'tape'(head_pos)=sk1
				.
				.
				.
				1if* state = qin  tape(head_pos) = sjn 1then* 'state'=qhn
				1if* state = qin  tape(head_pos) = sjn 1then* 'head_pos'=head=pos + c(dln)
				1if* state = qin  tape(head_pos) = sjn 1then* 'tape'(head_pos)=skn
				1if* ~((state = qi1  tape(head_pos) = sj1) ... (state = qin  tape(head_pos) = sjn)) 1then* 'switch'=1true*
				end move

		end M*
.finish_figure