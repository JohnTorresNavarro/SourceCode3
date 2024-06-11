000100150903     FITFUDL    IF   E           K DISK
000200150903     FITFUDL1   IF   E           K DISK    RENAME(ITFUDR:ITDUDR1)
000300150903     F                                     PREFIX(M)
000400150903     FITFUDL2   IF   E           K DISK    RENAME(ITFUDR:ITDUDR2)
000500150903     F                                     PREFIX(I)
000600150903   X* *
0007001509020025  *
0008001507020250 D                 DS
000900150903     D svemail         S             30A
001000110419      *
001100150903      *   Supervisor Emails
001200150903      *
001300150903     C                   eval      svemail = *blanks
001400150903     C     *LOVAL        setll     itfudl                             21
001500150903     C     *IN21         DOUEQ     *ON
001600150902      *
001700150903     C                   read      itfudl                                 21
001800150903     C                   if        *in21 <> *ON and ifseml <> *blanks
001900150728      *
002000150903     C                   if        ifseml <> svemail
002100150903     C                   CALL      'ITFSUPRC'
002200150903     C                   PARM                    ifseml
002300150903     C                   eval      svemail = ifseml
002400150728     C                   endif
002500150728      *
002600150903     C                   endif
002700150903      *
002800150903     C                   enddo
002900150903      *
003000150903      *   Manager Emails
003100150903      *
003200150903     C                   eval      svemail = *blanks
003300150903     C     *LOVAL        setll     itfudl1                            21
003400150903     C     *IN21         DOUEQ     *ON
003500150903      *
003600150903     C                   read      itfudl1                                21
003700150903     C                   if        *in21 <> *ON and mifmeml <> *blanks
003800150903      *
003900150903     C                   if        mifmeml <> svemail
004000150903     C                   CALL      'ITFMGRRC'
004100150903     C                   PARM                    mifmeml
004200150903     C                   eval      svemail = mifmeml
004300150903     C                   endif
004400150903      *
004500150903     C                   endif
004600150903      *
004700150903     C                   enddo
004800150903      *
004900150903      *   Initiator Emails
005000150903      *
005100150903     C                   eval      svemail = *blanks
005200150903     C     *LOVAL        setll     itfudl2                            21
005300150903     C     *IN21         DOUEQ     *ON
005400150903      *
005500150903     C                   read      itfudl2                                21
005600150903     C                   if        *in21 <> *ON and iifieml <> *blanks
005700150903      *
005800150903     C                   if        iifieml <> svemail
005900150903     C                   CALL      'ITFINIRC'
006000150903     C                   PARM                    iifieml
006100150903     C                   eval      svemail = iifieml
006200150903     C                   endif
006300150903      *
006400150903     C                   endif
006500150903      *
006600150903     C                   enddo
006700150902      *
006800150902     C                   eval      *inlr = '1'
006900150902     C                   return
