0001009508080002 F******************************************************************
0002009909300003 F* RPA040     GROUP BENEFIT SERVICES SOFTWARE           1995      *  UTL001
0003009102150004 F*                                                                *  UTL001
0004009508090005 F*            WRITTEN BY - DAVID KETTERMAN                        *  UTL001
0005009508090006 F*            DATE - 08/08/95                                     *  UTL001
0006009508090007 F*                                                                *  UTL001
0007009508080013 F*  DESCRIPTION - THIS PROGRAM WILL LIST THE INVOICE              *  UTL001
0008009508090014 F*            SUMMARY FILE. PROGRAM REQUESTED BY FINANCE.         *  UTL001
0009009803240015 F*--------------------------------------------------------------- *  UTL001
001000980324     F*  MODIFICATION : TOTAL ACCOUNT NUMBERS. (HASH)     M.L.F.  3/98
001100981123     F*  CHANGES LDA DATE INPUT TO 8 BYTES -Y2K COMPLIANT D.L.W. 11/98
0011010511090020 F*  11/09/05  DLK  add column heading override by acct            *
0012009102150016 F******************************************************************  UTL001
0013009102150017 F*                                                                   UTL001
0014009508080018 FINVSUM    IP   E             DISK                                         UTL001
0015009508090019 FSUBMST    IF   E           K DISK
0016009508090019 FACCMST    IF   E           K DISK
001601051109     fac2mst    IF   E           K Disk
0017009508090019 FCODES     IF   E           K DISK
0018009508140018 FINVSUML1  IF   E           K DISK                                         UTL001
001900950814     F                                     RENAME(INVSMR:INVL1)
0020009508110021 FREPORT    O    F  198        PRINTER OFLIND(*INOF)                        DB020
002100950811     F                                     FORMLEN(88)
002200950811     F                                     FORMOFL(80)
002201051109     D fprefix         s              1a   inz('F')
002202051109     D COLUMN1T        s                   like(ih1t)
002203051109     D COLUMN2T        s                   like(ih2t)
002204051109     D COLUMN3T        s                   like(ih3t)
002205051109     D COLUMN4T        s                   like(ih4t)
002206051109     D COLUMN5T        s                   like(ih5t)
002207051109     D COLUMN6T        s                   like(ih6t)
002208051109     D COLUMN7T        s                   like(ih7t)
002209051109     D COLUMN8T        s                   like(ih8t)
002210051109     D COLUMN9T        s                   like(ih9t)
002211051109     D COLUMN1B        s                   like(ih1b)
002212051109     D COLUMN2B        s                   like(ih2b)
002213051109     D COLUMN3B        s                   like(ih3b)
002214051109     D COLUMN4B        s                   like(ih4b)
002215051109     D COLUMN5B        s                   like(ih5b)
002216051109     D COLUMN6B        s                   like(ih6b)
002217051109     D COLUMN7B        s                   like(ih7b)
002218051109     D COLUMN8B        s                   like(ih8b)
002219051109     D COLUMN9B        s                   like(ih9b)
002220051109
002221051109gsp  D ac2head         DS
002222051109gsp  D  A2IH1T
002223051109gsp  D  A2IH1B
002224051109gsp  D  A2IH2T
002225051109gsp  D  A2IH2B
002226051109gsp  D  A2IH3T
002227051109gsp  D  A2IH3B
002228051109gsp  D  A2IH4T
002229051109gsp  D  A2IH4B
002230051109gsp  D  A2IH5T
002231051109gsp  D  A2IH5B
002232051109gsp  D  A2IH6T
002233051109gsp  D  A2IH6B
002234051109gsp  D  A2IH7T
002235051109gsp  D  A2IH7B
002236051109gsp  D  A2IH8T
002237051109gsp  D  A2IH8B
002238051109gsp  D  A2IH9T
002239051109gsp  D  A2IH9B
002240051109
0023009102150054 D* LDA                                                               DB020
0024009102150055 D                UDS                                                       DB020
0025009901080056 D  LY                     1      4  0                                      DB020Y
0026009901080056 D  LMD                    5      8  0                                      DB020Y
0027009508080056 D  LTRUST               100    102                                         DB020Y
0028009505080056 D  CONAME               201    240                                         DB020Y
0029009505090055 D  TIME                 242    247  0
003000950809     IINVSMR
003100950808     I                                          INTRST        L3
003200950808     I                                          INSUBD        L2
003300950809     I                                          INACCT        L1
009200950809     C* GET NEW HEADINGS FROM SUBMST
009301051109     c                   if        *inl2
0094000511090061 C     SUBKEY        CHAIN     SUBMST                             51                       UTL00
009401051109     c                   end
009402051109
009403051109     C* GET acct HEADING override
009404051109     c                   if        *inl1
0094050511090236 C                   EXSR      #headings
009406051109     C   OF              EXCEPT    newpage
009407051109     C                   EXCEPT    HEAD
009408051109     c                   end
009409051109
009410051109     c                   if        *inof
009600051109     C                   EXCEPT    newpage
009601051109     C                   EXCEPT    HEAD
009602051109     c                   end
009700950808     C*
009800950814     C* ACCUMULATE $$$ PER COLUMN
009900950814     C*
010000950808     C                   ADD       INCOL1        L1COL1
010100950808     C                   ADD       INCOL2        L1COL2
010200950808     C                   ADD       INCOL3        L1COL3
010300950808     C                   ADD       INCOL4        L1COL4
010400950808     C                   ADD       INCOL5        L1COL5
010500950808     C                   ADD       INCOL6        L1COL6
010600950808     C                   ADD       INCOL7        L1COL7
010700950808     C                   ADD       INCOL8        L1COL8
010800950808     C                   ADD       INCOL9        L1COL9
010900950808     C                   ADD       INTOT         L1TOT
0110009508080103 C*                                                                   UTL001
0111009508090103 C* SETUP KEYS FOR CHAIN TO CODES FILE                                UTL001
0112009508090103 C*                                                                   UTL001
011300950809     C                   MOVEL     INRC          INRC1             1
011400950809     C                   MOVE      INRC          INRC2             2
011500950809     C                   MOVEL     INTRCD        INTRC1            1
011600950809     C                   MOVE      INTRCD        INTRC2            2
011700950809     C*
011800950814     C* GET CODE DESCRIPTIONS
011900950814     C*
0120009508090061 C     CKEY1         CHAIN     CODES                              53                       UTL00
012100950809     C   53              MOVE      *BLANKS       SDESC1           10
012200950809     C  N53              MOVE      SDESCR        SDESC1           10
0123009508090061 C     CKEY2         CHAIN     CODES                              54                       UTL00
012400950809     C   54              MOVE      *BLANKS       SDESC2           10
012500950809     C  N54              MOVE      SDESCR        SDESC2           10
012600950809     C*
012700950809     C* PRINT DETAIL LINE
012800950809     C*
012900950808     C                   EXCEPT    PRT
012901051109     c                   if        *inof
012902051109     C                   EXCEPT    newpage
012903051109     C                   EXCEPT    head
012904051109     C                   end
013100950808     C*
013200950809     C* END OF ACCOUNT/INVOICE
013300950809     C*
013400950808     CL1                 ADD       L1COL1        L3COL1
013500950808     CL1                 ADD       L1COL2        L3COL2
013600950808     CL1                 ADD       L1COL3        L3COL3
013700950808     CL1                 ADD       L1COL4        L3COL4
013800950808     CL1                 ADD       L1COL5        L3COL5
013900950808     CL1                 ADD       L1COL6        L3COL6
014000950808     CL1                 ADD       L1COL7        L3COL7
014100950808     CL1                 ADD       L1COL8        L3COL8
014200950808     CL1                 ADD       L1COL9        L3COL9
014300950808     CL1                 ADD       L1TOT         L3TOT
0144009508090061 CL1   ACCKEY        CHAIN     ACCMST                             52                       UTL00
014500950808     CL1                 EXCEPT    L1PRT
014501051109     cl1                 if        *inof
014502051109     Cl1                 EXCEPT    newpage
014503051109     Cl1                 EXCEPT    head
014504051109     Cl1                 end
014700950811     C*
014800950811     C* GET ENROLLMENT SUMMARY
014900950811     C*
015000950811     CL1                 EXCEPT    ENRHED
015001051109     cl1                 if        *inof
015002051109     Cl1                 EXCEPT    newpage
015003051109     Cl1                 EXCEPT    head
015004051109     Cl1                 end
015200950811     CL1                 MOVE      INTRST        T                 3 0
015300950811     CL1                 MOVE      INSUBD        S                 3 0
015400950811     CL1                 MOVE      INACCT        A                 4 0
015500980324     C*
015600980324     CL1                 CLEAR                   TS#
015700980324     CL1                 CLEAR                   TSA#
015800980324     CL1                 MOVEL     INTRST        TS#               6 0
015900980324     CL1                 MOVE      INSUBD        TS#
016000980324     CL1                 MOVEL     TS#           TSA#             10 0
016100980324     CL1                 MOVE      INACCT        TSA#
016200980324     CL1                 ADD       TSA#          TSATOT           14 0
016300980324     C*
016400981123     CL1                 MOVE      INVCDT        CVDT              8 0
016500950811     CL1                 MOVE      'KES'         CD                3
016600950811     C*
016700950811     CL1                 SETOFF                                           60
016800950814     CL1   INVKEY        SETLL     INVL1
016900950811     CL1   #T0010        TAG
017000950814     CL1   INVKEY        READE     INVL1                                  60
017100950811     CL1 60              GOTO      #T0020
017200950811     CL1                 Z-ADD     INCOL1        ENCOL1            7 0
017300950811     CL1                 Z-ADD     INCOL2        ENCOL2            7 0
017400950811     CL1                 Z-ADD     INCOL3        ENCOL3            7 0
017500950811     CL1                 Z-ADD     INCOL4        ENCOL4            7 0
017600950811     CL1                 Z-ADD     INCOL5        ENCOL5            7 0
017700950811     CL1                 Z-ADD     INCOL6        ENCOL6            7 0
017800950811     CL1                 Z-ADD     INCOL7        ENCOL7            7 0
017900950811     CL1                 Z-ADD     INCOL8        ENCOL8            7 0
018000950811     CL1                 Z-ADD     INCOL9        ENCOL9            7 0
018100950814     C*
018200950814     C* ACCUMULATE TOTAL COVERAGES
018300950814     C*
018400950814     CL1                 ADD       INCOL1        ENC1L1            7 0
018500950814     CL1                 ADD       INCOL2        ENC2L1            7 0
018600950814     CL1                 ADD       INCOL3        ENC3L1            7 0
018700950814     CL1                 ADD       INCOL4        ENC4L1            7 0
018800950814     CL1                 ADD       INCOL5        ENC5L1            7 0
018900950814     CL1                 ADD       INCOL6        ENC6L1            7 0
019000950814     CL1                 ADD       INCOL7        ENC7L1            7 0
019100950814     CL1                 ADD       INCOL8        ENC8L1            7 0
019200950814     CL1                 ADD       INCOL9        ENC9L1            7 0
019300950811     C*
019400950811     CL1                 MOVEL     INCOVT        INRC1             1
019500950811     CL1                 MOVE      INCOVT        INRC2             2
0196009508110061 CL1   CKEY1         CHAIN     CODES                              56                       UTL00
019700950811     CL1                 EXCEPT    ENRPRT
019701051109     cl1                 if        *inof
019702051109     Cl1                 EXCEPT    newpage
019703051109     Cl1                 EXCEPT    head
019704051109     Cl1                 end
019900950811     CL1                 GOTO      #T0010
020000950811     CL1   #T0020        TAG
020100950814     CL1                 ADD       ENC1L1        ENC1L3            7 0
020200950814     CL1                 ADD       ENC2L1        ENC2L3            7 0
020300950814     CL1                 ADD       ENC3L1        ENC3L3            7 0
020400950814     CL1                 ADD       ENC4L1        ENC4L3            7 0
020500950814     CL1                 ADD       ENC5L1        ENC5L3            7 0
020600950814     CL1                 ADD       ENC6L1        ENC6L3            7 0
020700950814     CL1                 ADD       ENC7L1        ENC7L3            7 0
020800950814     CL1                 ADD       ENC8L1        ENC8L3            7 0
020900950814     CL1                 ADD       ENC9L1        ENC9L3            7 0
021000950814     CL1                 EXCEPT    ENL1PT
021003051109     cl1                 if        *inof
021004051109     Cl1                 EXCEPT    newpage
021005051109     Cl1                 EXCEPT    head
021006051109     Cl1                 end
021200950809     C*
021300950809     C*
021400950809     C* END OF TRUST
021500950809     C*
021600950809     CL3                 ADD       L3COL1        LRCOL1
021700950809     CL3                 ADD       L3COL2        LRCOL2
021800950809     CL3                 ADD       L3COL3        LRCOL3
021900950809     CL3                 ADD       L3COL4        LRCOL4
022000950809     CL3                 ADD       L3COL5        LRCOL5
022100950809     CL3                 ADD       L3COL6        LRCOL6
022200950809     CL3                 ADD       L3COL7        LRCOL7
022300950809     CL3                 ADD       L3COL8        LRCOL8
022400950809     CL3                 ADD       L3COL9        LRCOL9
022500950809     CL3                 ADD       L3TOT         LRTOT
022600950814     C*
022700950814     C* ACCUMULATE COVERAGE TYPES
022800950814     C*
022900950814     CL3                 ADD       ENC1L3        ENC1LR            7 0
023000950814     CL3                 ADD       ENC2L3        ENC2LR            7 0
023100950814     CL3                 ADD       ENC3L3        ENC3LR            7 0
023200950814     CL3                 ADD       ENC4L3        ENC4LR            7 0
023300950814     CL3                 ADD       ENC5L3        ENC5LR            7 0
023400950814     CL3                 ADD       ENC6L3        ENC6LR            7 0
023500950814     CL3                 ADD       ENC7L3        ENC7LR            7 0
023600950814     CL3                 ADD       ENC8L3        ENC8LR            7 0
023700950814     CL3                 ADD       ENC9L3        ENC9LR            7 0
023800950814     C*
023900950809     CL3                 EXCEPT    L3PRT
023901051109     cl3                 if        *inof
024000051109     Cl3                 EXCEPT    newpage
024001051109     Cl3                 EXCEPT    head
024002051109     Cl3                 end
024100950808     C*
024200950809     C*
024300950809     C* END OF REPORT
024400950809     C*
024500950809     CLR                 EXCEPT    LRPRT
024501051109
024502051109      ****************************************
024503051109      * set headings for this account
024504051109      ****************************************
024505051109   9 C     #headings     begsr
024506051109
024507051109      * if override was entered, use it
024508051109
0245090511090234 C     ac2key        CHAIN     ac2mst
024510051109     c                   if        %found(ac2mst) and ac2head <> *blanks
024511051109     c                   movel     A2IH1T        column1t
024512051109     c                   movel     A2IH1B        column1b
024513051109     c                   movel     A2IH2T        column2t
024514051109     c                   movel     A2IH2B        column2b
024515051109     c                   movel     A2IH3T        column3t
024516051109     c                   movel     A2IH3B        column3b
024517051109     c                   movel     A2IH4T        column4t
024518051109     c                   movel     A2IH4B        column4b
024519051109     c                   movel     A2IH5T        column5t
024520051109     c                   movel     A2IH5B        column5b
024521051109     c                   movel     A2IH6T        column6t
024522051109     c                   movel     A2IH6B        column6b
024523051109     c                   movel     A2IH7T        column7t
024524051109     c                   movel     A2IH7B        column7b
024525051109     c                   movel     A2IH8T        column8t
024526051109     c                   movel     A2IH8B        column8b
024527051109     c                   movel     A2IH9T        column9t
024528051109     c                   movel     A2IH9B        column9b
024529051109
024530051109     c                   else
024531051109
024532051109     c                   movel     IH1T          column1t
024533051109     c                   movel     IH1B          column1b
024534051109     c                   movel     IH2T          column2t
024535051109     c                   movel     IH2B          column2b
024536051109     c                   movel     IH3T          column3t
024537051109     c                   movel     IH3B          column3b
024538051109     c                   movel     IH4T          column4t
024539051109     c                   movel     IH4B          column4b
024540051109     c                   movel     IH5T          column5t
024541051109     c                   movel     IH5B          column5b
024542051109     c                   movel     IH6T          column6t
024543051109     c                   movel     IH6B          column6b
024544051109     c                   movel     IH7T          column7t
024545051109     c                   movel     IH7B          column7b
024546051109     c                   movel     IH8T          column8t
024547051109     c                   movel     IH8B          column8b
024548051109     c                   movel     IH9T          column9t
024549051109     c                   movel     IH9B          column9b
024550051109     c                   end
024551051109
024552051109   9 C                   ENDSR
024553051109
024600950809     C*
024601051109     c     *inzsr        begsr
024602051109
024603051109     C*
024604051109     C     SUBKEY        KLIST
024605051109     C                   KFLD                    INTRST
024606051109     C                   KFLD                    INSUBD
024607051109     C*
024608051109     C     ACCKEY        KLIST
024609051109     C                   KFLD                    INTRST
024610051109     C                   KFLD                    INSUBD
024611051109     C                   KFLD                    INACCT
024612051109     C*
024613051109     C     ac2key        KLIST
024614051109     C                   KFLD                    fprefix
024615051109     C                   KFLD                    INTRST
024616051109     C                   KFLD                    INSUBD
024617051109     C                   KFLD                    INACCT
024621051109     C*
024622051109     C     CKEY1         KLIST
024623051109     C                   KFLD                    INRC1
024624051109     C                   KFLD                    INRC2
024625051109     C*
024626051109     C     CKEY2         KLIST
024627051109     C                   KFLD                    INTRC1
024628051109     C                   KFLD                    INTRC2
024629051109     C*
024630051109     C     INVKEY        KLIST
024631051109     C                   KFLD                    T
024632051109     C                   KFLD                    S
024633051109     C                   KFLD                    A
024634051109     C                   KFLD                    CVDT
024635051109     C                   KFLD                    CD
024636051109     C*
024637051109     C     *LIKE         DEFINE    INCOL1        L1COL1
024638051109     C     *LIKE         DEFINE    INCOL2        L1COL2
024639051109     C     *LIKE         DEFINE    INCOL3        L1COL3
024640051109     C     *LIKE         DEFINE    INCOL4        L1COL4
024641051109     C     *LIKE         DEFINE    INCOL5        L1COL5
024642051109     C     *LIKE         DEFINE    INCOL6        L1COL6
024643051109     C     *LIKE         DEFINE    INCOL7        L1COL7
024644051109     C     *LIKE         DEFINE    INCOL8        L1COL8
024645051109     C     *LIKE         DEFINE    INCOL9        L1COL9
024646051109     C     *LIKE         DEFINE    INTOT         L1TOT
024647051109     C*
024648051109     C     *LIKE         DEFINE    INCOL1        L3COL1          + 1
024649051109     C     *LIKE         DEFINE    INCOL2        L3COL2          + 1
024650051109     C     *LIKE         DEFINE    INCOL3        L3COL3          + 1
024651051109     C     *LIKE         DEFINE    INCOL4        L3COL4          + 1
024652051109     C     *LIKE         DEFINE    INCOL5        L3COL5          + 1
024653051109     C     *LIKE         DEFINE    INCOL6        L3COL6          + 1
024654051109     C     *LIKE         DEFINE    INCOL7        L3COL7          + 1
024655051109     C     *LIKE         DEFINE    INCOL8        L3COL8          + 1
024656051109     C     *LIKE         DEFINE    INCOL9        L3COL9          + 1
024657051109     C     *LIKE         DEFINE    INTOT         L3TOT           + 1
024658051109     C*
024659051109     C     *LIKE         DEFINE    INCOL1        LRCOL1          + 1
024660051109     C     *LIKE         DEFINE    INCOL2        LRCOL2          + 1
024661051109     C     *LIKE         DEFINE    INCOL3        LRCOL3          + 1
024662051109     C     *LIKE         DEFINE    INCOL4        LRCOL4          + 1
024663051109     C     *LIKE         DEFINE    INCOL5        LRCOL5          + 1
024664051109     C     *LIKE         DEFINE    INCOL6        LRCOL6          + 1
024665051109     C     *LIKE         DEFINE    INCOL7        LRCOL7          + 1
024666051109     C     *LIKE         DEFINE    INCOL8        LRCOL8          + 1
024667051109     C     *LIKE         DEFINE    INCOL9        LRCOL9          + 1
024668051109     C     *LIKE         DEFINE    INTOT         LRTOT           + 1
024669051109
024670051109     c                   except    newpage
024671051109     c                   endsr
0247009102150104 O******************************************************              DB020
0248009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0249009102150106 O******************************************************              DB020
0250009102150107 O*                                                                   DB020
0251000511090108 OREPORT    E            newpage        2 03                                DB020
0252009508090110 O                       CONAME             120                             DB020
0253000511090111 O          E            newpage        1                                   DB020
0254009811230113 O                       *DATE               14 '  /  /    '                DB020
0255009508090114 O                                          104 'INVOICE SUMMARY FILE LIS'
0256009508090114 O                                          109 'T FOR'
0257009901080114 O                       LMD                115 '  /  '
0258009901080114 O                                          116 '/'
0259009901080114 O                       LY                 120
0260009508090115 O                                          189 'PAGE :'                    DB020
0261009508080116 O                       PAGE          Z    198                             DB020
0262000511090111 O          E            newpage        1                                   DB020
0263009508080119 O                                           17 'PROG: RPA040'              DB020
0264009508090120 O                                          189 'TIME :'                    DB020
0265009508080121 O                       TIME               198 '  :  :  '                  DB020
0266009508080111 O          E            HEAD           1                                   DB020
0267009102150124 O                                           24 '------------------------'  DB020
0268009102150125 O                                           48 '------------------------'  DB020
0269009102150126 O                                           72 '------------------------'  DB020
0270009102150127 O                                           96 '------------------------'  DB020
0271009102150128 O                                          120 '------------------------'  DB020
0272009508080128 O                                          144 '------------------------'  DB020
0273009508080128 O                                          168 '------------------------'  DB020
0274009508080128 O                                          192 '------------------------'  DB020
0275009508080128 O                                          198 '------'                    DB020
0276009508080111 O          E            HEAD           1                                   DB020
0277009508080132 O                                           13 'TRUST-SUB-ACC'             DB020
0278009508090134 O                                           22 'INVOICE'                   DB020
0279009508090133 O                                           30 'RECORD'                    DB020
0280009508090135 O                                           41 'TRANS'                     DB020
028100051109     O                       COLUMN1T            62
028200051109     O                       COLUMN2T            77
028300051109     O                       COLUMN3T            92
028400051109     O                       COLUMN4T           107
028500051109     O                       COLUMN5T           122
028600051109     O                       COLUMN6T           137
028700051109     O                       COLUMN7T           152
028800051109     O                       COLUMN8T           167
028900051109     O                       COLUMN9T           182
029000950809     O                                          197 'TOTAL'
0291009508080111 O          E            HEAD           1                                   DB020
0292009508090134 O                                           22 'NUMBER'                    DB020
0293009508090133 O                                           30 'TYPE'                      DB020
0294009508090135 O                                           41 'TYPE'                      DB020
029500051109     O                       COLUMN1B            62
029600051109     O                       COLUMN2B            77
029700051109     O                       COLUMN3B            92
029800051109     O                       COLUMN4B           107
029900051109     O                       COLUMN5B           122
030000051109     O                       COLUMN6B           137
030100051109     O                       COLUMN7B           152
030200051109     O                       COLUMN8B           167
030300051109     O                       COLUMN9B           182
030400950814  11 O          E            HEAD           1                                   DB020
030500950808   4 O                                           24 '------------------------'  DB020
0306009508080125 O                                           48 '------------------------'  DB020
0307009508080126 O                                           72 '------------------------'  DB020
0308009508080127 O                                           96 '------------------------'  DB020
0309009508080128 O                                          120 '------------------------'  DB020
0310009508080128 O                                          144 '------------------------'  DB020
0311009508080128 O                                          168 '------------------------'  DB020
0312009508080128 O                                          192 '------------------------'  DB020
0313009508080128 O                                          198 '------'                    DB020
0314009508110147 O          E            PRT         1                                      DB020
0315009508090149 O               L1      INTRST               3                             DB020
0316009508090149 O               L1                           4 '-'                         DB020
0317009508090149 O               L1      INSUBD               7                             DB020
0318009508090149 O               L1                           8 '-'                         DB020
0319009508090149 O               L1      INACCT              12                             DB020
0320009508090151 O                       ININV#        Z     22                             DB020
0321009508090150 O                       SDESC1              34                             DB020
0322009508090152 O                       SDESC2              46                             DB020
0323009508090153 O                       INCOL1        MB    63                             DB020
0324009508090153 O                       INCOL2        MB    78                             DB020
0325009508090153 O                       INCOL3        MB    93                             DB020
0326009508090153 O                       INCOL4        MB   108                             DB020
0327009508090153 O                       INCOL5        MB   123                             DB020
0328009508090153 O                       INCOL6        MB   138                             DB020
0329009508090153 O                       INCOL7        MB   153                             DB020
0330009508090153 O                       INCOL8        MB   168                             DB020
0331009508090153 O                       INCOL9        MB   183                             DB020
0332009508090153 O                       INTOT         MB   198                             DB020
0333009508110147 O          E            L1PRT       2  2                                   DB020
033400950809     O              N52      ACNAM1              42
033500950814     O                                           48 'TOTAL $'
0336009508090153 O                       L1COL1        MB    63                             DB020
0337009508090153 O                       L1COL2        MB    78                             DB020
0338009508090153 O                       L1COL3        MB    93                             DB020
0339009508090153 O                       L1COL4        MB   108                             DB020
0340009508090153 O                       L1COL5        MB   123                             DB020
0341009508090153 O                       L1COL6        MB   138                             DB020
0342009508090153 O                       L1COL7        MB   153                             DB020
0343009508090153 O                       L1COL8        MB   168                             DB020
0344009508090153 O                       L1COL9        MB   183                             DB020
0345009508090153 O                       L1TOT         MB   198                             DB020
0346009508110147 O          E            ENRHED         1                                   DB020
034700950811     O                                           62 '--- TOTAL COVERAGES --- '
0348009508110147 O          E            ENRPRT         1                                   DB020
034900950811     O              N56      SDESCR              48
0350009508140153 O                       ENCOL1        ZB    62                             DB020
0351009508140153 O                       ENCOL2        ZB    77                             DB020
0352009508140153 O                       ENCOL3        ZB    92                             DB020
0353009508140153 O                       ENCOL4        ZB   107                             DB020
0354009508140153 O                       ENCOL5        ZB   122                             DB020
0355009508140153 O                       ENCOL6        ZB   137                             DB020
0356009508140153 O                       ENCOL7        ZB   152                             DB020
0357009508140153 O                       ENCOL8        ZB   167                             DB020
0358009508140153 O                       ENCOL9        ZB   182                             DB020
035900950814  11 O          E            ENL1PT         1                                   DB020
0360009508140125 O                                           48 '              ----------'  DB020
0361009508140126 O                                           72 '------------------------'  DB020
0362009508140127 O                                           96 '------------------------'  DB020
0363009508140128 O                                          120 '------------------------'  DB020
0364009508140128 O                                          144 '------------------------'  DB020
0365009508140128 O                                          168 '------------------------'  DB020
0366009508140128 O                                          192 '---------------         '  DB020
0367000511090147 O          E            ENL1PT         2                                   DB020
036800950814     O                                           48 'COVERAGE TOTAL'
0369009508140153 O                       ENC1L1        ZB    62                             DB020
0370009508140153 O                       ENC2L1        ZB    77                             DB020
0371009508140153 O                       ENC3L1        ZB    92                             DB020
0372009508140153 O                       ENC4L1        ZB   107                             DB020
0373009508140153 O                       ENC5L1        ZB   122                             DB020
0374009508140153 O                       ENC6L1        ZB   137                             DB020
0375009508140153 O                       ENC7L1        ZB   152                             DB020
0376009508140153 O                       ENC8L1        ZB   167                             DB020
0377009508140153 O                       ENC9L1        ZB   182                             DB020
0378000511090147 O          E            L3PRT          2                                   DB020
037900950814     O                                           48 'TRUST $ TOTAL'
0380009508090153 O                       L3COL1        MB    63                             DB020
0381009508090153 O                       L3COL2        MB    78                             DB020
0382009508090153 O                       L3COL3        MB    93                             DB020
0383009508090153 O                       L3COL4        MB   108                             DB020
0384009508090153 O                       L3COL5        MB   123                             DB020
0385009508090153 O                       L3COL6        MB   138                             DB020
0386009508090153 O                       L3COL7        MB   153                             DB020
0387009508090153 O                       L3COL8        MB   168                             DB020
0388009508090153 O                       L3COL9        MB   183                             DB020
0389009508090153 O                       L3TOT         MB   198                             DB020
0390000511090147 O          E            L3PRT          2                                   DB020
039100980324     O                                           22 'ACCOUNT TOTAL|'
039200950814     O                                           48 'TRUST COVERAGE TOTAL'
0393009508140153 O                       ENC1L3        ZB    62                             DB020
0394009508140153 O                       ENC2L3        ZB    77                             DB020
0395009508140153 O                       ENC3L3        ZB    92                             DB020
0396009508140153 O                       ENC4L3        ZB   107                             DB020
0397009508140153 O                       ENC5L3        ZB   122                             DB020
0398009508140153 O                       ENC6L3        ZB   137                             DB020
0399009508140153 O                       ENC7L3        ZB   152                             DB020
0400009508140153 O                       ENC8L3        ZB   167                             DB020
0401009508140153 O                       ENC9L3        ZB   182                             DB020
0402000511090147 O          E            LRPRT          2                                   DB020
040300980324     O                                           22 '------- -----|'
040400950814     O                                           48 'FINAL $ TOTAL'
0405009508090153 O                       LRCOL1        MB    63                             DB020
0406009508090153 O                       LRCOL2        MB    78                             DB020
0407009508090153 O                       LRCOL3        MB    93                             DB020
0408009508090153 O                       LRCOL4        MB   108                             DB020
0409009508090153 O                       LRCOL5        MB   123                             DB020
0410009508090153 O                       LRCOL6        MB   138                             DB020
0411009508090153 O                       LRCOL7        MB   153                             DB020
0412009508090153 O                       LRCOL8        MB   168                             DB020
0413009508090153 O                       LRCOL9        MB   183                             DB020
0414009508090153 O                       LRTOT         MB   198                             DB020
0415000511090147 O          E            LRPRT          1                                   DB020
041600980324     O                       TSATOT        1     22
041700950814     O                                           48 'FINAL COVERAGE TOTAL'
0418009508140153 O                       ENC1LR        ZB    62                             DB020
0419009508140153 O                       ENC2LR        ZB    77                             DB020
0420009508140153 O                       ENC3LR        ZB    92                             DB020
0421009508140153 O                       ENC4LR        ZB   107                             DB020
0422009508140153 O                       ENC5LR        ZB   122                             DB020
0423009508140153 O                       ENC6LR        ZB   137                             DB020
0424009508140153 O                       ENC7LR        ZB   152                             DB020
0425009508140153 O                       ENC8LR        ZB   167                             DB020
0426009508140153 O                       ENC9LR        ZB   182                             DB020
