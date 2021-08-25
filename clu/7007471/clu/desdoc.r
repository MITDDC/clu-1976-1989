.if version>0&version<29
.nx clu;desdoc r28
.en
.
.
.nr indent_incr 250
.nr proc_indent 0
.sr proc_name
.
.de procedure  <name> <arg-list> <return-type>
.
.sr proc_name \0
.if nargs>3
.tm Procedure \proc_name: too many args to .procedure
.end
.fi
.sp
.ne 8l
.in proc_indent!m
\0 \1
.if nargs>2
1returns0 \2
.end
.br
.in proc_indent+indent_incr!m
.em
.
.de signals  <names>
.
.if nargs==0
.tm Procedure \proc_name: args required for .signals
.end
.
1signals0 \0 \1 \2 \3 \4 \5 \6 \7 \8 \9
.br
.em
.
.de assigns  <names>
.
.if nargs==0
.tm Procedure \proc_name: args required for .assigns
.end
.
1assigns0 \0 \1 \2 \3 \4 \5 \6 \7 \8 \9
.br
.em
.
.de modifies  <names>
.
.if nargs==0
.tm Procedure \proc_name: args required for .modifies
.end
.
1modifies0 \0 \1 \2 \3 \4 \5 \6 \7 \8 \9
.br
.em
.
.de requires
.
.if nargs>0
.tm Procedure \proc_name: args not allowed to .requires
.end
.
.in proc_indent+2*indent_incr!m
.ti proc_indent+indent_incr!m
1requires*
.em
.
.de effect
.
.if nargs>0
.tm Procedure \proc_name: args not allowed to .effect
.end
.
.in proc_indent+2*indent_incr!m
.ti proc_indent+indent_incr!m
1effect*
.em
.
.de implementation
.
.if nargs>0
.tm Procedure \proc_name: args not allowed to .implementation
.end
.
.in proc_indent+2*indent_incr!m
.ti proc_indent+indent_incr!m
1implementation*
.em
.
.de datatype  <name>
.
.if nargs==0
.tm args required for .datatype
.end
.
.in 0
.nr proc_indent 100
.sp
1data type0 \0
.sp
.in proc_indent!m
.em
.
.de representation
.
.if nargs>0
.tm args not allowed to .representation
.end
.
.sp
.in proc_indent+indent_incr!m
.ti proc_indent!m
.fi
1representation*
.sp
.em
.
.de operations
.
.if nargs>0
.tm args not allowed to .operations
.end
.
.sp
.in proc_indent!m
1operations*
.em
.
.de text
.in 0
.em
