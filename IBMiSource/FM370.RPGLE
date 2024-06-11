0001009709220002 F*---------------------------------------------------------------**
0002009909300003 F* FM370      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009709220005 F*            WRITTEN BY - MARY FONTI                             *
0004009709220006 F*            DATE - 09/97                                        *
000500990115     F* DLW 01/15/99 MOVED TO Y2KPGM TO RECOMPILE TO PREVENT DATA CHCK
000600990115     F*              NO ONLY CHANGES WERE REQUIRED FOR Y2K COMPLIANCE.
0007000006130006 F*                                                                *
0008000006130006 F* 06/13/00 dlk - remove delete function and note use of "display *
0009000006130006 F*                access" on screen, important for IQ010.         *
0010000105160006 F* 05/16/01 JVA - allow gbs/io account access.                    *
001100010516     F*    NOTE:  SCFAX position 1 is used as GBS/IO acct access flag. *
0012009709220013 F*_______________________________________________________________**
001300970922     FFM370D    CF   E             WORKSTN
001400970923     F                                     SFILE(S03SFL:RR3)
001500970926     FGBSECURE  UF A E           K DISK
001600970926     FGBSSECL1  IF   E           K DISK
001700970923     F                                     RENAME(SECR:AGRCD)
001800970926     FSMAN      IF   E           K DISK
001900970929     FAGENCY    IF   E           K DISK
002000971001     FTRSMST    IF   E           K DISK
002100971001     FACCMST    IF   E           K DISK
002200970929     FSUBML1    IF   E           K DISK
002300970925     F*----------------------------------------------------------
002400970929     D ER              S             20    DIM(4) CTDATA PERRCD(1)
002500971001     D*----------------------------------------------------------
0026009709290055 D                 DS
0027009709290056 D  AGN                    1     30
002800970925     D                                     DIM(10)
0029009709290056 D  SAA1                   1      3
0030009709290056 D  SAA2                   4      6
0031009709290056 D  SAA3                   7      9
0032009709290056 D  SAA4                  10     12
0033009709290056 D  SAA5                  13     15
0034009709290056 D  SAA6                  16     18
0035009709290056 D  SAA7                  19     21
0036009709290056 D  SAA8                  22     24
0037009709290056 D  SAA9                  25     27
0038009709290056 D  SAA10                 28     30
003900971001     D*
0040009709300055 D                 DS
0041009709300056 D  TRS                    1     30  0
004200970929     D                                     DIM(10)
0043009709300056 D  SCT1                   1      3  0
0044009709300056 D  SCT2                   4      6  0
0045009709300056 D  SCT3                   7      9  0
0046009709300056 D  SCT4                  10     12  0
0047009709300056 D  SCT5                  13     15  0
0048009709300056 D  SCT6                  16     18  0
0049009709300056 D  SCT7                  19     21  0
0050009709300056 D  SCT8                  22     24  0
0051009709300056 D  SCT9                  25     27  0
0052009709300056 D  SCT10                 28     30  0
005300970930     D*
0054009709250055 D                 DS
0055009709300056 D  SUB                    1     30  0
005600970929     D                                     DIM(10)
0057009709300056 D  SCS1                   1      3  0
0058009709300056 D  SCS2                   4      6  0
0059009709300056 D  SCS3                   7      9  0
0060009709300056 D  SCS4                  10     12  0
0061009709300056 D  SCS5                  13     15  0
0062009709300056 D  SCS6                  16     18  0
0063009709300056 D  SCS7                  19     21  0
0064009709300056 D  SCS8                  22     24  0
0065009709300056 D  SCS9                  25     27  0
0066009709300056 D  SCS10                 28     30  0
006700970925     D*
0068009710010055 D                 DS
0069009710010056 D  ACT                    1     40  0
007000971001     D                                     DIM(10)
0071009710010056 D  SCA1                   1      4  0
0072009710010056 D  SCA2                   5      8  0
0073009710010056 D  SCA3                   9     12  0
0074009710010056 D  SCA4                  13     16  0
0075009710010056 D  SCA5                  17     20  0
0076009710010056 D  SCA6                  21     24  0
0077009710010056 D  SCA7                  25     28  0
0078009710010056 D  SCA8                  29     32  0
0079009710010056 D  SCA9                  33     36  0
0080009710010056 D  SCA10                 37     40  0
0081009710010055 D                 DS
0082009710010056 D  TSA                    1     10  0
0083009710010056 D  T                      1      3  0
0084009710010056 D  S                      4      6  0
0085009710010056 D  AC                     7     10  0
008600971001     D                UDS
008700971001     D  $USER                 48     57
008800970925     I*----------------------------------------------------------
008900970923     IAGRCD
009000970923     I              SCUSR                       USER
009100970923     I              SCNAME                      NAME
009200970922     I*----------------------------------------------------------------
009300971001     C* KEY BROKER FILE.
009400971001     C     BKEY          KLIST
009500971001     C                   KFLD                    SCBRK
009600971001     C*
009700971001     C* KEY ACCT FILE.
009800971001     C     TSAKEY        KLIST
009900971001     C                   KFLD                    T
010000971001     C                   KFLD                    S
010100971001     C                   KFLD                    AC
010200970922     C*
010300970922     C** WRITE 1ST SCREEN.
010400970922     C     BEGIN         TAG
010500971002     C                   SETOFF                                       6263
010600970922     C*
010700971001     C* CHECK FOR SECURITY ACCESS.
010800971001     C*
010900971001     C     *IN99         IFEQ      '0'
011000971001     C     $USER         CHAIN     GBSECURE                           22
011100971001     C   22              SETON                                        LR
011200971001     C   LR              GOTO      ENDPGM
011300971001     C     SCSUPD        IFNE      'Y'
011400971001     C                   SETON                                        LR
011500971001     C                   GOTO      ENDPGM
011600971001     C                   END
011700971001     C                   MOVE      '1'           *IN99
011800971001     C                   END
011900971001     C**
012000970922     C                   MOVE      *BLANKS       SCUSR
012100970923     C                   MOVE      *BLANKS       ALPHA
012200970922     C*
012300970922     C                   EXFMT     S01
012400970922     C*
012500970923     C*ALPHA SEARCH.----------------------------------------
012600970923     C     ALPHA         IFNE      *BLANKS
012700970923     C                   EXSR      SEARCH
012800970923     C                   GOTO      BEGIN
012900970923     C                   END
013000970923     C*----------------------------------------------------------
013100970922     C     *INKG         IFEQ      '1'
013200970922     C                   SETON                                        LR
013300970922     C                   RETURN
013400970922     C                   MOVE      '0'           *INKG
013500970922     C                   END
013600970922     C**
013700970922     C** WRITE SECOND AND THIRD SCREEN - SECURITY
013800970922     C*
013900970922     C* UPDATE SECURITY RECORD.
014000970926     C     SCUSR         CHAIN     GBSECURE                           50
014100970922     C     *IN50         IFEQ      '0'
014200970922     C*
014300970925     C     STRUPD        TAG
014400970925     C*
014500010516     C                   MOVEL     SCFAX         WSCFAX
014600970922     C                   EXFMT     S02
014700970922     C*
014800970922     C     *INKG         IFEQ      '1'
014900970922     C                   SETON                                        LR
015000970922     C                   RETURN
015100970922     C                   MOVE      '0'           *INKG
015200970922     C                   END
015300970925     C     *INKA         CABEQ     '1'           BEGIN
015400970930     C**IN13 = DELETE RECORD.
015500000613     C*    *INKM         IFEQ      '1'
015600000613     C*                  DELETE    SECR
015700000613     C*                  GOTO      BEGIN
015800000613     C*                  END
015900970930     C*
016000970930     C*-----------------------------------------------------
016100970923     C*BROKER CODE CHECK.
016200970923     C                   MOVE      '0'           *IN42
016300970926     C     SCBRK         IFEQ      'ALL'
016400970926     C                   GOTO      COMAGN
016500970926     C                   END
016600970926     C     BKEY          CHAIN     SMAN                               41
016700970923     C     *IN41         IFEQ      '1'
016800970923     C                   MOVE      '1'           *IN42
016900970925     C                   GOTO      STRUPD
017000970923     C                   END
017100970925     C*
017200970925     C     COMAGN        TAG
017300970922     C*
017400970922     C                   EXFMT     S03
017500970922     C*
017600970929     C                   MOVE      '0'           *IN86
017700970922     C     *INKA         CABEQ     '1'           BEGIN
017800970929     C*-----------------------------------------------------
017900970925     C*AGENCY CODE CHECK.(UPDATE MODE.)
018000970925     C                   DO        10            X                 2 0
018100970925     C                   MOVE      '0'           *IN75
018200970929     C                   MOVE      '0'           *IN86
018300970925     C     AGN(X)        IFNE      ' '
018400970925     C                   MOVE      *BLANKS       AGCK              3
018500970925     C                   MOVE      AGN(X)        AGCK
018600970925     C     AGCK          CHAIN     AGENCY                             75
018700970925     C     *IN75         IFEQ      '1'
018800970929     C                   Z-ADD     0             ERR
018900970929     C                   MOVE      *BLANKS       ERRM
019000970929     C                   MOVE      X             ERR               2 0
019100970929     C                   MOVE      ER(2)         ERRM             20
019200970929     C                   MOVE      '1'           *IN86
019300970929     C**
019400970929     C     *IN86         IFEQ      '1'
019500970925     C                   GOTO      COMAGN
019600970929     C                   END
019700970929     C**
019800970925     C                   END
019900970925     C                   ELSE
020000970925     C                   GOTO      NOAGT
020100970925     C                   END
020200970925     C                   END
020300970925     C     NOAGT         TAG
020400970925     C*
020500970929     C*-----------------------------------------------------
020600970929     C*TRUST CHECK.(UPDATE MODE.)
020700970929     C                   DO        10            G                 2 0
020800970929     C                   MOVE      '0'           *IN85
020900970929     C                   MOVE      '0'           *IN86
021000970929     C     TRS(G)        IFNE      0
021100970929     C                   MOVE      *BLANKS       TRT               3 0
021200970929     C                   MOVE      TRS(G)        TRT
021300970929     C     TRT           CHAIN     TRSMST                             85
021400970929     C     *IN85         IFEQ      '1'
021500970929     C                   Z-ADD     0             ERR
021600970929     C                   MOVE      *BLANKS       ERRM
021700970929     C                   MOVE      G             ERR               2 0
021800970929     C                   MOVE      ER(1)         ERRM
021900970929     C                   MOVE      '1'           *IN86
022000970929     C**
022100970929     C     *IN86         IFEQ      '1'
022200970929     C                   GOTO      COMAGN
022300970929     C                   END
022400970929     C**
022500970929     C                   GOTO      COMAGN
022600970929     C                   END
022700970929     C                   ELSE
022800970929     C                   GOTO      NOTRT
022900970929     C                   END
023000970929     C                   END
023100970929     C     NOTRT         TAG
023200970929     C***-----------------------------------------------------
023300970929     C*SUB CHECK.(UPDATE MODE.)
023400970929     C                   DO        10            A                 2 0
023500970929     C                   MOVE      '0'           *IN95
023600970929     C                   MOVE      '0'           *IN86
023700970929     C     SUB(A)        IFNE      0
023800970929     C                   MOVE      *BLANKS       SUT               3 0
023900970929     C                   MOVE      SUB(A)        SUT
024000970929     C     SUT           CHAIN     SUBML1                             95
024100970929     C     *IN95         IFEQ      '1'
024200970929     C                   Z-ADD     0             ERR
024300970929     C                   MOVE      *BLANKS       ERRM
024400970929     C                   MOVE      A             ERR               2 0
024500970929     C                   MOVE      ER(3)         ERRM
024600970929     C                   MOVE      '1'           *IN86
024700970929     C**
024800970929     C     *IN86         IFEQ      '1'
024900970929     C                   GOTO      COMAGN
025000970929     C                   END
025100970929     C**
025200970929     C                   GOTO      COMAGN
025300970929     C                   END
025400970929     C                   ELSE
025500970929     C                   GOTO      NOSUT
025600970929     C                   END
025700970929     C                   END
025800970929     C     NOSUT         TAG
025900971001     C*-----------------------------------------------------
026000971001     C*ACCT CODE CHECK.(UPDATE MODE.)
026100971001     C                   DO        10            M                 2 0
026200971001     C                   MOVE      '0'           *IN52
026300971001     C                   MOVE      '0'           *IN86
026400971001     C     ACT(M)        IFNE      0
026500971001     C                   MOVE      TRS(M)        T
026600971001     C                   MOVE      SUB(M)        S
026700971001     C                   MOVE      ACT(M)        AC
026800971001     C     TSAKEY        CHAIN     ACCMST                             55
026900971001     C     *IN55         IFEQ      '1'
027000971001     C                   Z-ADD     0             ERR
027100971001     C                   MOVE      *BLANKS       ERRM
027200971001     C                   MOVE      M             ERR               2 0
027300971001     C                   MOVE      ER(4)         ERRM             20
027400971001     C                   MOVE      '1'           *IN86
027500971001     C**
027600971001     C     *IN86         IFEQ      '1'
027700971001     C                   GOTO      COMAGN
027800971001     C                   END
027900971001     C**
028000971001     C                   END
028100971001     C                   ELSE
028200971001     C                   GOTO      NOACT
028300971001     C                   END
028400971001     C                   END
028500971001     C     NOACT         TAG
028600971001     C*
028700970929     C***-----------------------------------------------------
028800970929     C*
028900010516     C                   MOVEL(P)  WSCFAX        SCFAX
029000970922     C                   UPDATE    SECR
029100970929     C*
029200970922     C                   GOTO      BEGIN
029300970929     C*
029400970922     C                   END
029500970929     C**----------------------------------------------------
029600970922     C* WRITE SECURITY RECORD.
029700970922     C     *IN50         IFEQ      '1'
029800970922     C                   EXSR      $INIT
029900970925     C*
030000970925     C     STRWRT        TAG
030100970925     C*
030200010516     C                   MOVEL     SCFAX         WSCFAX
030300970922     C                   EXFMT     S02
030400970925     C*
030500970925     C     *INKG         IFEQ      '1'
030600970925     C                   SETON                                        LR
030700970925     C                   RETURN
030800970925     C                   MOVE      '0'           *INKG
030900970925     C                   END
031000970925     C*
031100970925     C     *INKA         CABEQ     '1'           BEGIN
031200970925     C*
031300970929     C**----------------------------------------------------
031400970923     C*BROKER CODE CHECK.
031500970923     C                   MOVE      '0'           *IN42
031600970926     C     SCBRK         IFEQ      'ALL'
031700970926     C                   GOTO      COMBGN
031800970926     C                   END
031900970926     C     BKEY          CHAIN     SMAN                               51
032000970925     C     *IN51         IFEQ      '1'
032100970923     C                   MOVE      '1'           *IN42
032200970925     C                   GOTO      STRWRT
032300970923     C                   END
032400970925     C*
032500970925     C     COMBGN        TAG
032600970925     C*
032700970922     C                   EXFMT     S03
032800970929     C                   MOVE      '0'           *IN86
032900970929     C*
033000970922     C     *INKA         CABEQ     '1'           BEGIN
033100970929     C*
033200970929     C*---------------------------------------------------
033300970925     C*AGENCY CODE CHECK.(WRITE MODE.)
033400970925     C                   DO        10            Y                 2 0
033500970925     C                   MOVE      '0'           *IN77
033600970929     C                   MOVE      '0'           *IN86
033700970925     C     AGN(Y)        IFNE      ' '
033800970925     C                   MOVE      *BLANKS       AGCK              3
033900970925     C                   MOVE      AGN(Y)        AGCK
034000970925     C     AGCK          CHAIN     AGENCY                             77
034100970925     C     *IN77         IFEQ      '1'
034200970929     C                   Z-ADD     0             ERR
034300970929     C                   MOVE      *BLANKS       ERRM
034400970929     C                   MOVE      '1'           *IN86
034500970929     C                   MOVE      X             ERR
034600970929     C                   MOVE      ER(2)         ERRM
034700970929     C**
034800970929     C     *IN86         IFEQ      '1'
034900970929     C                   GOTO      COMBGN
035000970929     C                   END
035100970929     C**
035200970925     C                   GOTO      COMBGN
035300970925     C                   END
035400970925     C                   ELSE
035500970925     C                   GOTO      NOBGT
035600970925     C                   END
035700970925     C                   END
035800970925     C     NOBGT         TAG
035900970929     C*-----------------------------------------------------
036000970929     C*TRUST CHECK.(UPDATE MODE.)
036100970929     C                   DO        10            H                 2 0
036200970929     C                   MOVE      '0'           *IN87
036300970929     C                   MOVE      '0'           *IN86
036400970929     C     TRS(H)        IFNE      0
036500970929     C                   MOVE      *BLANKS       TRT               3 0
036600970929     C                   MOVE      TRS(H)        TRT
036700970929     C     TRT           CHAIN     TRSMST                             87
036800970929     C     *IN87         IFEQ      '1'
036900970929     C                   Z-ADD     0             ERR
037000970929     C                   MOVE      *BLANKS       ERRM
037100970929     C                   MOVE      H             ERR               2 0
037200970929     C                   MOVE      ER(1)         ERRM
037300970929     C                   MOVE      '1'           *IN86
037400970929     C**
037500970929     C     *IN86         IFEQ      '1'
037600970929     C                   GOTO      COMBGN
037700970929     C                   END
037800970929     C**
037900970929     C                   GOTO      COMBGN
038000970929     C                   END
038100970929     C                   ELSE
038200970929     C                   GOTO      TRTNO
038300970929     C                   END
038400970929     C                   END
038500970929     C     TRTNO         TAG
038600970929     C***-----------------------------------------------------
038700970929     C*SUB CHECK.(WRITE  MODE.)
038800970929     C                   DO        10            B                 2 0
038900970929     C                   MOVE      '0'           *IN96
039000970929     C                   MOVE      '0'           *IN86
039100970929     C     SUB(B)        IFNE      0
039200970929     C                   MOVE      *BLANKS       SUT               3 0
039300970929     C                   MOVE      SUB(B)        SUT
039400970929     C     SUT           CHAIN     SUBML1                             96
039500970929     C     *IN96         IFEQ      '1'
039600970929     C                   Z-ADD     0             ERR
039700970929     C                   MOVE      *BLANKS       ERRM
039800970929     C                   MOVE      B             ERR               2 0
039900970929     C                   MOVE      ER(3)         ERRM
040000970929     C                   MOVE      '1'           *IN86
040100970929     C**
040200970929     C     *IN86         IFEQ      '1'
040300970929     C                   GOTO      COMBGN
040400970929     C                   END
040500970929     C**
040600970929     C                   GOTO      COMBGN
040700970929     C                   END
040800970929     C                   ELSE
040900970929     C                   GOTO      NOSUTB
041000970929     C                   END
041100970929     C                   END
041200970929     C     NOSUTB        TAG
041300971001     C*-----------------------------------------------------
041400971001     C*ACCT CODE CHECK.(UPDATE WRITE)
041500971001     C                   DO        10            N                 2 0
041600971001     C                   MOVE      '0'           *IN53
041700971001     C                   MOVE      '0'           *IN86
041800971001     C     ACT(N)        IFNE      0
041900971001     C                   MOVE      TRS(N)        T
042000971001     C                   MOVE      SUB(N)        S
042100971001     C                   MOVE      ACT(N)        AC
042200971001     C     TSAKEY        CHAIN     ACCMST                             53
042300971001     C     *IN53         IFEQ      '1'
042400971001     C                   Z-ADD     0             ERR
042500971001     C                   MOVE      *BLANKS       ERRM
042600971001     C                   MOVE      N             ERR               2 0
042700971001     C                   MOVE      ER(4)         ERRM             20
042800971001     C                   MOVE      '1'           *IN86
042900971001     C**
043000971001     C     *IN86         IFEQ      '1'
043100971001     C                   GOTO      COMBGN
043200971001     C                   END
043300971001     C**
043400971001     C                   END
043500971001     C                   ELSE
043600971001     C                   GOTO      NOAT
043700971001     C                   END
043800971001     C                   END
043900971001     C     NOAT          TAG
044000971001     C*
044100970929     C***---------------------------------------------------
044200010516     C                   MOVEL(P)  WSCFAX        SCFAX
044300970922     C                   WRITE     SECR
044400970929     C*
044500970922     C                   GOTO      BEGIN
044600970929     C*
044700970922     C                   END
044800971001     C*
044900971001     C     ENDPGM        TAG
045000970922     C*
045100970923     C*---------------------------------------------------
045200970923     C     SEARCH        BEGSR
045300970923     C*
045400971001     C                   MOVE      '1'           *IN61
045500970923     C                   WRITE     S03CTL
045600970923     C*
045700970926     C     ALPHA         SETLL     GBSSECL1                               31
045800971002     C                   MOVE      '0'           *IN61
045900971001     C                   WRITE     S03CTL
046000971002     C                   Z-ADD     1             RR3               4 0
046100971001     C     READ          TAG
046200970926     C                   READ      GBSSECL1                               77
046300970923     C*
046400971001     C     *IN77         CABEQ     '1'           EXIT
046500970923     C*
046600971002     C                   MOVEL     USER          OCUSR
046700971002     C                   MOVEL     NAME          OCNAME
046800971002     C*
046900970923     C                   WRITE     S03SFL
047000971002     C                   ADD       1             RR3
047100970923     C*
047200970923     C                   GOTO      READ
047300970923     C     EXIT          TAG
047400970923     C                   SETON                                        6263
047500970923     C*
047600970923     C                   EXFMT     S03CTL
047700971001     C*
047800970923     C                   Z-ADD     1             RR3
047900970923     C     *IN90         DOUEQ     '1'
048000970923     C     RR3           CHAIN     S03SFL                             90
048100970923     C     *IN90         IFEQ      '0'
048200970923     C                   ADD       1             RR3
048300970923     C                   END
048400970923     C                   END
048500970923     C                   ENDSR
048600970922     C*----------------------------------------------------
048700970922     C     $INIT         BEGSR
048800970922     C                   CLEAR                   SCALL
048900970922     C                   CLEAR                   SCT1
049000970922     C                   CLEAR                   SCT2
049100970922     C                   CLEAR                   SCT3
049200970922     C                   CLEAR                   SCT4
049300970922     C                   CLEAR                   SCT5
049400970922     C                   CLEAR                   SCT6
049500970922     C                   CLEAR                   SCT7
049600970922     C                   CLEAR                   SCT8
049700970922     C                   CLEAR                   SCT9
049800970922     C                   CLEAR                   SCT10
049900970922     C                   CLEAR                   SCS1
050000970922     C                   CLEAR                   SCS2
050100970922     C                   CLEAR                   SCS3
050200970922     C                   CLEAR                   SCS4
050300970922     C                   CLEAR                   SCS5
050400970922     C                   CLEAR                   SCS6
050500970922     C                   CLEAR                   SCS7
050600970922     C                   CLEAR                   SCS8
050700970922     C                   CLEAR                   SCS9
050800970922     C                   CLEAR                   SCS10
050900970922     C                   CLEAR                   SCA1
051000970922     C                   CLEAR                   SCA2
051100970922     C                   CLEAR                   SCA3
051200970922     C                   CLEAR                   SCA4
051300970922     C                   CLEAR                   SCA5
051400970922     C                   CLEAR                   SCA6
051500970922     C                   CLEAR                   SCA7
051600970922     C                   CLEAR                   SCA8
051700970922     C                   CLEAR                   SCA9
051800970922     C                   CLEAR                   SCA10
051900970922     C                   CLEAR                   SAA1
052000970922     C                   CLEAR                   SAA2
052100970922     C                   CLEAR                   SAA3
052200970922     C                   CLEAR                   SAA4
052300970922     C                   CLEAR                   SAA5
052400970922     C                   CLEAR                   SAA6
052500970922     C                   CLEAR                   SAA7
052600970922     C                   CLEAR                   SAA8
052700970922     C                   CLEAR                   SAA9
052800970922     C                   CLEAR                   SAA10
052900970922     C                   CLEAR                   SCBRK
053000970922     C                   CLEAR                   SCDISP
053100970922     C                   CLEAR                   SCSUPD
053200970922     C                   CLEAR                   SCNAME
053300970922     C                   CLEAR                   SCBUS
053400970922     C                   CLEAR                   SCADDR
053500970922     C                   CLEAR                   SCCITY
053600970922     C                   CLEAR                   SCST
053700970922     C                   CLEAR                   SCPHON
053800970922     C                   CLEAR                   SCFAX
053900010516     C                   CLEAR                   WSCFAX
054000970922     C                   ENDSR
054100970929**
054200970929INVALID TRUST#
054300970929INVALID AGENCY#
054400970929INVALID SUB#
054500970929INVALID ACCOUNT#
