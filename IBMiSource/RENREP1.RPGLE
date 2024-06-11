000100130828     Hoption(*nodebugio) debug
000200000000      *_________________________________________________________________________
000300000000      *
000400130627      *  Description:  One time load existing sman to new rep field
000500000000      *
000600130314      *  (c)Copyright 2013 by GBS, Inc.
000700000000      *
000800000000      *_________________________________________________________________________
000900130828     Facmunique uf   e             DISK
001000130828     Fbrkuploadnif   e           k disk    rename(brkuploadn:format)
001100130627     FAC2MST    UF A E           K Disk
001200120217
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001500120914
001600130827     C                   Read      acmunique
001700130827     C                   Dou       %Eof(acmunique)
001800130314     C                   Exsr      Process
001900130827     C                   Read      acmunique
002000121205     C                   EndDo
002100130827
002200121206    ?C                   Move      *On           *InLR
002300121205
002400120914      *-------------------------------------------------------------*
002500130314     C     Process       Begsr
002600120914      *-------------------------------------------------------------*
002700130828
002800130627     C     AccKey        Chain     AC2MST
002900130627     C                   If        %Found(AC2MST)
003000130827     C                   Eval      A2CODE1  =     SMANCD
003100130627     C                   Update    ACCMSR2
003200130627     C                   Else
003300130627     C                   Eval      A2APPL   =     KeyF
003400130627     C                   Eval      A2TRST   =     ACTRST
003500130627     C                   Eval      A2SUB#   =     ACSUB#
003600130627     C                   Eval      A2ACCT   =     ACACCT
003700130827     C                   Eval      A2CODE1  =     SMANCD
003800130828     c                   eval      a2par    =     'N'
003900130627     C                   Write     ACCMSR2
004000130314     C                   End
004100121205
004200130828      /free
004300130828        // if account NOT terminated...
004400130828        if atrmdt = *zeros ;
004500130828
004600130828          // see if acct is in the UPLOAD file of broker assignments...
004700130828         chain (actrst:acsub#:acacct) brkuploadn ;
004800130828         if %found (brkuploadn) and termflag = *blanks and smancd <> newsman ;
004900130828          smancd = newsman ;
005000130828          update accmsr %fields(smancd) ;
005100130828         endif ;
005200130828
005300130828        endif ;
005400130828      /end-free
005500111118     C                   Endsr
005600000000      *___________________________________________________________________
005700000000      * Key Lists
005800000000      *___________________________________________________________________
005900130314     C     KLIST         Begsr
006000121205
006100130314     C     AccKey        Klist
006200130627     C                   Kfld                    KeyF
006300130627     C                   Kfld                    ACTRST
006400130627     C                   Kfld                    ACSUB#
006500130627     C                   Kfld                    ACACCT
006600130314     C                   Endsr
006700000000      *___________________________________________________________________
006800000000      * Program open
006900000000      *___________________________________________________________________
007000130314     C     *Inzsr        Begsr
007100130828
007200130314     C     *DATE         Mult      10000.0001    Today             8 0
007300130627     C                   Movel     'F'           KeyF              1
007400130828
007500130314     C                   Endsr
