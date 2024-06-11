000100131011     H NOMAIN OPTION(*NODEBUGIO) DEBUG COPYRIGHT('GBS - GROUPBENEFITSERVICES')
000200131011   X***X
000300131011   X***X *------------------------------------------------------------------
000400131014   X***X * MODULE NAME..: ACCSRVPGM
000500131011   X***X * WRITTEN BY...: STEPHEN KING
000600131014   X***X * DATE WRITTEN.: 10/14/2013
000700131014   X***X * DESCRIPTION..: MODULE WITHIN SERVICE PROGRAM ACCSRVPGM....FUNCTIONS
000800131014   X***X *                RELATED TO ACCOUNT MASTER & ACCOUNT MASTER 2
000900131011   X***X * CALLED FROM..: ANY PROGRAM
001000131011   X***X *
001100131011   X***X *------------------------------------------------------------------
001200131011   X***X * MODIFICATION HISTORY:
001300131011   X***X *
001400131011   X***X *    DATE    DESCRIPTION                                       BY
001500131011   X***X *  --------  -----------------------------------------        ----
001600131011   X***X *
001700131011   X***X *------------------------------------------------------------------
001800131011   X***X
001900131011     FACMUNIQUE IF   E           K DISK    USROPN
002000131011     FAC2MSTL2  IF   E           K DISK    USROPN
002100140210
002200000000      *---------------------------------------------------------------------
002300131014      * FUNCTION TO RETRIEVE ACCOUNT ADDRESS PIECES
002400000000      *---------------------------------------------------------------------
002500131014     P #RTV_ACCADDR    B                   EXPORT
002600131014
002700131014      /DEFINE RTV_ACCADDR_PI
002800131014      /DEFINE RTV_ACCADDR_FIELDS
002900140210      /DEFINE RTV_ACCADDR_RETURN
003000131014      /COPY QCPYSRC,ACCSRVPGMP
003100140210      /unDEFINE RTV_ACCADDR_RETURN
003200131014      /UNDEFINE RTV_ACCADDR_PI
003300131014      /UNDEFINE RTV_ACCADDR_FIELDS
003400131014    ***
003500131011     D KF@TRS          S              3S 0 INZ(0)
003600131011     D KF@SUB          S              3S 0 INZ(0)
003700131011     D KF@ACC          S              4S 0 INZ(0)
003800131011    ***
003900131011     D CMD             S            200A   INZ(*BLANKS)
004000131011     D LENGTH          S             15P 5 INZ(0)
004100131011     D #LEN            S              3P 0 INZ(0)
004200131011    ***
004300131015     D @ZIP            S              5A   INZ
004400131014     D #ZIP            S              5S 0 INZ(0)
004500131014     D #AREA           S              3S 0 INZ(0)
004600131014     D #PHONE          S              7S 0 INZ(0)
004700131014     D @COUNTY         S              2A   INZ
004800131011    ***
004900131011    ***
005000131011   X***X
005100131011    ***
005200131011     C                   EXSR      $PRIME
005300131014    ***
005400131014     C                   EVAL      CMD = 'OVRDBF FILE(ACMUNIQUE) ' +
005500131014     C                               'TOFILE(ACMUNIQUE)'
005600131014     C                   EXSR      $OVRRDE
005700131014    ***
005800131014     C                   Eval      CMD = 'OVRDBF FILE(AC2MSTL2) ' +
005900131014     C                               'TOFILE(AC2MSTL2)'
006000131014     C                   EXSR      $OVRRDE
006100131014    ***
006200140214     C                   OPEN(e)   ACMUNIQUE
006300140214     C                   OPEN(e)   AC2MSTL2
006400131014    ***
006500131014     C     KL#TSA        CHAIN     ACCMSR
006600131014     C     KL#TSA        CHAIN     ACCMSR2
006700131014    ***
006800131014     C                   IF        NOT %FOUND(ACMUNIQUE) OR
006900131014     C                             NOT %FOUND(AC2MSTL2)
007000131014     C                   EVAL      RAA_RESULT = 'ERROR'
007100131014     C                   CLOSE     *ALL
007200131015     C                   RETURN    DS@RETURN
007300131014     C                   ENDIF
007400131014    ***
007500131014     C                   CLOSE     *ALL
007600131014    ***
007700131014     C                   EVAL      RAA_NAME1 = %TRIM(ACNAM1)
007800131014     C                   EVAL      RAA_NAME2 = %TRIM(ACNAM2)
007900131014     C                   Z-ADD     AAREA         RAA_AREA
008000131014     C                   Z-ADD     APHONE        RAA_PHONE
008100131014    ***
008200131014     C                   IF        A2STATE = *BLANKS
008300131014     C                   EVAL      RAA_ADR1 = %TRIM(AADDR1)
008400131014     C                   EVAL      RAA_ADR2 = %TRIM(AADDR2)
008500131014     C                   EVAL      RAA_CITY = %TRIM(ACITY)
008600131014     C                   EVAL      RAA_STATE = ASTATE
008700131014     C                   EVAL      @ZIP = %SUBST((%EDITC(AZIP:'X')):1:5)
008800131014     C                   MOVE      @ZIP          RAA_ZIP
008900131014     C                   EVAL      RAA_COUNTY = ACONTY
009000131014     C                   ELSE
009100131014     C                   EVAL      RAA_ADR1 = %TRIM(A2ADDRESS1)
009200131014     C                   EVAL      RAA_ADR2 = %TRIM(A2ADDRESS2)
009300131014     C                   EVAL      RAA_CITY = %TRIM(A2CITY)
009400131014     C                   EVAL      RAA_STATE = A2STATE
009500131014     C                   Z-ADD     A2ZIP5        RAA_ZIP
009600131014     C                   EVAL      RAA_COUNTY = A2COUNTYCD
009700131014     C                   ENDIF
009800131014    ***
009900131015     C                   RETURN    DS@RETURN
010000131014    ***
010100131011   S***S
010200131011     C     $PRIME        BEGSR
010300131011    ***
010400131011     C     KL#TSA        KLIST
010500131011     C                   KFLD                    KF@TRS
010600131011     C                   KFLD                    KF@SUB
010700131011     C                   KFLD                    KF@ACC
010800131015    ***
010900131015     C                   CLEAR                   DS@RETURN
011000131011    ***
011100131014     C                   EVAL      KF@TRS = RAA_TRS
011200131014     C                   EVAL      KF@SUB = RAA_SUB
011300131014     C                   EVAL      KF@ACC = RAA_ACC
011400131011    ***
011500131011     C                   ENDSR
011600131011   S***S
011700131011     C     $OVRRDE       BEGSR
011800131011    ***
011900131011     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
012000131011     C                   Z-ADD     #LEN          LENGTH
012100131011    ***
012200131011     C                   CALL      'QCMDEXC'
012300131011     C                   PARM                    CMD
012400131011     C                   PARM                    LENGTH
012500131011    ***
012600131011     C                   ENDSR
012700131011   S***S
012800131014     P #RTV_ACCADDR    E
012900140210
013000140210      *---------------------------------------------------------------------
013100140210      * Function to retrieve GBS admin date for this account
013200140210      *---------------------------------------------------------------------
013300140210     P #rtv_gbs_admindate...
013400140210     P                 b                   export
013500140210
013600140210      /define rtv_gbs_admindate_pi
013700140210      /define rtv_gbs_admindate_fields
013800140210      /copy qcpysrc,accsrvpgmp
013900140210      /undefine rtv_gbs_admindate_pi
014000140210      /undefine rtv_gbs_admindate_fields
014100140210
014200140210      /free
014300140210
014400140210       if not %open(acmunique) ;
014500140210        open acmunique ;
014600140210       endif ;
014700140210
014800140210       chain (p_trust:p_sub:p_acct) acmunique ;
014900140210       if not %found(acmunique) ;
015000140210        return *zeros ;
015100140210       else ;
015200140210        return gbsbdt ;
015300140210       endif ;
015400140210
015500140210
015600140210      /end-free
015700140210
015800140210     P #rtv_gbs_admindate...
015900140210     P                 e
016000140210
016100140210      *---------------------------------------------------------------------
016200140210      *
016300140210      *---------------------------------------------------------------------
016400140210     P #acc_closesrv   b                   export
016500140210
016600140210      /define acc_closesrv_pi
016700140210      /copy qcpysrc,accsrvpgmp
016800140210      /undefine acc_closesrv_pi
016900140210
017000140210      /free
017100140210
017200140210       close *all ;
017300140210
017400140210      /end-free
017500140210
017600140210     P #acc_closesrv   e
