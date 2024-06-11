000100140228     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200140228     H ALWNULL(*USRCTL)
0003009102150002 F******************************************************************  UTL001
0004009909300003 F* DB055      GROUP BENEFIT SERVICES SOFTWARE           1992      *  UTL001
0005009102150004 F*                                                                *  UTL001
0006009210280005 F*            WRITTEN BY - DAVID KETTERMAN                        *  UTL001
0007009210280006 F*            DATE - 10/28/92                                     *  UTL001
0008009102150007 F*                                                                *  UTL001
0009009210280013 F*  DESCRIPTION - THIS PROGRAM WILL SERVE AS A PRE-INVOICE        *  UTL001
0010009210280014 F*            AUDIT THAT CHECKS FOR A VALID RATE FOR THE          *  UTL001
0011009210280015 F*            EFFECTIVE DATE THAT IS PASSED FROM THE INVOICE      *  UTL001
0012009210280015 F*            PROGRAM TR010.                                      *  UTL001
0013009210280015 F*                                                                *  UTL001
001400970716     F*  MODIFICATION-ADD AA CODE AND AA NAME TO REPORT. 7/97 MLF
001500011210     f*  12/10/01 dlk - exclude plans billed to cobra members          *
001600020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
001700071011      * 10/10/07 dlk - convert to use external pgm for grate           *
001800140228    ***
001900140228    *** 02/28/2014 SSK RE-MOD TO OTF AND KEEP ACA PRT
002000140228    ***
002100140228    ***
002200140228    ***
002300140228    ***
002400011210     f*                                                                *
0025009102150016 F******************************************************************  UTL001
0026000112100018 FMCOV14    IP   e           k DISK
0027000112100034 FACCMST    IF   e           k DISK
0028000112100034 FAACODE    IF   e           k DISK
0029000112100019 Fmember    IF   e           k DISK
0030001402280034 FDEPNDC    IF   e           k DISK
0031001402280034 FDCOVC     IF   e           k DISK
0032000112100019 Fplnmst    IF   e           k DISK
0033009210280021 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
003400140228   X***X
003500140228    ***
0036009210280048 D                 DS
0037000710110055 D tspabct                 1     15
0038000710110055 D mctrst                  1      3  0
0039000710110055 D mcsub#                  4      6  0
0040000710110055 D mcplan                  7     10
0041000710110055 D mcageb                 11     12  0
0042000710110055 D mcovtp                 13     15
004300140228    ***
0044000710110048 D                 DS
0045000112100049 D  enrldt                 1      8  0
0046000112100049 D  enrlym                 1      6  0
004700140228    ***
0048001402280048 D                 DS
0049001402280049 D  DENRDT                 1      8  0
0050001402280049 D  DENRYM                 1      6  0
005100140228    ***
0052000112100048 D                 DS
005300140228     D @LCYMD                  1      8A
0054000112100049 D  LYMD                   1      8  0
0055000112100049 D  LYM                    1      6  0
0056000112100050 D  LYY                    1      4  0
0057009811120051 D  LMM                    5      6  0
0058009811120051 D  LDD                    7      8  0
0059009102150054 D* LDA                                                               DB020
006000140228    ***
0061009102150055 D                UDS
0062009210280063 D  LMONTH                 1      2  0
0063009811120064 D  LYEAR                  3      6  0
0064001402280067 D  TAR                  100    171  0 DIM(24)
0065009102150056 D  CONAME               201    240
006600140228    ***
006700140228     D @ACA            S              1A   INZ
006800140228   X***X
006900140228      /DEFINE CHK_ACA_PLAN_PR
007000140228      /DEFINE CHK_ACA_PLAN_FIELDS
007100140228      /COPY QCPYSRC,ACASRVPGMP
007200140228      /UNDEFINE CHK_ACA_PLAN_PR
007300140228      /UNDEFINE CHK_ACA_PLAN_FIELDS
007400140228   X***X
007500011210     iaccmsr
007600011210     i              aacode                      acod
007700140228   X***X
007800011210     C*
007900011210     C* ONLY CHECK COVERAGES THAT ARE ACTIVE FOR EFFDT OF INVOICE
008000011210     C*
008100011210     c                   if        mcdltd = 'D' or enrldt = candt or
008200011210     c                             enrlym > lym or (candt <> 0 and
008300011210     c                             candt <= lymd)
008400921028     C                   GOTO      #END
008500921028     C                   END
0086009210280116 C*
0087009210280117 C* CHECK ARRAY THAT HOLDS THE SELECTED TRUSTS FOR A MATCH TO MCOV
0088009210280118 C*
0089009210280119 C                   DO        24            X                 2 0
0090000112100120 C     TAR(X)        IFEQ      mctrst
0091009210280121 C                   GOTO      #T0010
0092009210280122 C                   END
0093009210280123 C                   END
0094009210280130 C*
0095009210280129 C                   GOTO      #END
0096009210280130 C*
0097009210280131 C     #T0010        TAG
009800011210
009900011210     c* skip plans only billed to COBRA members
010000011210
010100011210     c     mcssno        chain     member                             55
010200011210     c   55              goto      #end
010300011211     c                   if        cexpdt <> 0
010400011210     c     plnkey        chain     plnmst                             56
010500011210     c   56              goto      #end
010600011211     c                   if        sfadm <> 'Y' or cexpdt <= lymd
010700011210     c                   goto      #end
010800011210     c                   end
010900011210     c                   end
011000140228    ***
011100140228     C                   SETOFF                                         54
011200140228    ***
011300140228    *** CHECK IF ACA PLAN
011400140228    ***
011500140228     C                   EVAL      @ACA = #CHK_ACA_PLAN(MCTRST:MCSUB#:MCPLAN)
011600140228    ***
011700140228    ***
011800140228     C* VALID RATE NEEDED FOR RUN DATE
011900140228
012000140228     C                   EXSR      #FNDRT
012100140228     C                   IF        @ACA = 'Y'
012200140228     C                   EXSR      #DEPRT
012300140228     C                   ENDIF
012400140228    ***
012500921028     C     #END          TAG
012600921028     C*
012700921103     C* PRINT TOTAL RATE ERRORS, U7 IS USED TO CANCEL TR010
012800921102     C*
012900921028     CLR   CNT           IFNE      0
013000921103     CLR                 SETON                                        U7
013100921028     CLR                 EXCEPT    LASTR
013200921028     CLR                 END
013300921221      *
013400921221     CLR   CNT           IFEQ      0
013500921221     CLR                 EXCEPT    HEAD
013600921221     CLR                 EXCEPT    NOERR
013700921221     CLR                 END
013800140228    ***
013900140228    ***
014000140228   S***S
0141001402280073 C***********************************************
0142001402280073 C* FIND RATE                                   *
0143001402280073 C***********************************************
014400140228     C     #FNDRT        BEGSR
014500140228    ***
014600140228     C                   IF        @ACA = 'Y'
014700140228     C                   EVAL      *IN55 = *OFF
014800140228     C                   EVAL      *IN54 = *ON
014900140228     C                   EVAL      PARMSSN = %EDITC(MBSSNO:'X')
015000140228     C                   EVAL      PARMSEQ = '00'
015100140228     C                   ELSE
015200140228     C                   EVAL      *IN54 = *OFF
015300140228     C                   EVAL      PARMSSN = *BLANKS
015400140228     C                   EVAL      PARMSEQ = *BLANKS
015500140228     C                   ENDIF
015600140228    ***
015700140228     c                   move      tspabct       parmkey
015800140228     c                   move      lymd          parmeffymd
015900140228     c                   move      benamt        parmbenamt
016000140228     c                   clear                   parmgroup
016100140228     c                   clear                   parmbilrte
016200140228     c                   clear                   parmnetrte
016300140228     c                   clear                   parmbilprem
016400140228     c                   clear                   parmnetprem
016500140228     c                   clear                   parmfound
016600140228    ***
016700140228     c                   call      'GETRATE'     grplist
016800140228    ***
016900140228     C                   EXSR      $RESULT
017000140228    ***
017100140228     C                   ENDSR
017200140228   S***S
017300140228     C     $RESULT       BEGSR
017400140228    ***
017500140228      * grate not returned
0176001402280361 C                   if        parmfound <> 'Y'
0177001402280522 C     FIRSTE        IFNE      'Y'
0178001402280523 C                   EXCEPT    HEAD
0179001402280524 C                   MOVE      'Y'           FIRSTE            1
0180001402280525 C                   END
018100140228     C*
018200140228     C                   SETOFF                                       8797
0183001402280144 C     ACCKEY        CHAIN     ACCMST                             87
018400140228     C  N87ACOD          CHAIN     AACODE                             97
018500140228     C  N97              MOVE      *BLANKS       LNAME            10
018600140228     C  N97              MOVEL     ALNAM         LNAME
0187001402280130 C*
018800140228     C                   MOVE      ENRLDT        CYMD#             8
018900140228     C                   EXSR      #CYMD8
019000140228     C                   MOVE      MDCY#         ENRDAT            8 0
019100140228     C                   MOVE      CANDT         CYMD#
019200140228     C                   EXSR      #CYMD8
019300140228     C                   MOVE      MDCY#         CANDAT            8 0
019400140228     C                   EXCEPT    ERROR
0195001402280523 C   OF              EXCEPT    HEAD
0196001402280102 C                   ADD       1             CNT               6 0
0197001402280097 C                   END
019800140228    ***
019900140228     C                   ENDSR
020000140228   S***S
020100140228     C***********************************************
020200140228     C* FIND RATE FOR DEPENDENTS                    *
020300140228     C***********************************************
020400140228     C     #DEPRT        BEGSR
020500140228    ***
020600140228     C     MCSSNO        CHAIN     DEPENR
020700140228     C                   IF        NOT %FOUND(DEPNDC)
020800140228     C                   LEAVESR
020900140228     C                   ENDIF
021000140228    ***
021100140228     C     MCSSNO        SETLL     DEPENR
021200140228     C                   DOU       %EOF(DEPNDC)
021300140228     C     MCSSNO        READE     DEPENR
021400140228     C                   IF        NOT %EOF(DEPNDC)
021500140228    ***
021600140228     C     KL#SQTSP      CHAIN     DCOVR
021700140228     C                   IF        NOT %FOUND(DCOVC)
021800140228     C                   ITER
021900140228     C                   ENDIF
022000140228    ***
022100140228     C     KL#SQTSP      SETLL     DCOVR
022200140228     C                   DOU       %EOF(DCOVC)
022300140228     C     KL#SQTSP      READE     DCOVR
022400140228     C                   IF        NOT %EOF(DCOVC) AND DVDLTD <> 'D' AND
022500140228     C                             DENRDT <> CCANDT AND
022600140228     C                             DENRYM <= LYM AND
022700140228     C                             (CCANDT = 0 OR CCANDT > LYMD)
022800140228    ***
022900140228     C                   EVAL      *IN55 = *ON
023000140228     C                   EVAL      *IN54 = *ON
023100140228     C                   EVAL      PARMSSN = %EDITC(DSSNO:'X')
023200140228     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
023300140228    ***
023400140228     C                   MOVE      TSPABCT       PARMKEY
023500140228     C                   MOVE      LYMD          PARMEFFYMD
023600140228     C                   MOVE      BENAMT        PARMBENAMT
023700140228     C                   CLEAR                   PARMGROUP
023800140228     C                   CLEAR                   PARMBILRTE
023900140228     C                   CLEAR                   PARMNETRTE
024000140228     C                   CLEAR                   PARMBILPREM
024100140228     C                   CLEAR                   PARMNETPREM
024200140228     C                   CLEAR                   PARMFOUND
024300140228    ***
024400140228     C                   CALL      'GETRATE'     GRPLIST
024500140228    ***
024600140228     C                   EXSR      $RESULT
024700140228    ***
024800140228     C                   ENDIF
024900140228     C                   ENDDO
025000140228    ***
025100140228     C                   ENDIF
025200140228     C                   ENDDO
025300140228    ***
025400140228     C                   ENDSR
025500140228   S***S
0256000112100059 C     *inzsr        begsr
025700140228    ***
025800140228     c     grplist       plist
025900140228     c                   parm                    parmkey          15
026000140228     C                   PARM                    PARMSSN           9
026100140228     C                   PARM                    PARMSEQ           2
026200140228     c                   parm                    parmeffymd        8
026300140228     c                   parm                    parmbenamt        7
026400140228     c                   parm                    parmgroup        15
026500140228     c                   parm                    parmbilrte       11
026600140228     c                   parm                    parmnetrte       11
026700140228     c                   parm                    parmbilprem       7
026800140228     c                   parm                    parmnetprem       7
026900140228     c                   parm                    parmfound         1
027000140228    ***
027100140228     C     KL#SQTSP      KLIST
027200140228     C                   KFLD                    DSSNO
027300140228     C                   KFLD                    DSEQ#
027400140228     C                   KFLD                    MCTRST
027500140228     C                   KFLD                    MCSUB#
027600140228     C                   KFLD                    MCPLAN
027700140228    ***
027800011210     C                   TIME                    HTIME             6 0
0279000112100060 C                   Z-ADD     1             LDD
0280000112100065 C                   Z-ADD     LYEAR         LYY
0281000112100066 C                   Z-ADD     LMONTH        LMM
028200011210     c     plnkey        klist
028300011210     c                   kfld                    mctrst
028400011210     c                   kfld                    mcsub#
028500011210     c                   kfld                    mcplan
028600011210     c     acckey        klist
028700011210     c                   kfld                    mctrst
028800011210     c                   kfld                    mcsub#
028900011210     c                   kfld                    acc#
029000011210     C                   endsr
0291000112100058 C*
029200981112     C*------------------------------------------------------
029300981112     C* Rearrange date / ccyymmdd to mmddccyy
029400981112     C*****************************************************
029500981112     C     #CYMD8        BEGSR
029600981112     C                   MOVE      CYMD#         MMDD#             4
029700981112     C                   MOVEL     CYMD#         CCYY#             4
029800981112     C                   MOVEL     MMDD#         MDCY#             8
029900981112     C                   MOVE      CCYY#         MDCY#
030000981112     C                   ENDSR
0301009102150104 O******************************************************              DB020
0302009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0303009102150106 O******************************************************              DB020
0304009102150107 O*                                                                   DB020
0305009210280108 OREPORT    E            HEAD           2 03
0306009102150110 O                       CONAME              87
0307009210280111 O          E            HEAD           1
0308009811120113 O                       *DATE         Y     14
0309009210280114 O                                           73 'PRE INVOICE RATE AUDIT F'
031000921028     O                                           75 'OR'
031100921102     O                       LMONTH              78
031200921028     O                                           79 '/'
031300981112     O                       LYEAR               83
0314009102150115 O                                          120 'PAGE :'
0315009707160116 O                       PAGE          Z    130
031600921028     O          E            HEAD           1
0317009210280119 O                                           17 'PROG: DB055'
031800921028     O                                           49 'TRUSTS SELECTED :'
031900921110     O                       TAR(1)        Z     53
032000921110     O                       TAR(2)        Z     58
032100921110     O                       TAR(3)        Z     63
032200921110     O                       TAR(4)        Z     68
032300921110     O                       TAR(5)        Z     73
032400921110     O                       TAR(6)        Z     78
032500921110     O                       TAR(7)        Z     83
032600921110     O                       TAR(8)        Z     88
032700921110     O                       TAR(9)        Z     93
032800921110     O                       TAR(10)       Z     98
032900921110     O                       TAR(11)       Z    103
033000921110     O                       TAR(12)       Z    108
0331009210280120 O                                          120 'TIME :'
0332009211020121 O                       HTIME              130 '  :  :  '
033300921028     O          E            HEAD           1
033400921110     O                       TAR(13)       Z     53
033500921110     O                       TAR(14)       Z     58
033600921110     O                       TAR(15)       Z     63
033700921110     O                       TAR(16)       Z     68
033800921110     O                       TAR(17)       Z     73
033900921110     O                       TAR(18)       Z     78
034000921110     O                       TAR(19)       Z     83
034100921110     O                       TAR(20)       Z     88
034200921110     O                       TAR(21)       Z     93
034300921110     O                       TAR(22)       Z     98
034400921110     O                       TAR(23)       Z    103
034500921110     O                       TAR(24)       Z    108
034600921028     O          E            HEAD           1
0347009102150124 O                                           24 '------------------------'
0348009102150125 O                                           48 '------------------------'
0349009102150126 O                                           72 '------------------------'
0350009102150127 O                                           96 '------------------------'
0351009102150128 O                                          120 '------------------------'
0352009102150129 O                                          132 '------------'
035300921028     O          E            HEAD           1
0354009707160132 O                                            8 'SS#'
0355009707160132 O                                           23 'T/S/A'
0356009210280133 O                                           35 'PLAN'
0357009210280134 O                                           42 'AGE'
0358009210280135 O                                           48 'COV'
0359009210280137 O                                           57 'ENROLL'
036000921028     O                                           68 'CANCEL'
036100921028     O          E            HEAD           1
0362009210280132 O                                           43 'BAND'
0363009210280132 O                                           49 'TYPE'
036400970716     O*
036500970716     O                                          119 'CODE'
036600970716     O                                          129 'AA NAME'
036700921028     O          E            HEAD           2
0368009102150141 O                                           24 '------------------------'
0369009102150142 O                                           48 '------------------------'
0370009102150143 O                                           72 '------------------------'
0371009102150144 O                                           96 '------------------------'
0372009102150145 O                                          120 '------------------------'
0373009102150146 O                                          132 '------------'
0374009107010147 O          E            ERROR          1
0375000112100149 O                       mcssno              11 '   -  -    '
0376000112100150 O                       mctrst              18
037700921028     O                                           19 '-'
0378000112100150 O                       mcsub#              22
037900921028     O                                           23 '-'
0380009210280150 O                       ACC#                27
0381000112100151 O                       mcplan              35
0382000112100151 O                       mcageb              41
0383000112100152 O                       mcovtp              47
038400981112     O                       ENRDAT        Y     58
038500981112     O                       CANDAT        Y     70
038600970716     O                       ACOD               118
038700970716     O                       LNAME              132
0388009210280156 O          E            LASTR       3
0389009102150157 O                                           29 '*** TOTAL ERRORS:'
0390009212230158 O                       CNT           1     38
0391009212210156 O          E            NOERR       3
0392009212210157 O                                           60 '***** NO RATE ERRORS'
0393009212210158 O                                           72 ' FOUND *****'
