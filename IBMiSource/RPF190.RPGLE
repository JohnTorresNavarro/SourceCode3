001101010327      ******************************************************************
001102010614      * RPF190              GROUP BENEFIT SERVICES              2001   *
001103010327      *                                                                *
001104010327      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
001105010611      *            DATE - 06/11/2001                                   *
001106010327      *                                                                *
001107010611      *  DESCRIPTION - THIS PROGRAM PRINTS ACCOUNT LABELS              *
001108010611      *                FOR A PARTICULAR CARRIER                        *
001109010327      *                                                                *
001110010327      *                                                                *
001115010327      *                                                                *
001116010327      ******************************************************************
001200010614     FRPF190D   CF   E             WORKSTN
001300010327     FCARMST    IF   E           K DISK
001402010327
001500010327     D MSG             S             70    DIM(3) CTDATA PERRCD(1)
001501010327     D N               S              2  0
001507010327
004500010327      **** LDA DATA AREA COMPANY NAME AND USER ID
004600990212     D                UDS
004700010412     D  COMP                 201    240
004800010412     D  USRID                243    252
004801010327     D  LCARR                 42     44
004803010328     D  LTRNMT                53     53
004807010327
004900010327      *****************************************************************
005000990127     C     #T0001        TAG
005100990127     C                   EXFMT     SCRN01
005200010327      * F7 = CANCEL
005301010327     C                   IF        *IN07 = *ON
005400010327     C                   EVAL      *INLR = *ON
005401010618     C                   SETON                                        U1
005500990127     C                   GOTO      #END
005600990127     C                   ENDIF
006800010327
006803010327     C                   EXSR      #VALCR
007400010327
007401010327     C                   EVAL      LCARR = SELCAR
007403010328     C                   EVAL      LTRNMT = TXMTYN
007404010327     C                   EVAL      *INLR = *ON
007405010327
009800990127     C     #END          TAG
009900010327      *****************************************************************
010000010327      * VALIDATE THE CARRIER CODE ENTERED ON THE SCREEN
010100010327     C     #VALCR        BEGSR
010101010327     C     SELCAR        CHAIN     CARMSR                             50
010102010327     C                   IF        *IN50 = *ON
010104010327     C                   EVAL      N = 1
010105010327     C                   MOVEL     MSG(N)        SMSG
010106010327     C                   EVAL      *IN97 = *ON
010107010329     C                   EVAL      *IN21 = *ON
010108010403     C                   GOTO      #T0001
010109010327     C                   ELSE
010110010329     C                   EVAL      *IN21 = *OFF
011800010327     C                   EVAL      SMSG = *BLANK
011900010327     C                   ENDIF
012400990129     C                   ENDSR
021200010327      *****************************************************************
021300990127     C     *INZSR        BEGSR
021400990127     C                   MOVEL     COMP          COMPNY
021600010327
022001010327     C                   MOVE      *BLANK        SELCAR
022007010329     C                   MOVE      *OFF          *IN21
022009010327     C                   MOVE      *OFF          *IN97
022500990211     C                   ENDSR
022600010327      *****************************************************************
022700990212**  ERROR MESSAGES
022800010327INVALID CARRIER
