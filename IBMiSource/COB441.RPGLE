000100110614   X***X SUBSCRIBER INITIAL NOTICE APPLICATION
000200110614   X***X LETTER PRINTING PROGRAM
000300110614   X***X
000400110614   X***X CURRENT ACCOUNTS:
000500110614   X***X
000600110614   X***X 590 012 0008 MARICOM SYSTEMS, INC.
000700110614   X***X 591 004 0286 PHASE ONE CONSULTING GROUP, INC.
000800110614   X***X
000900130523   X***X 05/23/2013 SSK ADD REPORT FOR LISA K.
001000110614   X***X
001100131007   X***X 10/04/2013 SSK HIST EXPANSION PROJECT
001200180626   X* *  06/26/2018 DLK - add overlay to first page and remove SSN
001300210729   X* *  07/29/2021 DLK - rebrand to Amwins, update letter, change printer
001400210729   X* *                   file name to match program
001500210729   X* *
001600210729   X* *
001700120605     fCOB440W1  UPE  e           k disk
001800120605     fCOB440W2  IF   e           k disk
001900060828     FMEMBER    IF   E           K DISK
002000060905     FHIST      O  A E             DISK
002100210729     fcob441p   O    E             PRINTER
002200130523     FT100      O  A F  100        DISK
002300060822   X***X
002400130523     D KX              S            100A
002500060823     d @9              s              9a
002600060823     d #iso            s               d   datfmt(*ISO)
002700060823     d #tday           s              8s 0
002800060823     d @tday           s             10a
002900060823     d z5              s              5a
003000060831    ***
003100060831     D P1DATE          S             50A
003200060831     D P1NAME          S             50A
003300060831     D P1ADDR          S             50A
003400060831     D P1ADD2          S             50A
003500060831     D P1CSZ           S             50A
003600110602    ? * Program status data structure
003700110602    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003800131007    ***
0039001310070037 D sysdateymd      S               d   datfmt(*iso)
004000210729     D thispgmname     S             10a   inz('COB441    ')
004100131007    ***
004200131007     D @TS40           S             40A
004300131007     D @TIMESTAMP      DS
004400131007     D  #TSCYMD                1      8S 0
004500131007     D  #TSTIME                9     14S 0
004600131007     D  @TSJOB                15     24
004700131007     D  @TSUSER               25     34
004800131007     D  #TSNBR                35     40S 0
004900131007     D P@40                    1     40A
005000131007    ***
005100060822   X***X
005200060828     C                   IF        SLDATE = 00010101
005300060828     C                   EXSR      $GENLTR
005400060828     C                   MOVE      #ISO          SLDATE
005500060828     C                   UPDATE    FSUBLTR
005600060928     C                   EXSR      $HISTREC
005700060828     C                   ENDIF
005800060828    ***
005900060920   S***S
006000060920     C     $HISTREC      BEGSR
006100060920    ***
006200131007     C                   CALL      'TIMESTMP'
006300131007     C                   PARM                    @TS40
006400131007     C                   EVAL      P@40 = @TS40
006500131007    ***
006600060920     C                   CLEAR                   HISTR
006700060920     C                   EVAL      %SUBST(HKEY:2:9) = %EDITC(SLSSNO:'X')
006800060920     C                   EVAL      TRCODE = 'U42'
006900060920     C                   EVAL      TRAMT = *ZEROS
007000060920     C                   EVAL      HDSEQ# = SLSEQ#
007100131007     c                   eval      hprgnm = thispgmname
007200110614     C                   EVAL      HSTRST = mbtrst
007300110614     C                   EVAL      HSSUB# = mbsub#
007400110614     C                   EVAL      HSACCT = mbacct
007500131007     c                   MoveL(p)  @TSUSER       hoper
007600060920     C                   EVAL      HSDLTD = 'A'
007700060920     C                   EVAL      HINVDT = *ZERO
007800060920     C                   EVAL      RECVDT = *ZERO
007900060920     C                   EVAL      COVTDT = SLTRAN
008000131007     c                   Eval      trdate = #TSCYMD
008100131007     c                   eval      hstrtime = %time
008200060920     C                   WRITE     HISTR
008300060920    ***
008400060920     C                   ENDSR
008500210729
008600210729   S* *******************************
008700210729   S* * GENERATE LETTER
008800210729   S* *******************************
008900060828     C     $GENLTR       BEGSR
009000060828    ***
009100060828     c                   Eval      @tday = %EditC(#tday:'Y')
009200060828     c     slssno        Chain     membr
009300130523     C                   EVAL      KX = '"' + %EDITC(MBTRST:'X') + '-' +
009400130523     C                             %EDITC(MBSUB#:'X') + '-' +
009500130523     C                             %EDITC(MBACCT:'X') + '","' +
009600130523     C                             %TRIM(MLNAME) + ', ' + %TRIM(MFNAME) +
009700130523     C                             '","' + %EDITC(MBSSNO:'X') + '"'
009800130523     C                   EXCEPT    OUTF
009900060828     c                   Move      zip           @9
010000060828     c                   Eval      z5 = %SubSt(@9:1:5)
010100210729     c                   EVAL      P1DATE = %trim(@tday)
010200060831     c                   if        mmi <> *blanks
010300060831     c                   Eval      p1name = %Trim(mfname) + ' ' + mmi +
010400060831     c                             ' ' + %Trim(mlname)
010500060831     c                   else
010600060831     c                   Eval      p1name = %Trim(mfname) + ' ' + %Trim(mlname)
010700060831     c                   endif
010800060831     c                   Eval      p1name = %Trim(p1name) + ' ' + 'and Spouse' +
010900060828     c                             ' (If Any)'
011000060828     C                   Eval      p1addr = %Trim(addr1)
011100060831     C                   Eval      p1add2 = %Trim(addr2)
011200060828     c                   Eval      p1csz = %Trim(city) + ', ' + state + ' ' + z5
011300210804    * *
011400210804    * * date and mailing address
011500210804    * *
011600210804     C                   EVAL      P1L1 = P1DATE
011700210804     C                   EVAL      P1L2 = *BLANKS
011800210804     C                   EVAL      P1L3 = P1NAME
011900210804     C                   EVAL      P1L4 = P1ADDR
012000210804
012100060831     C                   IF        P1ADD2 = *BLANKS
012200210804     C                   EVAL      P1L5 = P1CSZ
012300210804     C                   EVAL      P1L6 = *blanks
012400060831     C                   ELSE
012500060831     C                   EVAL      P1L5 = P1ADD2
012600060831     C                   EVAL      P1L6 = P1CSZ
012700060831     C                   ENDIF
012800060828    ***
012900120605     C     KL#TSA        KLIST
013000120605     C                   KFLD                    MBTRST
013100120605     C                   KFLD                    MBSUB#
013200120605     C                   KFLD                    MBACCT
013300120605     C     KL#TSA        CHAIN     C2F
013400120605     c                   EVAL      P1RE = C2REMK
013500210729
013600210729      * Page 1 gets letter head ovelay
013700210729     c                   write     lethdol
013800210729     C                   WRITE     varp1
013900210729     C                   WRITE     PAGSEG1
014000210729      * Page 2
014100210729     C                   WRITE     PAGSEG2
014200210729      * Page 3
014300210729     C                   WRITE     PAGSEG3
014400210729      * Page 4
014500210729     C                   WRITE     varp4
014600210729     C                   WRITE     PAGSEG4
014700210729    *
014800060828     C                   ENDSR
014900210729
015000210729      *
015100210729      * First cycle
015200210729      *
015300210729     C     *INZSR        BEGSR
015400210729    ***
015500210729     C                   Move      *DATE         #iso
015600210729     c                   Move      #iso          #TISO             8 0
015700210729     c     *USA          Move      #iso          #tday
015800210729    ***
015900210729     C                   EVAL      KX = '"ACCOUNT","NAME","SSN"'
016000210729     C                   EXCEPT    OUTF
016100210729
016200210729      * page 4 variables
016300210729     c                   EVAL      P4ANAM  = 'AMWINS CONNECT ADMINISTRATORS'
016400210729     c                   EVAL      P4AADR  = '6 NORTH PARK DRIVE, SUITE 310'
016500210729     c                   EVAL      P4ACSZ  = 'HUNT VALLEY, MD  21030'
016600210729     c                   EVAL      P4CEMAIL = 'gbs.cobradmins@amwins.com'
016700210729    ***
016800210729     C                   ENDSR
016900210729   S*
017000130523     OT100      EADD         OUTF
017100130523     O                       KX             B   100
