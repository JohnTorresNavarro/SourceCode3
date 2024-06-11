000100000000      *_________________________________________________________________________
000200000000      *
000300091109      *  Description:  Account Transfered?
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - June 18, 2009
000800000000      *_________________________________________________________________________
000900091112     FHIST      IF   E           K DISK
001000091112     FMTRANSL2  IF   E           K DISK
001100091112     FPLNMST    IF   E           K DISK
001200091112     FCARMST    IF   E           K DISK
001300091123     FDW311HST  IF A E           K DISK
001400091112
001500091123     D S_SSN           S              9S 0
001600090812     D P_SSN           S              9A
001700091112     D W_SSN           S             10A
001800091112     D U_SSN           S              9S 0
001900090812     D P_EFF           S              8A
002000090812     D W_EFF           S              8S 0
002100090729     D P_FLG           S              1A
002200091111     D W_FLG           S              1A
002300091111
002400091112     D U_CATM          S              1A
002500091112     D U_CATR          S              1A
002600091112     D U_CATD          S              1A
002700091112     D U_CATV          S              1A
002800091112
002900091209     D W_FAC           S             10A
003000091209     D W_TAC           S             10A
003100091112
003200090618     C     *ENTRY        PLIST
003300090618     C                   PARM                    P_SSN
003400090812     C                   PARM                    P_EFF
003500091112     C                   PARM                    P_FLG
003600091112     C                   PARM                    U_CATM
003700091112     C                   PARM                    U_CATR
003800091112     C                   PARM                    U_CATD
003900091112     C                   PARM                    U_CATV
004000090729
004100091123     C                   MOVE      P_SSN         S_SSN
004200091112     C                   MOVE      P_SSN         U_SSN
004300090812     C                   MOVE      P_SSN         W_SSN
004400090812     C                   MOVE      P_EFF         W_EFF
004500090729     C                   Eval      P_FLG = *BLANKS
004600091112     C                   Eval      W_FLG = *BLANKS
004700091112     C                   Eval      U_CATM = *BLANKS
004800091112     C                   Eval      U_CATR = *BLANKS
004900091112     C                   Eval      U_CATD = *BLANKS
005000091112     C                   Eval      U_CATV = *BLANKS
005100090618
005200090812     C     W_SSN         SETGT     HIST
005300090812     C     W_SSN         READPE    HIST
005400090812     C                   DOW       not %eof(HIST)
005500091021     C                   IF        HDSEQ# = 0
005600091109     C                   EXSR      CHKUTM
005700091021     C                   End
005800090729     C                   IF        W_FLG <> *BLANKS
005900090618     C                   Leave
006000090618     C                   End
006100090812     C     W_SSN         READPE    HIST
006200090618     C                   Enddo
006300090618
006400091112     C                   IF        W_FLG <> *BLANKS
006500091112     C                   EXSR      CHKMTR
006600091112     C                   END
006700091123
006800091123     C                   IF        W_FLG <> *BLANKS
006900091123     C     S_KEY         KLIST
007000091123     C                   KFLD                    S_SSN
007100091123     C                   KFLD                    S_COD             3
007200091123     C                   EVAL      S_COD = 'UTM'
007300091123     C     S_KEY         CHAIN     DW311HST
007400091123     C                   If        %FOUND(DW311HST)
007500091123     C                   EVAL      W_FLG = *BLANKS
007600091123     C                   EVAL      P_FLG = *BLANKS
007700091123     C                   ELSE
007800091123     C                   EVAL      DHSSN = S_SSN
007900091123     C                   EVAL      DHCOD = 'UTM'
008000091123     C     *DATE         MULT      10000.0001    DHDATE
008100091123     C                   WRITE     DW311HR
008200091123     C                   END
008300091123     C                   END
008400091112
008500090729     C                   MOVE      W_FLG         P_FLG
008600090618     C                   Eval      *INLR = *ON
008700090618     C                   Return
008800090618
008900091109     C     CHKUTM        BEGSR
009000091111
009100091109     C                   IF        TRCODE = 'UTM' AND
009200090812     C                             COVTDT = W_EFF
009300091111
009400091111     C                   EVAL      W_FAC = %SUBST(CK#NOT:20:10)
009500091111     C                   EVAL      W_TAC = %SUBST(NOTE2:4:10)
009600091111
009700091111     C                   IF        W_FAC = W_TAC
009800091111     C                   EVAL      W_FLG = 'S'
009900091111     C                   ELSE
010000091111     C                   EVAL      W_FLG = 'Y'
010100091111     C                   END
010200090618     C                   END
010300090618
010400090618     C                   ENDSR
010500091112
010600091112     C     CHKMTR        BEGSR
010700091112
010800091112     C     PLANKEY       KLIST
010900091112     C                   KFLD                    MTTRST
011000091112     C                   KFLD                    MTSUB#
011100091112     C                   KFLD                    MTPLAN
011200091112
011300091112     C     U_SSN         SETLL     MTRANSL2
011400091112     C     U_SSN         READE     MTRANSL2
011500091112     C                   DOW       not %eof(MTRANSL2)
011600091112     C     PLANKEY       CHAIN     PLNMST
011700091112     C                   IF        %found(PLNMST)
011800091112     C     PCARR         CHAIN     CARMST
011900091112     C                   IF        %found(CARMST)
012000091112     C                   IF        CARBC = 'D'
012100091112     C                   SELECT
012200121023     C                   WHEN      PLNCAT = 'PMM'  or
012300121023     C                             PLNCAT = 'PCM'
012400091112     C                   EVAL      U_CATM = 'Y'
012500091112     C                   WHEN      PLNCAT = 'PRX'
012600091112     C                   EVAL      U_CATR = 'Y'
012700110922     C                   WHEN      PLNCAT = 'PDR' or
012800140917     C                             PLNCAT = 'PCD' or
012900130118     C                             PLNCAT = 'PDN' or
013000130118     C                             PLNCAT = 'PDE'
013100091112     C                   EVAL      U_CATD = 'Y'
013200110922     C                   WHEN      PLNCAT = 'PVR' or
013300130725     C                             PLNCAT = 'PVS' or
013400130725     C                             PLNCAT = 'PCV'
013500091112     C                   EVAL      U_CATV = 'Y'
013600091112     C                   ENDSL
013700091112     C                   END
013800091112     C                   END
013900091112     C                   END
014000091112     C     U_SSN         READE     MTRANSL2
014100091112     C                   ENDDO
014200091112     C                   ENDSR
