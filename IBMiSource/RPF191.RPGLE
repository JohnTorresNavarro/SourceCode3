000100010614     H DFTNAME(RPF191)
0009000106110011  ******************************************************************
000901010614      * RPF191     GROUP BENEFIT SERVICES SOFTWARE           2001      *
000902010611      *                                                                *
000903010611      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000904010611      *            DATE - 06/11/01                                     *
000905010611      *                                                                *
000906010611      *  DESCRIPTION - THIS PRINT ACCT LABELS                          *
000907010611      *                                                                *
001400010611      *            -------------------------                           *
001500010611      *            | CONTACT PERSON  ACCT# |                           *
001600010611      *            | ACCOUNT NAME          |                           *
001700010611      *            | ADDRESS 1             |                           *
001800010611      *            | ADDRESS 2             |                           *
001900010611      *            | CITY, ST. ZIP         |                           *
002000010611      *            -------------------------                           *
002400010611      *                                                                *
0025010106110011  ******************************************************************
002502010611     FPLNMST    IF   E           K DISK
002601010611     FACCMST    IF   E           K DISK
002602010614     FMCOV14    IF   E           K DISK
0029000106140011 FRPF191P   O    E             PRINTER OFLIND(*IN80)
002901010611
0032009102150013 D AL              S              1    DIM(30)                              ADDRESS LINE ARRARPF
0032010106110069 D N#              S              2  0
0032030106120093 D ZIP5            S              5
0032060106120096 D ZIP4            S              4
003207010611
0032080106120033 D                 DS
0032090106140034 DACCT                     1     13
0032100106140034 D  BLANK1                 1      1    INZ(' ')
0032110106140034 D  MCTRST                 2      4  0
0032120106140034 D  DASH1                  5      5    INZ('-')
003213010614     D  MCSUB#                 6      8  0
0032140106140034 D  DASH2                  9      9    INZ('-')
003215010614     D  ACC#                  10     13  0
003216010612
0033000106110033 D                UDS
0034000106110034 D**USERID                10     17
003401010612     D  USRID                243    252
003402010611     D  LCARR                 42     44
0054000106110035
006702010611     C     PLNKEY        KLIST
006703010614     C                   KFLD                    MCTRST
006704010614     C                   KFLD                    MCSUB#
006705010614     C                   KFLD                    MCPLAN
0067060106110035
006707010611     C     ACCKEY        KLIST
006708010614     C                   KFLD                    ACTRST
006709010614     C                   KFLD                    ACSUB#
006710010614     C                   KFLD                    ACACCT
0067110106110035
006712010614     C                   READ      ACCMSR                                 99
006713010611     C                   DOW       *IN99 = *OFF
006714010614     C                   IF        ACDLTD = 'A'
006716010614     C     ACCKEY        SETLL     MCOVR
006717010614     C     ACCKEY        READE     MCOVR                                  98
006718010611     C                   DOW       *IN98 = *OFF
006719010611     C                   IF        CANDT = *ZEROS
006724010614     C     PLNKEY        CHAIN     PLNMST                             50
006725010612     C                   IF        *IN50 = *OFF
006726010618     C                   IF        PLDLTD = 'A' AND PCARR = LCARR
0067270106120050
0068000106110049 C                   EXSR      #ADDR
0069000106110050
006901010612     C                   IF        ECNTAC = *BLANKS
006902010612     C                   EVAL      CNTACCT = CONTAC
006903010612     C                   ELSE
006904010612     C                   EVAL      CNTACCT = ECNTAC
006905010612     C                   ENDIF
0069060106120068 C                   MOVE      ACCT          CNTACCT
007101010611     C                   EVAL      NAM1 = ACNAM1
007102010614     C                   IF        AADDR2 <> *BLANKS
007103010614     C                   EVAL      *IN89 = *ON
007104010614     C                   ELSE
007105010614     C                   EVAL      *IN89 = *OFF
007106010614     C                   ENDIF
0072000106110052 C                   WRITE     LABEL
007201010612     C                   LEAVE
007202010611     C                   ENDIF
007203010611     C                   ENDIF
007204010614     C                   ENDIF
007206010614     C     ACCKEY        READE     MCOVR                                  98
007207010611     C                   ENDDO
007208010611     C                   ENDIF
007209010614     C                   READ      ACCMSR                                 99
007210010611     C                   ENDDO
007211010611
007212010611     C                   EVAL      *INLR = *ON
007213010611
007214010612      *--------------------------*
0079000106120059  *    SUBROUTINE SECTION    *
007901010612      *--------------------------*
007902010611     C     *INZSR        BEGSR
0079030106120037  *  SET LEADER LABEL - FIRST TIME ONLY
007904010612
007905010612     C                   EVAL      USERID = USRID
0079060106110041 C                   WRITE     HEADER
007907010611     C                   ENDSR
007908010611
0079090106120064 C     #ADDR         BEGSR
0081000106110061  *    AL = CITY, ST  ZIP
0082000106120062  *---COMPRESS CITY/STATE/ZIP ------------------*
0083000106110063  *
0085000106110065
0086000106110066  * INITIALIZE ARRAY AND COUNTER
0087000106110067
0088000106110068 C                   MOVE      *BLANKS       AL
0089000106110069 C                   EVAL      N# = 30
0090000106110070 C                   MOVEA     ACITY         AL(1)
0091000106110071
0092000106110072  *  FIND LAST CHARACTER
0093000106110073
0094009102150074 C                   DOU       AL(N#) > ' '
0095000106110075 C                   EVAL      N# = N# - 1
0096000106110076 C                   IF        N# = 00
0097000106110077 C                   SETON                                        51
0098000106110078 C   51              GOTO      ENDADR
0099000106110079 C                   END
0100000106110080 C                   END
0101000106110081
0102000106110082  * MOVE COMMA AND STATE
0103000106110083
0104000106110084 C                   EVAL      N# = N# + 1
0105000106110085 C                   MOVEA     ','           AL(N#)
0105010106110084 C                   EVAL      N# = N# + 2
0107000106110087 C                   MOVEA     ASTATE        AL(N#)
0107010106110084 C                   EVAL      N# = N# + 2
0109000106110089 C                   MOVE      '.'           AL(N#)
0110000106110090
0111000106110091  * MOVE ZIPCODE
0112000106110092
0113000106110093 C                   MOVEL     AZIP          ZIP5
0114000106110094 C                   MOVEA     ZIP5          AL(21)
0115000106110095
0116000106110096 C                   MOVE      AZIP          ZIP4
0117000106140097 C                   IF        ZIP4 <> *BLANKS AND ZIP4 <> '0000'
0118000106110098 C                   MOVEA     '-'           AL(26)
0119000106110099 C                   MOVEA     ZIP4          AL(27)
0120000106110100 C                   ENDIF
0121000106110101
0121010106120094 C                   MOVEA     AL            CTYSTZP
0121020106120101
0122000106110102 C     ENDADR        ENDSR
