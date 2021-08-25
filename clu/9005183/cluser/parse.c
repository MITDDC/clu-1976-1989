main(argc,argv)
  int argc;
  char *argv[];
{int fin,fout,i,j;
char chr,instr[150];
fin = copen ("old.test", 'r');
for (i=0; ; )
 {if (((chr=cgetc(fin))=='\p') || (chr=='\0')) break;
  if (i>32) cgetc(fin);
  if (cgetc(fin) != '.')
   {while (((chr=cgetc(fin)) != '\p') && (chr != '\0')) ; break;}
  cgetc(fin);
  if ((chr=cgetc(fin)) == 'F')
   {instr[++i] = -1;
    cgetc(fin); cgetc(fin); cgetc(fin); cgetc(fin); cgetc(fin); cgetc(fin);}
  else {instr[++i] = chr; cgetc(fin); instr[++i] = cgetc(fin);}
  if (cgetc(fin) != '.')
   {while (((chr=cgetc(fin)) != '\p') && (chr != '\0')) ; break;}
  cgetc(fin); cgetc(fin);
  if ((chr=cgetc(fin)) == 'F')
   {instr[++i] = -1;
    cgetc(fin); cgetc(fin); cgetc(fin); cgetc(fin); cgetc(fin); cgetc(fin);}
  else {instr[++i] = chr; cgetc(fin); instr[++i] = cgetc(fin);}
  cgetc(fin);}
while(instr[i] == -1) --i;
instr[++i] = -2;
cclose(fin);
fout = copen ("new.test", 'w');
for (j=0; instr[++j] != -2; )
 {if (instr[j]==-1) cputc('-', fout);
  else {cputc(instr[j], fout); cputc(instr[++j], fout);}
  cputc('\n', fout);}
cclose(fout);}