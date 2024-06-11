000100130909     Hnomain option(*nodebugio) debug copyright('GBS - GroupBenefitServices')
000200140123     Hbnddir('MBRSRVPGM')
000300130909
000400130909      *------------------------------------------------------------------
000500140102      * Module Name...MBRSRVPGM
000600130909      * Written by...:Debora Bond
000700140102      * Date Written.:01/02/2014
000800140102      * Description..:Module within service program MBRSRVPGM....functions
000900140104      *               related to MEMBER
001000130909      * Called From..:Any program
001100130909      *
001200140104      *?Note to programmers:  this pgm use a copy member in RPGSPPAYR lib
001300130909      *------------------------------------------------------------------
001400130909      * Modification History:
001500130909      *
001600130909      *    Date    Description                                       By
001700130909      *  --------  -----------------------------------------        ----
001800140605      *  06052014  ADD MTRANS DATE RETRIEVAL                         SSK
001900140605      *  06052014  ADD DCOV DATE RETRIEVAL                           SSK
002000140605      *
002100140605      *
002200130909      *------------------------------------------------------------------
002300130909
002400140102     Fmember    if   e           k disk    extfile('F.MEMBER') usropn
002500140123     fmcovapse  if   e           k disk    usropn
002600140605     FDCOV22    IF   E           K DISK    USROPN EXTFILE('F.DCOV22')
002700140605     FMTRANSAPSEIF   E           K DISK    USROPN
002800130909
002900140104      *---------------------------------------------------------------------
003000140104      * Function to retrieve member name
003100140104      *---------------------------------------------------------------------
003200140104     P #get_mbr_name   b                   export
003300140104
003400140104      /define get_mbr_name_pi
003500140104      /define get_mbr_name_fields
003600140104      /copy qcpysrc,mbrsrvpgmp
003700140104      /undefine get_mbr_name_fields
003800140104      /undefine get_mbr_name_pi
003900140104
004000140104      /free
004100140104
004200140104       #mbr_openfiles('MEMBER') ;
004300140104
004400140104       chain (p_mbrssn) member ;
004500140104       if not %found(member) ;
004600140104        return *blanks ;
004700140104       elseif %parms() = 1 ;
004800140104        return mlname + mfname + mmi ;
004900140104       else ;
005000140104        return %trim(mlname) + ', ' + %trim(mfname) + ' ' + %trim(mmi) ;
005100140104       endif ;
005200140104
005300140104      /end-free
005400140104
005500140104     P #get_mbr_name   e
005600140104
005700130909      *---------------------------------------------------------------------
005800130909      *
005900130909      *---------------------------------------------------------------------
006000140102     P #mbr_openfiles  b
006100130909
006200140102     d #mbr_openfiles  pi
006300130909     D  file                         10    value
006400130909
006500130909      /free
006600130909
006700140102       if file = 'MEMBER' ;
006800140102        if not %open(member) ;
006900140102         open member ;
007000130909        endif ;
007100130909       endif ;
007200140102
007300140123       if file = 'MCOVAPSE' ;
007400140123        if not %open(mcovapse) ;
007500140123         open mcovapse ;
007600140123        endif ;
007700140123       endif ;
007800140123
007900140605       IF FILE = 'DCOV22' ;
008000140605        IF NOT %OPEN(DCOV22) ;
008100140605         OPEN DCOV22 ;
008200140605        ENDIF ;
008300140605       ENDIF ;
008400140605
008500140605       IF FILE = 'MTRANSAPSE' ;
008600140605        IF NOT %OPEN(MTRANSAPSE) ;
008700140605         OPEN MTRANSAPSE ;
008800140605        ENDIF ;
008900140605       ENDIF ;
009000140605
009100130909      /end-free
009200130909
009300140102     P #mbr_openfiles  e
009400130909      *---------------------------------------------------------------------
009500130909      *
009600130909      *---------------------------------------------------------------------
009700140102     P #mbr_closesrv   b                   export
009800130909
009900140102      /define mbr_closesrv_pi
010000140102      /copy qcpysrc,mbrsrvpgmp
010100140102      /undefine mbr_closesrv_pi
010200130909
010300130909      /free
010400130909
010500130909       close *all ;
010600130909
010700130909      /end-free
010800130909
010900140102     P #mbr_closesrv   e
011000140123
011100140123      *---------------------------------------------------------------------
011200140123      *
011300140123      *---------------------------------------------------------------------
011400140123     P #verify_mcv_date...
011500140123     P                 B                   export
011600140123    *
011700140123      /DEFINE VERIFY_MCV_DATE_PI
011800140123      /DEFINE VERIFY_MCV_DATE_FIELDS
011900140123      /copy qcpysrc,mbrsrvpgmp
012000140123      /UNDEFINE VERIFY_MCV_DATE_PI
012100140123      /UNDEFINE VERIFY_MCV_DATE_FIELDS
012200140123    *
012300140123     D KF@TRS          S                   LIKE(MCTRST)
012400140123     D KF@SUB          S                   LIKE(MCSUB#)
012500140123     D KF@ACC          S                   LIKE(ACC#)
012600140123     D KF@PLN          S                   LIKE(MCPLAN)
012700140123     D KF@SSN          S                   LIKE(MCSSNO)
012800140123    *
012900140123     D ENRLDT@         S              8S 0 DIM(20)
013000140123     D CANDT@          S              8S 0 DIM(20)
013100140123     D NDX             S              3S 0
013200140123     D CNE             S              3S 0
013300140123    *
013400140123     D #DATE           S              8S 0
013500140123     D #8D0            S              8S 0
013600140123     D #8D1            S              8S 0
013700140123     D #iso            s               d
013800140123    *
013900140123      /free
014000140123
014100140124       #mbr_openfiles('MCOVAPSE') ;
014200140123       exsr $prime ;
014300140123
014400140123       exsr $process ;
014500140123       return #date ;
014600140123    *
014700140123      /end-free
014800140123   S* *---------------------------------------------------------------------
014900140123     C     $PRIME        BEGSR
015000140123   S* *---------------------------------------------------------------------
015100140123     C     KL#TSAPS      KLIST
015200140123     C                   KFLD                    KF@TRS
015300140123     C                   KFLD                    KF@SUB
015400140123     C                   KFLD                    KF@ACC
015500140123     C                   KFLD                    KF@PLN
015600140123     C                   KFLD                    KF@SSN
015700140123    *
015800140123     C                   CLEAR                   ENRLDT@
015900140123     C                   EVAL      MCV_RESULT = *BLANKS
016000140123     C                   CLEAR                   CANDT@
016100140123     C                   EVAL      NDX = 0
016200140123     C                   EVAL      CNE = 0
016300140123     C                   EVAL      #DATE = MCV_RQS
016400140123    *
016500140123     C                   EVAL      KF@TRS = MCV_TRS
016600140123     C                   EVAL      KF@SUB = MCV_SUB
016700140123     C                   EVAL      KF@ACC = MCV_ACC
016800140123     C                   EVAL      KF@PLN = MCV_PLN
016900140123     C                   EVAL      KF@SSN = MCV_SSN
017000140123    *
017100140123     C                   ENDSR
017200140123   S* *---------------------------------------------------------------------
017300140123     C     $PROCESS      BEGSR
017400140123   S* *---------------------------------------------------------------------
017500140123     C     KL#TSAPS      SETLL     MCOVR
017600140123     C                   DOU       %EOF(MCOVAPSE)
017700140123     C     KL#TSAPS      READE     MCOVR
017800140123     C                   IF        NOT %EOF(MCOVAPSE) AND
017900140123     C                             ENRLDT <> CANDT
018000140123    *
018100140123     C                   IF        CNE = 0
018200140123     C                   EXSR      $LOAD
018300140123     C                   ITER
018400140123     C                   ENDIF
018500140123    *
018600140123     C                   EVAL      #8D0 = CANDT@(CNE)
018700140123    *
018800140123    *** IF WE HAVE NO TERM DATE, THAT IS THE END OF THE RANGES.
018900140123     C                   IF        #8D0 = 0
019000140123     C                   LEAVE
019100140123     C                   ENDIF
019200140123    *
019300140123     C                   MOVE      #8D0          #ISO
019400140123     C                   ADDDUR    1:*D          #ISO
019500140123     C                   MOVE      #ISO          #8D1
019600140123    *
019700140123    *** CHECK FOR A BREAK IN COVERAGE
019800140123     C                   IF        ENRLDT = #8D0 OR ENRLDT = #8D1
019900140123     C                   EVAL      CANDT@(CNE) = CANDT
020000140123     C                   ITER
020100140123     C                   ENDIF
020200140123    *
020300140123     C                   EXSR      $LOAD
020400140123    *
020500140123     C                   ENDIF
020600140123     C                   ENDDO
020700140123    *
020800140123     C                   EXSR      $RUMMAGE
020900140123    *
021000140123     C                   ENDSR
021100140123   S* *---------------------------------------------------------------------
021200140123     C     $LOAD         BEGSR
021300140123   S* *---------------------------------------------------------------------
021400140123    *
021500140123     C                   ADD       1             CNE
021600140123     C                   EVAL      ENRLDT@(CNE) = ENRLDT
021700140123     C                   EVAL      CANDT@(CNE) = CANDT
021800140123    *
021900140123     C                   ENDSR
022000140123   S* *---------------------------------------------------------------------
022100140123     C     $RUMMAGE      BEGSR
022200140123   S* *---------------------------------------------------------------------
022300140123    *** FIND A MATCH, RUMMAGE THROUGH THE ARRAY
022400140123     C                   IF        CNE = 0
022500140123     C                   EVAL      MCV_RESULT = 'LOAD FAILED'
022600140123     C                   CLOSE(E)  MCOVAPSE
022700140123     C                   RETURN    #DATE
022800140123     C                   ENDIF
022900140123    *
023000140123     C                   EVAL      NDX = 0
023100140123    *
023200140123     C                   MOVE      *ZEROS        #TERM             8 0
023300140123     C                   DO        CNE
023400140123     C                   ADD       1             NDX
023500140123     C                   EVAL      #TERM = CANDT@(NDX)
023600140123     C                   IF        #TERM = 0
023700140123     C                   EVAL      #TERM = 99999999
023800140123     C                   ENDIF
023900140123     C                   IF        MCV_RQS >= ENRLDT@(NDX) AND
024000140123     C                             MCV_RQS <  #TERM
024100140123     C                   EXSR      $PONDER
024200140123     C                   LEAVESR
024300140123     C                   ENDIF
024400140123     C                   ENDDO
024500140123    *
024600140123     C                   EVAL      MCV_RESULT = 'COULD NOT FIND REQUEST'
024700140123     C                   CLOSE(E)  MCOVAPSE
024800140123     C                   RETURN    #DATE
024900140123    *
025000140123     C                   ENDSR
025100140123   S*
025200140123   S* *---------------------------------------------------------------------
025300140123     C     $PONDER       BEGSR
025400140123   S* *---------------------------------------------------------------------
025500140123    *
025600140123    *** COMPARE ENROLLMENT ARRAY AGAINST REQUESTED AGAINST RENEWAL
025700140123     C                   IF        ENRLDT@(NDX) >= MCV_RFR
025800140123     C                   EVAL      #DATE = ENRLDT@(NDX)
025900140123     C                   ELSE
026000140123     C                   EVAL      #DATE = MCV_RFR
026100140123     C                   ENDIF
026200140123    *
026300140123     C                   ENDSR
026400140123   S* *---------------------------------------------------------------------
026500140123     P #verify_mcv_date...
026600140123     P                 E
026700140605
026800140605
026900140605
027000140605
027100140605      *---------------------------------------------------------------------
027200140605      * MTRANS EARLIEST DATE
027300140605      *---------------------------------------------------------------------
027400140605     P #VERIFY_MTR_DATE...
027500140605     P                 B                   export
027600140605    *
027700140605      /DEFINE VERIFY_MTR_DATE_PI
027800140605      /DEFINE VERIFY_MTR_DATE_FIELDS
027900140605      /COPY QCPYSRC,MBRSRVPGMP
028000140605      /UNDEFINE VERIFY_MTR_DATE_PI
028100140605      /UNDEFINE VERIFY_MTR_DATE_FIELDS
028200140605    *
028300140605     D KF@TRS          S                   LIKE(MTTRST)
028400140605     D KF@SUB          S                   LIKE(MTSUB#)
028500140605     D KF@ACC          S                   LIKE(MTACC#)
028600140605     D KF@PLN          S                   LIKE(MTPLAN)
028700140605     D KF@SSN          S                   LIKE(MTSSNO)
028800140605     D KF@SEQ          S                   LIKE(MTSEQ#)
028900140605    *
029000140605     D ENRLDT@         S              8S 0 DIM(20)
029100140605     D CANDT@          S              8S 0 DIM(20)
029200140605     D NDX             S              3S 0
029300140605     D CNE             S              3S 0
029400140605    *
029500140605     D #DATE           S              8S 0
029600140605     D #8D0            S              8S 0
029700140605     D #8D1            S              8S 0
029800140605     D #ISO            S               D
029900140605    ***
030000140605
030100140605       #MBR_OPENFILES('MTRANSAPSE') ;
030200140605       EXSR $PRIME ;
030300140605
030400140605       EXSR $PROCESS ;
030500140605       RETURN #DATE ;
030600140605    *
030700140605    ***
030800140605   S* *---------------------------------------------------------------------
030900140605     C     $PRIME        BEGSR
031000140605   S* *---------------------------------------------------------------------
031100140605     C     KL#TSAPS      KLIST
031200140605     C                   KFLD                    KF@TRS
031300140605     C                   KFLD                    KF@SUB
031400140605     C                   KFLD                    KF@ACC
031500140605     C                   KFLD                    KF@PLN
031600140605     C                   KFLD                    KF@SSN
031700140605     C                   KFLD                    KF@SEQ
031800140605    *
031900140605     C                   CLEAR                   ENRLDT@
032000140605     C                   EVAL      MTR_RESULT = *BLANKS
032100140605     C                   CLEAR                   CANDT@
032200140605     C                   EVAL      NDX = 0
032300140605     C                   EVAL      CNE = 0
032400140605     C                   EVAL      #DATE = MTR_RQS
032500140605    *
032600140605     C                   EVAL      KF@TRS = MTR_TRS
032700140605     C                   EVAL      KF@SUB = MTR_SUB
032800140605     C                   EVAL      KF@ACC = MTR_ACC
032900140605     C                   EVAL      KF@PLN = MTR_PLN
033000140605     C                   EVAL      KF@SSN = MTR_SSN
033100140605     C                   EVAL      KF@SEQ = MTR_SEQ
033200140605    *
033300140605     C                   ENDSR
033400140605   S* *---------------------------------------------------------------------
033500140605     C     $PROCESS      BEGSR
033600140605   S* *---------------------------------------------------------------------
033700140605     C     KL#TSAPS      SETLL     MTRANSR
033800140605     C                   DOU       %EOF(MTRANSAPSE)
033900140605     C     KL#TSAPS      READE     MTRANSR
034000140605     C                   IF        NOT %EOF(MTRANSAPSE) AND
034100140605     C                             MTENRL <> MTCAN
034200140605    *
034300140605     C                   IF        CNE = 0
034400140605     C                   EXSR      $LOAD
034500140605     C                   ITER
034600140605     C                   ENDIF
034700140605    *
034800140605     C                   EVAL      #8D0 = CANDT@(CNE)
034900140605    *
035000140605    *** IF WE HAVE NO TERM DATE, THAT IS THE END OF THE RANGES.
035100140605     C                   IF        #8D0 = 0
035200140605     C                   LEAVE
035300140605     C                   ENDIF
035400140605    *
035500140605     C                   MOVE      #8D0          #ISO
035600140605     C                   ADDDUR    1:*D          #ISO
035700140605     C                   MOVE      #ISO          #8D1
035800140605    *
035900140605    *** CHECK FOR A BREAK IN COVERAGE
036000140605     C                   IF        MTENRL = #8D0 OR MTENRL = #8D1
036100140605     C                   EVAL      CANDT@(CNE) = MTCAN
036200140605     C                   ITER
036300140605     C                   ENDIF
036400140605    *
036500140605     C                   EXSR      $LOAD
036600140605    *
036700140605     C                   ENDIF
036800140605     C                   ENDDO
036900140605    *
037000140605     C                   EXSR      $RUMMAGE
037100140605    *
037200140605     C                   ENDSR
037300140605   S* *---------------------------------------------------------------------
037400140605     C     $LOAD         BEGSR
037500140605   S* *---------------------------------------------------------------------
037600140605    *
037700140605     C                   ADD       1             CNE
037800140605     C                   EVAL      ENRLDT@(CNE) = MTENRL
037900140605     C                   EVAL      CANDT@(CNE) = MTCAN
038000140605    *
038100140605     C                   ENDSR
038200140605   S* *---------------------------------------------------------------------
038300140605     C     $RUMMAGE      BEGSR
038400140605   S* *---------------------------------------------------------------------
038500140605    *** FIND A MATCH, RUMMAGE THROUGH THE ARRAY
038600140605     C                   IF        CNE = 0
038700140605     C                   EVAL      MTR_RESULT = 'LOAD FAILED'
038800140605     C                   CLOSE(E)  MTRANSAPSE
038900140605     C                   RETURN    #DATE
039000140605     C                   ENDIF
039100140605    *
039200140605     C                   EVAL      NDX = 0
039300140605    *
039400140605     C                   MOVE      *ZEROS        #TERM             8 0
039500140605     C                   DO        CNE
039600140605     C                   ADD       1             NDX
039700140605     C                   EVAL      #TERM = CANDT@(NDX)
039800140605     C                   IF        #TERM = 0
039900140605     C                   EVAL      #TERM = 99999999
040000140605     C                   ENDIF
040100140605     C                   IF        MTR_RQS >= ENRLDT@(NDX) AND
040200140605     C                             MTR_RQS <  #TERM
040300140605     C                   EXSR      $PONDER
040400140605     C                   LEAVESR
040500140605     C                   ENDIF
040600140605     C                   ENDDO
040700140605    *
040800140605     C                   EVAL      MTR_RESULT = 'COULD NOT FIND REQUEST'
040900140605     C                   CLOSE(E)  MTRANSAPSE
041000140605     C                   RETURN    #DATE
041100140605    *
041200140605     C                   ENDSR
041300140605   S*
041400140605   S* *---------------------------------------------------------------------
041500140605     C     $PONDER       BEGSR
041600140605   S* *---------------------------------------------------------------------
041700140605    *
041800140605    *** COMPARE ENROLLMENT ARRAY AGAINST REQUESTED AGAINST RENEWAL
041900140605     C                   IF        ENRLDT@(NDX) >= MTR_RFR
042000140605     C                   EVAL      #DATE = ENRLDT@(NDX)
042100140605     C                   ELSE
042200140605     C                   EVAL      #DATE = MTR_RFR
042300140605     C                   ENDIF
042400140605    *
042500140605     C                   ENDSR
042600140605   S* *---------------------------------------------------------------------
042700140605     P #VERIFY_MTR_DATE...
042800140605     P                 E
042900140605
043000140605
043100140605
043200140605
043300140605      *---------------------------------------------------------------------
043400140605      * DCOV DATE RETRIEVAL
043500140605      *---------------------------------------------------------------------
043600140605     P #VERIFY_DCV_DATE...
043700140605     P                 B                   EXPORT
043800140605    *
043900140605      /DEFINE VERIFY_DCV_DATE_PI
044000140605      /DEFINE VERIFY_DCV_DATE_FIELDS
044100140605      /COPY QCPYSRC,MBRSRVPGMP
044200140605      /UNDEFINE VERIFY_DCV_DATE_PI
044300140605      /UNDEFINE VERIFY_DCV_DATE_FIELDS
044400140605    *
044500140605     D KF@TRS          S                   LIKE(DVTRST)
044600140605     D KF@SUB          S                   LIKE(DVSUB#)
044700140605     D KF@PLN          S                   LIKE(DVPLAN)
044800140605     D KF@SSN          S                   LIKE(SSNO)
044900140605     D KF@SEQ          S                   LIKE(DSEQ#)
045000140605    *
045100140605     D ENRLDT@         S              8S 0 DIM(20)
045200140605     D CANDT@          S              8S 0 DIM(20)
045300140605     D NDX             S              3S 0
045400140605     D CNE             S              3S 0
045500140605    *
045600140605     D #DATE           S              8S 0
045700140605     D #8D0            S              8S 0
045800140605     D #8D1            S              8S 0
045900140605     D #ISO            S               D
046000140605    *
046100140605      /FREE
046200140605
046300140605       #MBR_OPENFILES('DCOV22') ;
046400140605       EXSR $PRIME ;
046500140605
046600140605       EXSR $PROCESS ;
046700140605       RETURN #DATE ;
046800140605    *
046900140605      /END-FREE
047000140605   S* *---------------------------------------------------------------------
047100140605     C     $PRIME        BEGSR
047200140605   S* *---------------------------------------------------------------------
047300140605     C     KL#TSAPS      KLIST
047400140605     C                   KFLD                    KF@TRS
047500140605     C                   KFLD                    KF@SUB
047600140605     C                   KFLD                    KF@PLN
047700140605     C                   KFLD                    KF@SSN
047800140605     C                   KFLD                    KF@SEQ
047900140605    *
048000140605     C                   CLEAR                   ENRLDT@
048100140605     C                   EVAL      DCV_RESULT = *BLANKS
048200140605     C                   CLEAR                   CANDT@
048300140605     C                   EVAL      NDX = 0
048400140605     C                   EVAL      CNE = 0
048500140605     C                   EVAL      #DATE = DCV_RQS
048600140605    *
048700140605     C                   EVAL      KF@TRS = DCV_TRS
048800140605     C                   EVAL      KF@SUB = DCV_SUB
048900140605     C                   EVAL      KF@PLN = DCV_PLN
049000140605     C                   EVAL      KF@SSN = DCV_SSN
049100140605     C                   EVAL      KF@SEQ = DCV_SEQ
049200140605    *
049300140605     C                   ENDSR
049400140605   S* *---------------------------------------------------------------------
049500140605     C     $PROCESS      BEGSR
049600140605   S* *---------------------------------------------------------------------
049700140605     C     KL#TSAPS      SETLL     DCOVR
049800140605     C                   DOU       %EOF(DCOV22)
049900140605     C     KL#TSAPS      READE     DCOVR
050000140605     C                   IF        NOT %EOF(DCOV22) AND
050100140605     C                             DENRDT <> CCANDT
050200140605    *
050300140605     C                   IF        CNE = 0
050400140605     C                   EXSR      $LOAD
050500140605     C                   ITER
050600140605     C                   ENDIF
050700140605    *
050800140605     C                   EVAL      #8D0 = CANDT@(CNE)
050900140605    *
051000140605    *** IF WE HAVE NO TERM DATE, THAT IS THE END OF THE RANGES.
051100140605     C                   IF        #8D0 = 0
051200140605     C                   LEAVE
051300140605     C                   ENDIF
051400140605    *
051500140605     C                   MOVE      #8D0          #ISO
051600140605     C                   ADDDUR    1:*D          #ISO
051700140605     C                   MOVE      #ISO          #8D1
051800140605    *
051900140605    *** CHECK FOR A BREAK IN COVERAGE
052000140605     C                   IF        DENRDT = #8D0 OR DENRDT = #8D1
052100140605     C                   EVAL      CANDT@(CNE) = CCANDT
052200140605     C                   ITER
052300140605     C                   ENDIF
052400140605    *
052500140605     C                   EXSR      $LOAD
052600140605    *
052700140605     C                   ENDIF
052800140605     C                   ENDDO
052900140605    *
053000140605     C                   EXSR      $RUMMAGE
053100140605    *
053200140605     C                   ENDSR
053300140605   S* *---------------------------------------------------------------------
053400140605     C     $LOAD         BEGSR
053500140605   S* *---------------------------------------------------------------------
053600140605    *
053700140605     C                   ADD       1             CNE
053800140605     C                   EVAL      ENRLDT@(CNE) = DENRDT
053900140605     C                   EVAL      CANDT@(CNE) = CCANDT
054000140605    *
054100140605     C                   ENDSR
054200140605   S* *---------------------------------------------------------------------
054300140605     C     $RUMMAGE      BEGSR
054400140605   S* *---------------------------------------------------------------------
054500140605    *** FIND A MATCH, RUMMAGE THROUGH THE ARRAY
054600140605     C                   IF        CNE = 0
054700140605     C                   EVAL      DCV_RESULT = 'LOAD FAILED'
054800140605     C                   CLOSE(E)  DCOV22
054900140605     C                   RETURN    #DATE
055000140605     C                   ENDIF
055100140605    *
055200140605     C                   EVAL      NDX = 0
055300140605    *
055400140605     C                   MOVE      *ZEROS        #TERM             8 0
055500140605     C                   DO        CNE
055600140605     C                   ADD       1             NDX
055700140605     C                   EVAL      #TERM = CANDT@(NDX)
055800140605     C                   IF        #TERM = 0
055900140605     C                   EVAL      #TERM = 99999999
056000140605     C                   ENDIF
056100140605     C                   IF        DCV_RQS >= ENRLDT@(NDX) AND
056200140605     C                             DCV_RQS <  #TERM
056300140605     C                   EXSR      $PONDER
056400140605     C                   LEAVESR
056500140605     C                   ENDIF
056600140605     C                   ENDDO
056700140605    *
056800140605     C                   EVAL      DCV_RESULT = 'COULD NOT FIND REQUEST'
056900140605     C                   CLOSE(E)  DCOV22
057000140605     C                   RETURN    #DATE
057100140605    *
057200140605     C                   ENDSR
057300140605   S*
057400140605   S* *---------------------------------------------------------------------
057500140605     C     $PONDER       BEGSR
057600140605   S* *---------------------------------------------------------------------
057700140605    *
057800140605    *** COMPARE ENROLLMENT ARRAY AGAINST REQUESTED AGAINST RENEWAL
057900140605     C                   IF        ENRLDT@(NDX) >= DCV_RFR
058000140605     C                   EVAL      #DATE = ENRLDT@(NDX)
058100140605     C                   ELSE
058200140605     C                   EVAL      #DATE = DCV_RFR
058300140605     C                   ENDIF
058400140605    *
058500140605     C                   ENDSR
058600140605   S* *---------------------------------------------------------------------
058700140605     P #VERIFY_DCV_DATE...
058800140605     P                 E
058900140605
