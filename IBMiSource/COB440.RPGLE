000100110614   X***X SUBSCRIBER INITIAL NOTICE APPLICATION
000200110614   X***X VALID MEMBER SEARCH PROGRAM
000300110614   X***X
000400110614   X***X CURRENT ACCOUNTS:
000500110614   X***X
000600110614   X***X 590 012 0008 MARICOM SYSTEMS, INC.
000700110614   X***X 591 004 0286 PHASE ONE CONSULTING GROUP, INC.
000800110614   X***X
000900120522   X***X SSK ORIGINAL SOURCE 05/23/2006
001000120522   X***X
001100120522   X***X SSK01 06/14/2011 CHANGE IF FOR MULTIPLE ACCOUNTS
001200120522   X***X SSK02 05/22/2012 FORMERLY PROGRAM SUBLETEXT
001300120522   X***X                  MODIFICATIONS MADE TO USE COB 440 WORK FILE 2 AS CONTR
001400120522   X***X                    FOR EXTRACTION AND TO REMOVE HARD CODES BY ACCOUNT.
001500120522   X***X                  USE PROPER DATE SETTING METHOD AND NOT TRUST *DATE
001600120522   X***X
001700130509   X***X SSK 05/09/2013 FIX PROBLEM WITH MISSING BACK FILLED ACCOUNTS.
001800120522   X***X
001900120522   X***X
002000120530     FCOB440W2  IF   E           K DISK
002100120530     FCOB440W1  IF A E           K DISK
002200120605     FCOB440W3  UF A E           K DISK
002300130509     FCOB440W4  UF A E           K DISK
002400120604     FMEMAC#1   IF   E           K DISK
002500120530     FDEPNDC    IF   E           K DISK
002600120605     FMCOV      IF   E           K DISK
002700120604     FACMUNIQUE IF   E           K DISK
002800120530     FHISTLB    IF   E           K DISK
002900060822   X***X
003000120530     D @PROC           S             10A
003100120604     D @9              S              9A
003200120530    ***
003300121206     d #XSX            s              8s 0
003400120530     d ext#from        s              8s 0
003500120530     d ext#to          s              8s 0
003600120530     d #iso            s               d   datfmt(*ISO)
003700120530    ***
003800120604     D KF@SSN          S              9S 0
003900120530    ***
004000120604     D VALID_MBR       S               N   INZ(*OFF)
004100120604     D VALID_PLN       S               N   INZ(*OFF)
004200120604     D NO              S               N   INZ(*OFF)
004300120604     D YES             S               N   INZ(*ON)
004400120530    ***
004500120530    ***
004600120530   X***X
004700120530     C                   MOVEL(P)  'INITIALIZE'  @PROC
004800120530    ***
004900120530     C                   DOU       @PROC = 'LEAVE LOOP'
005000120604     C     @PROC         CASEQ     'INITIALIZE'  $INITL
005100120530     C     @PROC         CASEQ     '440 LOOP  '  $440LOOP
005200120530     C     @PROC         CASEQ     'HIST LOOP '  $HSTLOOP
005300120530     C     @PROC         CASEQ     'MEMBER LTR'  $MBRLTR
005400120530     C     @PROC         CASEQ     'DEPEND LTR'  $DEPLTR
005500120604     C     @PROC         CASEQ     'RESET DRVR'  $RSTDRV
005600120604     C     @PROC         CASEQ     'REINSTATES'  $RNSTTS
005700120605     C     @PROC         CASEQ     'CHK 4 REIN'  $CHK4REIN
005800120530     C                   ENDCS
005900120530     C                   ENDDO
006000120530    ***
006100120530     C                   EVAL      *INLR = *ON
006200120530    ***
006300120604     C     $INITL        BEGSR
006400120604    ***
006500120604     C     *DTAARA       DEFINE    SUBLTRDATE    @EXTDTE           8
006600120604     C     *LOCK         IN        @EXTDTE
006700120604     C                   MOVE      @EXTDTE       EXT#FROM
006800120604     C                   EVAL      #ISO = %DATE
006900120604     c                   MOVE      #ISO          EXT#TO
007000121206    ***
007100121206     C                   SUBDUR    1:*D          #ISO
007200121206     c                   MOVE      #ISO          #XSX
007300121206     C                   MOVE      #XSX          @EXTDTE
007400120604     C                   OUT       @EXTDTE
007500120604     C                   UNLOCK    @EXTDTE
007600120604    ***
007700120604     C     KL#TSA        KLIST
007800120604     C                   KFLD                    C2TRST
007900120604     C                   KFLD                    C2SUB#
008000120604     C                   KFLD                    C2ACCT
008100120604    ***
008200120604     C     KL#SSQ        KLIST
008300120604     C                   KFLD                    KF@SSN
008400120604     C                   KFLD                    KF@SEQ
008500120604    ***
008600120604     C     KL#TSAD       KLIST
008700120604     C                   KFLD                    C2TRST
008800120604     C                   KFLD                    C2SUB#
008900120604     C                   KFLD                    C2ACCT
009000120604     C                   KFLD                    EXT#FROM
009100120604    ***
009200130508     C     KL#W3F        KLIST
009300130508     C                   KFLD                    MBTRST
009400130508     C                   KFLD                    MBSUB#
009500130508     C                   KFLD                    MBACCT
009600130508     C                   KFLD                    MBSSNO
009700130508    ***
009800120604     C     KL#TSAS       KLIST
009900120604     C                   KFLD                    C2TRST
010000120604     C                   KFLD                    C2SUB#
010100120604     C                   KFLD                    C2ACCT
010200120604     C                   KFLD                    KF@SSN
010300120604    ***
010400120604     C                   MOVEL(P)  '440 LOOP  '  @PROC
010500120604    ***
010600120604     C                   ENDSR
010700120530   S***S
010800120530     C     $440LOOP      BEGSR
010900120530    ***
011000120530     C                   READ      C2F
011100120530    ***
011200120530     C                   IF        %EOF(COB440W2)
011300120604     C                   EVAL      @PROC = 'RESET DRVR'
011400120530     C                   LEAVESR
011500120530     C                   ENDIF
011600120530    ***
011700120530     C                   IF        C2ENDDT > 0 OR C2PROC = 'N'
011800120530     C                   LEAVESR
011900120530     C                   ENDIF
012000120530    ***
012100120530     C     KL#TSA        CHAIN     ACCMSR
012200120605     C                   IF        ATRMDT > 0 OR FCSTFL <> 'F'
012300120530     C                   LEAVESR
012400120530     C                   ENDIF
012500120530    ***
012600120530     C     KL#TSAD       SETLL     HISTR
012700120530    ***
012800120530     C                   EVAL      @PROC = 'HIST LOOP '
012900120530    ***
013000120530     C                   ENDSR
013100120530   S***S
013200120530     C     $HSTLOOP      BEGSR
013300120530    ***
013400120530     C     KL#TSA        READE     HISTR
013500120604    ***
013600120604    *** END OF FILE, LEAVE
013700120530    ***
013800120530     C                   IF        %EOF(HISTLB)
013900120530     C                   EVAL      @PROC = '440 LOOP  '
014000120530     C                   LEAVESR
014100120530     C                   ENDIF
014200120604    ***
014300120604    *** MUST BE MEMBER OR DEPENDENT ADD TRANSCTION
014400120604    ***
014500131007    *** 10/07/2013 PHASE OUT USE OF MDA
014600131007    ***
014700131007     c*******************IF        TRCODE <> 'MMA' AND TRCODE <> 'MDA'
014800131007     c                   IF        TRCODE <> 'MMA' AND TRCODE <> 'MDB'
014900131007     C                             AND TRCODE <> 'M41'
015000120530     C                   LEAVESR
015100120530     C                   ENDIF
015200120604    ***
015300120604    *** AVOID PROCESSING SAME DATE AGAIN
015400120604    ***
015500120530     c                   IF        TRDATE = EXT#FROM
015600120530     C                   LEAVESR
015700120530     C                   ENDIF
015800120530    ***
015900120604    *** PREPARE KEY VALUES
016000120604    ***
016100120530     C                   EVAL      @9 = %SUBST(HKEY:2:9)
016200120604     C                   MOVE      @9            KF@SSN
016300120604     C                   MOVE      00            KF@SEQ
016400120530    ***
016500120604    *** MEMBER ADD TRANSACTION; EXECUTE LETTER ROUTINE
016600120604    ***
016700120530     C                   IF        TRCODE = 'MMA'
016800120530     C                   EVAL      @PROC = 'MEMBER LTR'
016900120530     C                   LEAVESR
017000120530     C                   ENDIF
017100120530    ***
017200120604    *** DEPEND ADD TRANSACTION BY DEFAULT; EXECUTE LETTER ROUTINE
017300131007    ***
017400131007    *** 10/07/2013 SSK MODIFICATION FOR REL CODE CHANGE AND DEPENDENT ADD
017500131007    ***
017600131007     C                   MOVE      HDSEQ#        KF@SEQ            2 0
017700131007    ***
017800131007    *** 10/07/2013 SSK MOD IF REL CODE RESULT IS NOT = TO SPOUSE, SKIP IT
017900131007    ***
018000131007     C     KL#SSQ        CHAIN     DEPENR
018100131007     C                   IF        NOT %FOUND(DEPNDC)
018200131007     C                   LEAVESR
018300131007     C                   ENDIF
018400131010    ***
018500131007     C                   IF        DRELCD <> 'S'
018600131007     C                   LEAVESR
018700131007     C                   ENDIF
018800120604    ***
018900120530     C                   EVAL      @PROC = 'DEPEND LTR'
019000120530    ***
019100120530     C                   ENDSR
019200120530   S***S
019300120530     C     $MBRLTR       BEGSR
019400120530    ***
019500120606     C                   EVAL      @PROC = 'HIST LOOP '
019600120606    ***
019700120604     C     KF@SSN        CHAIN     FSUBLTR
019800120530    ***
019900120604    *** IF ALREADY PROCESSED TODAY; SKIP IT
020000120604    ***
020100120604     C                   IF        %FOUND(COB440W1)
020200120604     C                   LEAVESR
020300120604     C                   ENDIF
020400120604    ***
020500120604    *** MUST BE A VALID MEMBER
020600120604    ***
020700120604     C                   EXSR      $CHKMBR
020800120604     C                   IF        VALID_MBR = NO
020900120604     C                   LEAVESR
021000120604     C                   ENDIF
021100120604    ***
021200120604    *** MUST HAVE A VALID PLAN ACTIVE
021300120604    ***
021400120604     C                   EXSR      $MPLAN
021500120604     C                   IF        VALID_PLN = NO
021600120604     C                   LEAVESR
021700120604     C                   ENDIF
021800120604    ***
021900120604    *** LOAD INTO LETTER CREATION FILE
022000120604    ***
022100120530     C                   CLEAR                   FSUBLTR
022200120530     C                   EVAL      SLSSNO = KF@SSN
022300120530     C                   EVAL      SLSEQ# = 00
022400120530     C                   EVAL      SLDATE = 00010101
022500120530     C                   EVAL      SLTRAN = TRDATE
022600120530     C                   WRITE     FSUBLTR
022700120604    ***
022800120604    *** ADD THEM TO THE REINSTATEMENT TRACKING FILE
022900120604    ***
023000120604     C                   CLEAR                   C3F
023100120604     C                   EVAL      C3TRST = MBTRST
023200120604     C                   EVAL      C3SUB# = MBSUB#
023300120604     C                   EVAL      C3ACCT = MBACCT
023400120604     C                   EVAL      C3SSNO = MBSSNO
023500120604     C                   EVAL      C3HIRE = EMPDT
023600120604     C                   EVAL      C3TERM = 0
023700120604     C                   WRITE     C3F
023800120530    ***
023900120604    *** WHEN A MEMBER ADD; AUTOMATICALLY FILL IN DEPENDENT INFORMATION;
024000120604    ***   ELSE WE WILL GENERATE TWO LETTERS INSTEAD OF ONE.
024100120604    ***
024200120530     C                   EXSR      $FILLDEP
024300120604    ***
024400120604     C                   ENDSR
024500120604   S***S
024600120604     C     $CHKMBR       BEGSR
024700120604    ***
024800120604     C                   EVAL      VALID_MBR = NO
024900120604    ***
025000120604    *** MUST EXIST ON THE MEMBER FILE
025100120604    ***
025200120604     C     KL#TSAS       CHAIN     MEMBR
025300120604     C                   IF        NOT %FOUND(MEMAC#1)
025400120604     C                   LEAVESR
025500120604     C                   ENDIF
025600120604    ***
025700120606    *** CANNOT BE ON COBRA
025800120604    ***
025900120606     C                   IF        EMPST <> 'A'
026000120604     C                   LEAVESR
026100120604     C                   ENDIF
026200130508    ***
026300130508    *** CANNOT BE TERMED
026400130508    ***
026500130508     C                   IF        TERMDT > 0
026600130508     C                   LEAVESR
026700130508     C                   ENDIF
026800120606    ***
026900130508    *** CANNOT BE ON REINSTATEMENT FILE ALREADY; WOULD CAUSE DUPE KEY
027000120606    ***
027100130508     C     KL#W3F        CHAIN     C3F
027200130508     C                   IF        %FOUND(COB440W3)
027300130508     C                   LEAVESR
027400130508     C                   ENDIF
027500120604    ***
027600120604     C                   EVAL      VALID_MBR = YES
027700120604    ***
027800120604     C                   ENDSR
027900120604   S***S
028000120604     C     $MPLAN        BEGSR
028100120604    ***
028200120606     C                   EVAL      VALID_PLN = YES
028300120606    ***
028400120606    ***
028500120606    ***
028600120604    *** MEMBER MUST HAVE ANOTHER ACTIVE PLAN BEYOND JUST 401K AND ROTH PLANS
028700120604    ***  OTHERWISE, WE MUST SKIP THEM FOR THE LETTER.
028800120604    ***
028900120606    *C*                  EVAL      VALID_PLN = NO
029000120606    ***
029100120606    *C*    MBSSNO        CHAIN     MCOVR
029200120606    *C*                  IF        NOT %FOUND(MCOV)
029300120606    *C*                  LEAVESR
029400120606    *C*                  ENDIF
029500120606    ***
029600120606    *C*    MBSSNO        SETLL     MCOVR
029700120606    *C*                  DOU       %EOF(MCOV)
029800120606    *C*    MBSSNO        READE     MCOVR
029900120606    *C*                  IF        NOT %EOF(MCOV) AND
030000120606    *C*                            CANDT = 0
030100120606    ***
030200120606    *C*                  IF        MCPLAN = '401%' OR
030300120606    *C*                            MCPLAN = 'ROT%' OR
030400120606    *C*                            MCPLAN = '$BEN' OR
030500120606    *C*                            MCPLAN = 'ROT$' OR
030600120606    *C*                            MCPLAN = '401$'
030700120606    *C*                  ITER
030800120606    *C*                  ENDIF
030900120606    ***
031000120606    *C*                  EVAL      VALID_PLN = YES
031100120606    *C*                  LEAVESR
031200120606    ***
031300120606    *C*                  ENDIF
031400120606    *C*                  ENDDO
031500120604    ***
031600120530     C                   ENDSR
031700120530   S***S
031800120604    *** FILL IN SPOUSE RECORDS FOR A NEW MEMBER ADD; PREVENTING DUPLICATE LETTER
031900120604    ***
032000120530     C     $FILLDEP      BEGSR
032100120530    ***
032200120530     C     KF@SSN        SETLL     DEPENR
032300120530     C                   DOU       %EOF(DEPNDC)
032400120530     C     KF@SSN        READE     DEPENR
032500120530     C                   IF        NOT %EOF(DEPNDC)
032600120530     C*
032700120530     C                   IF        DRELCD = 'RHU' OR DRELCD = 'RWI'
032800120530     C                   CLEAR                   FSUBLTR
032900120530     C                   EVAL      SLSSNO = DSSNO
033000120530     C                   EVAL      SLSEQ# = DPSEQ#
033100120530     C                   EVAL      SLDATE = EXT#TO
033200120530     C                   EVAL      SLTRAN = TRDATE
033300120530     C                   WRITE     FSUBLTR
033400130509     C                   CLEAR                   C4F
033500130509     C                   EVAL      C4SSNO = DSSNO
033600130509     C                   EVAL      C4SEQ  = DPSEQ#
033700130509     C                   WRITE(E)  C4F
033800120530     C                   ENDIF
033900120530     C*
034000120530     C                   ENDIF
034100120530     C                   ENDDO
034200120530    ***
034300120530     C                   ENDSR
034400120530   S***S
034500120604    *** DEPENDENT SPAWNED LETTER
034600120604    ***
034700120530     C     $DEPLTR       BEGSR
034800120606    ***
034900120606     C                   EVAL      @PROC = 'HIST LOOP '
035000120530    ***
035100120604    *** DEPENDENT MUST EXIST ON DEPENENT MASTER FILE
035200120604    ***
035300120530     C     KL#SSQ        CHAIN     DEPENR
035400120530     C                   IF        NOT %FOUND(DEPNDC)
035500120530     C                   LEAVESR
035600120530     C                   ENDIF
035700120604    ***
035800120604    *** DEPENDENT MUST BE A SPOUSE
035900120604    ***
036000120530     C                   IF        DRELCD <> 'RHU' AND DRELCD <> 'RWI'
036100120530     C                   LEAVESR
036200120530     C                   ENDIF
036300120530    ***
036400120604    *** DOUBLE CHECK WE DO NOT HAVE MEMBER ALREADY ON FILE
036500120604    ***
036600120604     C     KF@SSN        CHAIN     FSUBLTR
036700120604     C                   IF        %FOUND(COB440W1)
036800120604     C                   LEAVESR
036900120604     C                   ENDIF
037000120604    ***
037100120604    *** DOUBLE CHECK WE DO NOT HAVE DEPENDENT ALREADY ON FILE
037200120604    ***
037300120530     C     KL#SSQ        CHAIN     DEPENR
037400120604     C                   IF        %FOUND(COB440W1)
037500120604     C                   LEAVESR
037600120604     C                   ENDIF
037700130509    ***
037800130509    *** DOUBLE CHECK WE DO NOT HAVE DEPENDENT WROTE IN THE PAST
037900130509    ***
038000130509     C     KL#SSQ        CHAIN     C4F
038100130509     C                   IF        %FOUND(COB440W4)
038200130509     C                   LEAVESR
038300130509     C                   ENDIF
038400120604    ***
038500120604    *** MUST BE A VALID MEMBER
038600120604    ***
038700120604     C                   EXSR      $CHKMBR
038800120604     C                   IF        VALID_MBR = NO
038900120604     C                   LEAVESR
039000120604     C                   ENDIF
039100120604    ***
039200120604    *** MUST HAVE A VALID PLAN ACTIVE
039300120604    ***
039400120604     C                   EXSR      $MPLAN
039500120604     C                   IF        VALID_PLN = NO
039600120604     C                   LEAVESR
039700120604     C                   ENDIF
039800120604    ***
039900120604    *** OK, GOOD TO GO.
040000120604    ***
040100120530     C                   CLEAR                   FSUBLTR
040200120530     C                   EVAL      SLSSNO = DSSNO
040300120530     C                   EVAL      SLSEQ# = DPSEQ#
040400120530     C                   EVAL      SLDATE = 00010101
040500120530     C                   EVAL      SLTRAN = TRDATE
040600120530     C                   WRITE     FSUBLTR
040700130509     C                   CLEAR                   C4F
040800130509     C                   EVAL      C4SSNO = DSSNO
040900130509     C                   EVAL      C4SEQ  = DPSEQ#
041000140721     C                   WRITE(E)  C4F
041100120530    ***
041200120604     C                   ENDSR
041300120604   S***S
041400120604    *** RESET DRIVER FILE
041500120604    ***
041600120604     C     $RSTDRV       BEGSR
041700120604    ***
041800120604     C                   MOVE      *ZEROS        #3                3 0
041900120604    ***
042000120604     C     #3            SETLL     C2F
042100120604    ***
042200120604     C                   EVAL      @PROC = 'REINSTATES'
042300120604    ***
042400120604     C                   ENDSR
042500120604   S***S
042600120604    *** REINSTATEMENTS
042700120604    ***
042800120604     C     $RNSTTS       BEGSR
042900120604    ***
043000120604     C                   READ      C2F
043100120604    ***
043200120604     C                   IF        %EOF(COB440W2)
043300120604     C                   EVAL      @PROC = 'LEAVE LOOP'
043400120604     C                   LEAVESR
043500120604     C                   ENDIF
043600120604    ***
043700120604     C                   IF        C2ENDDT > 0 OR C2PROC = 'N'
043800120604     C                   LEAVESR
043900120604     C                   ENDIF
044000120604    ***
044100120604     C     KL#TSA        CHAIN     ACCMSR
044200120604     C                   IF        TERMDT > 0 OR FCSTFL <> 'F'
044300120604     C                   LEAVESR
044400120604     C                   ENDIF
044500120604    ***
044600120604     C     KL#TSA        CHAIN     C3F
044700120604     C                   IF        NOT %FOUND(COB440W3)
044800120604     C                   LEAVESR
044900120604     C                   ENDIF
045000120605    ***
045100120605     C     KL#TSA        SETLL     C3F
045200120605    ***
045300120605     C                   EVAL      @PROC = 'CHK 4 REIN'
045400120605    ***
045500120605     C                   ENDSR
045600120605   S***S
045700120605    *** CHECK THE MEMBERS
045800120605    ***
045900120605     C     $CHK4REIN     BEGSR
046000120605    ***
046100120605     C     KL#TSA        READE     C3F
046200120605    ***
046300120605     C                   IF        %EOF(COB440W3)
046400120605     C                   EVAL      @PROC = 'REINSTATES'
046500120605     C                   LEAVESR
046600120605     C                   ENDIF
046700120605    ***
046800120605     C                   EVAL      KF@SSN = C3SSNO
046900120605     C     KL#TSAS       CHAIN     MEMBR
047000120605    ***
047100120605     C                   IF        (C3TERM = 0 AND TERMDT = 0 AND
047200120605     C                              EMPST = 'A') OR
047300120605     C                             (C3TERM > 0 AND TERMDT > 0 AND
047400120605     C                              EMPST = 'A') OR
047500120605     C                             (C3TERM > 0 AND TERMDT = 0 AND
047600120605     C                              EMPST = 'C') OR
047700120605     C                             (C3TERM > 0 AND TERMDT > 0 AND
047800120605     C                              EMPST = 'C')
047900120605     C                   LEAVESR
048000120605     C                   ENDIF
048100120605    ***
048200120605     C                   IF        C3TERM > 0 AND TERMDT = 0 AND
048300120605     C                             EMPST = 'A'
048400120605     C                   EVAL      C3TERM = 0
048500120605     C                   UPDATE    C3F
048600120605     C                   EXSR      $REGEN
048700120605     C                   LEAVESR
048800120605     C                   ENDIF
048900120605    ***
049000120605     C                   IF        C3TERM = 0 AND TERMDT > 0 AND
049100120605     C                             EMPST = 'A'
049200120605     C                   EVAL      C3TERM = TERMDT
049300120605     C                   UPDATE    C3F
049400120605     C                   LEAVESR
049500120605     C                   ENDIF
049600120605    ***
049700120605     C                   IF        C3TERM = 0 AND TERMDT = 0 AND
049800120605     C                             EMPST = 'C'
049900120605     C                   EVAL      C3TERM = QEDT
050000120605     C                   UPDATE    C3F
050100120605     C                   LEAVESR
050200120605     C                   ENDIF
050300120605    ***
050400120605     C                   IF        C3TERM = 0 AND TERMDT > 0 AND
050500120605     C                             EMPST = 'C'
050600120605     C                   EVAL      C3TERM = TERMDT
050700120605     C                   UPDATE    C3F
050800120605     C                   LEAVESR
050900120605     C                   ENDIF
051000120605    ***
051100120605     C                   ENDSR
051200120605   S***S
051300120605     C     $REGEN        BEGSR
051400120605    ***
051500120605    *** MUST BE A VALID MEMBER
051600120605    ***
051700120605     C                   EXSR      $CHKMBR
051800120605     C                   IF        VALID_MBR = NO
051900120605     C                   LEAVESR
052000120605     C                   ENDIF
052100120605    ***
052200120605    *** MUST HAVE A VALID PLAN ACTIVE
052300120605    ***
052400120605     C                   EXSR      $MPLAN
052500120605     C                   IF        VALID_PLN = NO
052600120605     C                   LEAVESR
052700120605     C                   ENDIF
052800120605    ***
052900120605    *** LOAD INTO LETTER CREATION FILE
053000120605    ***
053100120605     C                   CLEAR                   FSUBLTR
053200120605     C                   EVAL      SLSSNO = KF@SSN
053300120605     C                   EVAL      SLSEQ# = 00
053400120605     C                   EVAL      SLDATE = 00010101
053500120605     C                   EVAL      SLTRAN = TRDATE
053600120605     C                   WRITE     FSUBLTR
053700120530    ***
053800120530     C                   ENDSR
053900120530   S***S
