000100100427     FMKTW010   IPE  E             DISK
000200090622     FCMCTL2    IF   E           K DISK    RENAME(COMCXR:FMT2) PREFIX(Z)
000300090622     FCMCT14    IF   E           K DISK    RENAME(COMCXR:FMT4) PREFIX(X)
000400090622     FSMANSP    IF   E           K DISK    PREFIX(C)
000500100423     FSMAN2L    IF   E           K DISK
000600100423     FAC2MSTL2  IF   E           K DISK
000700100427     FMKTW011   O  A F 2000        DISK
000800090622     D @A              S           2000A
000900090622     D YES             S               N   INZ(*ON)
001000090622     D NO              S               N   INZ(*OFF)
001100090622     D GOT_IT          S               N
001200100423     D CLR@SMAN2     E DS                  EXTNAME(SMAN2)
001300090622     D CLR@SMAN      E DS                  EXTNAME(SMANSP) PREFIX(C)
001400090622     D DS@CTX        E DS                  EXTNAME(COMCTX)
001500090622     D DS@C2         E DS                  EXTNAME(COMCTX) PREFIX(Z)
001600090622     D DS@C4         E DS                  EXTNAME(COMCTX) PREFIX(X)
001700090622     D #10             S             10S 0
001800090622     D @@@PARMS        S            142A
001900090622     D                 DS
002000090622     D PRMS                    1    142A
002100090622     D P@SMAN                  1      3A
002200090622     D P@SNAME                 4     36A
002300090622     D P@AGCY                 37     39A
002400090622     D P@ANAME                40     79A
002500090622     D P@SUPER                80     82A
002600090622     D P@UNAME                83    132A
002700090622     D P@RELID               133    140A
002800090622     D P@RESULT              141    141A
002900090622     D P@REQUEST             142    142A
003000090622     C     KL#CTX        KLIST
003100090622     C                   KFLD                    ACTRST
003200090622     C                   KFLD                    ACSUB#
003300090622     C                   KFLD                    ACACCT
003400090622     C                   CLEAR                   CLR@SMAN
003500090622     C                   Move      *BLANKS       PRMS
003600090622     C                   MOVE      *BLANKS       #RENEW           30
003700090622     C                   MOVE      *BLANKS       #PHON1           30
003800090622     C                   MOVE      *BLANKS       #PHON2           30
003900090622     C                   MOVE      *ZEROS        #10
004000090622     C                   EVAL      #10 = (AAREA * 10000000) + APHONE
004100090622     C                   EVAL      #PHON2 = %EDITW(#10:'   -   -    ')
004200090622     C     SMANCD        CHAIN     SMANR
004300090622     C                   IF        %FOUND(SMANSP)
004400090622     C                   EVAL      #10 = (CSAREA * 10000000) + CSPHONE
004500090622     C                   EVAL      #PHON1 = %EDITW(#10:'   -   -    ')
004600090622     C                   ENDIF
004700090622     C                   EXSR      $RENEW
004800090622     C                   EXSR      $GETINFO
004900090622     C                   IF        GOT_IT = YES
005000090622     C                   Eval      P@RELID = CMRELID
005100090622     C                   Eval      P@REQUEST = 'R'
005200090622     C                   Eval      @@@PARMS = PRMS
005300090622     C                   Call      'GAC900'
005400090622     C                   Parm                    @@@PARMS
005500090622     C                   MoveL     @@@PARMS      PRMS
005600100423     C                   CLEAR                   CLR@SMAN2
005700100423     C     CSGRP         CHAIN     SMAN2R
005800100423     C     KL#CTX        CHAIN     ACCMSR2
005900090622     C
006000090622     C                   ENDIF
006100100423     C                   EVAL      @A = '"' + '''' +
006200100423     C                             %TRIM(P@AGCY) + '","' +
006300090622     C                             %TRIM(P@ANAME) + '","' +
006400090622     C                             %TRIM(P@SMAN) + '","' +
006500100423     C                             %TRIM(P@SNAME) + '","' +
006600090622     C                             %TRIM(#PHON1) + '","' +
006700090622     C                             %TRIM(ACNAM1) + '","' +
006800090622     C                             %TRIM(ACNAM2) + '","' +
006900090622     C                             %TRIM(AADDR1) + '","' +
007000090622     C                             %TRIM(AADDR2) + '","' +
007100090622     C                             %TRIM(ACITY) + '","' +
007200090622     C                             %TRIM(ASTATE) + '","' +
007300090622     C                             %TRIM(%EDITW(AZIP:'     -    ')) + '","' +
007400090622     C                             %TRIM(#PHON2) + '","' + '''' +
007500090622     C                             %TRIM(#RENEW) + '","' +
007600100412     C                             %TRIM(%EDITC(NOEMPL:'1')) + '","' +
007700100423     C                             '''' +
007800100412     C                             %TRIM(P@SUPER)+ '","' +
007900100423     C                             %TRIM(P@UNAME) + '","' +
008000100423     C                             %TRIM(SBREML) + '","' +
008100100423     C                             %TRIM(CONTAC) + '","' +
008200100423     C                             %TRIM(A2EMAIL1) + '","' +
008300100423     C                             %TRIM(ECNTAC) + '","' +
008400100423     C                             %TRIM(A2EMAIL2) + '"'
008500090622     C                   EXCEPT    OUTF
008600090622     C     $RENEW        BEGSR
008700090622     C                   MOVE      ACSUB#        #2                2 0
008800090622     C                   SELECT
008900090622     C                   WHEN      #2 = 01
009000090622     C                   EVAL      #RENEW = 'JANUARY 1'
009100090622     C                   WHEN      #2 = 02
009200090622     C                   EVAL      #RENEW = 'FEBRUARY 1'
009300090622     C                   WHEN      #2 = 03
009400090622     C                   EVAL      #RENEW = 'MARCH 1'
009500090622     C                   WHEN      #2 = 04
009600090622     C                   EVAL      #RENEW = 'APRIL 1'
009700090622     C                   WHEN      #2 = 05
009800090622     C                   EVAL      #RENEW = 'MAY 1'
009900090622     C                   WHEN      #2 = 06
010000090622     C                   EVAL      #RENEW = 'JUNE 1'
010100090622     C                   WHEN      #2 = 07
010200090622     C                   EVAL      #RENEW = 'JULY 1'
010300090622     C                   WHEN      #2 = 08
010400090622     C                   EVAL      #RENEW = 'AUGUST 1'
010500090622     C                   WHEN      #2 = 09
010600090622     C                   EVAL      #RENEW = 'SEPTEMBER 1'
010700090622     C                   WHEN      #2 = 10
010800090622     C                   EVAL      #RENEW = 'OCTOBER 1'
010900090622     C                   WHEN      #2 = 11
011000090622     C                   EVAL      #RENEW = 'NOVEMBER 1'
011100090622     C                   WHEN      #2 = 12
011200090622     C                   EVAL      #RENEW = 'DECEMBER 1'
011300090622     C                   ENDSL
011400090622     C                   ENDSR
011500090622     C     *INZSR        BEGSR
011600090622     C                   EVAL      @A = '"AGENCY CODE","AGENCY NAME","SMAN CO' +
011700100423     C                             'DE","SALESMAN NAME",' +
011800100423     C                                             '"SALESMAN PHONE","ACC' +
011900090622     C                             'OUNT NAME 1","ACCOUNT NAME 2","ADDRESS LI' +
012000090622     C                             'NE 1","ADDRESS LINE 2","CITY","STATE","ZI' +
012100100423     C                             'P CODE","ACCOUNT PHON' +
012200090622     C                             'E NUMBER","RENEWING PERIOD","ACTIVE EMPLO' +
012300100427     C                             'YEES","SUPER AGENCY","SUPER AGENCY NAME"' +
012400100427     C                                  ',"BROKER EMAIL","CONTACT","CONTACT E' +
012500100427     C                             'YEES","BROKER EMAIL","CONTACT","CONTACT E' +
012600100423     C                             '-MAIL","EXECUTIVE CONTACT","EXECUTIVE CON' +
012700100423     C                             'TACT E-MAIL"'
012800100423     C
012900100423     C
013000090622     C                   EXCEPT    OUTF
013100090622     C                   ENDSR
013200090622     C     $GETINFO      BEGSR
013300090622     C                   EVAL      GOT_IT = NO
013400090622     C                   CLEAR                   DS@CTX
013500090622     C     KL#CTX        CHAIN     FMT2
013600090622     C                   IF        %FOUND(CMCTL2)
013700090622     C                   EVAL      GOT_IT = YES
013800090622     C                   EVAL      DS@CTX = DS@C2
013900090622     C                   LEAVESR
014000090622     C                   ENDIF
014100090622     C     KL#CTX        CHAIN     FMT4
014200090622     C                   IF        %FOUND(CMCT14)
014300090622     C                   EVAL      GOT_IT = YES
014400090622     C                   EVAL      DS@CTX = DS@C4
014500090622     C                   LEAVESR
014600090622     C                   ENDIF
014700090622     C                   ENDSR
014800100427     OMKTW011   EADD         OUTF
014900090622     O                       @A             B  2000
