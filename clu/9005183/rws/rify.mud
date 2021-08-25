<DEFINE RIFY (OUTF "TUPLE" INFS "AUX" IN OUT BUF TERM CHAR CNT FLAG "NAME" RTN)
    #DECL((OUTF) STRING
	  (TUP) <TUPLE <REST STRING>>
	  (IN OUT) <OR CHANNEL FALSE>
	  (BUF TERM) STRING
	  (CHAR) CHARACTER
	  (CNT FLAG) FIX)
    <SET FLAG 0>
    <COND (<SET OUT <OPEN "READ" .OUTF>>
	   <CLOSE .OUT>
	   <RETURN "Output file exists" .RTN>)
	  (<SET OUT <OPEN "PRINT" .OUTF>>)
	  (T
	   <RETURN "Can't open output file" .RTN>)>
    <SET BUF <ISTRING 200 #CHARACTER 0>>
    <SET TERM <STRING  #CHARACTER 13 #CHARACTER 12 #CHARACTER 92>>
    <REPEAT ()
       <COND (<EMPTY? .INFS>
	      <RETURN>)
	     (<SET IN <OPEN "READ" <1 .INFS>>>
	      <COND (<0? .FLAG>
		     <PRINC ".dv xgp
.fo 0 fonts;20fg kst
.nr verbose 1
.nr print_page1_headings 1
"				.OUT>
		     <PRINC <STRING ".sr right_heading " <1 .INFS>> .OUT>
		     <PRINC "
.so r;r macros
.nf
"				.OUT>)
		    
		    (T
		       <PRINC <STRING ".sr right_heading " <1 .INFS>> .OUT>
		       <PRINC "
.bp
"				.OUT>)>
	      <PRINC ".keep
"				.OUT>
	      <SET INFS <REST .INFS>>
	      <SET FLAG 1>
	      <REPEAT ()
		 <SET CNT <READSTRING .BUF .IN .TERM '<RETURN>>>
		 <PRINTSTRING .BUF .OUT .CNT>
		 <COND (<==? <SET CHAR <READCHR .IN #CHARACTER 0>> #CHARACTER 13>
			<READCHR .IN <>>
			<TERPRI .OUT>)
		       (<==? .CHAR #CHARACTER 92>
			<PRINC "\\"	.OUT>)
		       (<==? .CHAR #CHARACTER 0>
			<PRINC "..
.end_keep
"					.OUT>
			<OR <EMPTY? .INFS>
			    <PRINC ".keep
"					.OUT>>
			<RETURN>)>
		 <COND (<OR <AND <G? .CNT 4>
				 <=? <SUBSTRUC .BUF 0 5> "	end ">>
			    <AND <G? .CNT 2>
				 <OR <=? <SUBSTRUC .BUF 0 3> "end">
				     <=? <SUBSTRUC .BUF 0 3> "END">>>>
			<PRINC "..
.end_keep
"					.OUT>
			<REPEAT ()
			   <COND (<==? <SET CHAR <NEXTCHR .IN #CHARACTER 0>>
				       #CHARACTER 13>
				  <READCHR .IN>
				  <READCHR .IN <>>
				  <TERPRI .OUT>)
			      (<==? .CHAR #CHARACTER 12>
			       <READCHR .IN>)
			      (T <RETURN>)>>
			<COND (<==? .CHAR #CHARACTER 0>
			       <RETURN>)>
			<AND <==? <NTH .BUF 1> !\e>
			     <PRINC ".bp
"					.OUT>>
			<PRINC ".keep
"					.OUT>)>>)
	     (T
		<PRINC <STRING "Couldn't open " <1 .INFS> #CHARACTER 13>>
		<SET INFS <REST .INFS>>)>>
    <CLOSE .OUT>
    "DONE">
