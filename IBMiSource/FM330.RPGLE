000100030521     H DATEDIT(*YMD)
0002009707230002 F******************************************************************
0003009909300003 F* FM330      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009707230004 F*                                                                *
0005009707230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006009708120006 F*            DATE - 08/12/97                                     *
0007009707230007 F*                                                                *
0008009708130008 F*  DESCRIPTION - THIS PROGRAM ALLOWS MAINTENANCE OF THE PCP      *
0009009708130009 F*                MASTER FILE. (PRIMARY CARE PHYSICIAN)           *
0010009811190012 F*11/19/98 DLW CHANGED DATE LENGTHS AND POSITIONING -Y2K COMPLIANT*
001100001115SSK  F*11/15/00 SSK ADD CURRENT PATIENT FIELD                          *
001200010110SSK1 F*11/27/00 SSK DATE ENTRY CHG FMT; RETAIN SSN                     *
001300010110SSK2 F*01/10/01 SSK CORRECT D-SPEC ENTRY                               *
001400020312     F*03/12/02 KSJ CDC CHANGES                                        *
001500020312SK   F*03/12/02 SSK PHN PLAN POPULATION FOR TRNMIT                     *
001600020315SK   F*03/15/02 dlk add fields to trnmit                               *
001700020405SK   F*04/05/02 dlk add mcov/dvoc effdt/candt to trnmit for PHN use    *
001800020530     F*05/20/02 KSJ Removed Current Patient field from input screen.   *
001900020530SK   F*             Added code to validate specialty code from input   *
002000020530SK   F*             screen to make sure mem/dep has plan that req's    *
002100020530SK   F*             PCP info to be entered and uses specialty code     *
002200020530SK   F*             from input screen.  Added code to check for an     *
002300020530SK   F*             existing rec in PCP that is active having the      *
002400020530SK   F*             same specialty code from input screen for a        *
002500020530SK   F*             mem/dep.                                           *
002600030521SK   F*05/21/03 dlk add 2nd rate search using today's date to find     *
002700030521SK   F*             group # for trnmit if group # was not found        *
002800030521SK   F*             using effdt.                                       *
002900040528SK   F*05/28/04 dlk Remove "PHN only" restriction for trnmit. Coventry *
003000040601SK   F*             will now need PCP info in trnmit. Also create      *
003100040601SK   F*             "COVMD" specialty code for Coventry medical.       *
003200050321     F* 03/21/05 JON - add pcp len(20)                                 *
003201070323     F*03/23/07 dlk Put Current Patient field back on screen.          *
003202111227     F* 10/29/08 JON - trnmit updates                                  *
003203111227     F* 12/27/11 JON - MCOV to SETGT/READPE it was using the wrong     *
003204111227SK   F*                group# from old plans and use enrldt for rate   *
003300040528SK   F*                                                                *
0034009811190013 F******************************************************************
003500001117     FFM330D    CF   E             WORKSTN
003600970812     F                                     SFILE(S02SFL:RR2)
003700970812     F                                     SFILE(S03SFL:RR3)
003800970813     FPCP       UF A E           K DISK
003900970812     FDEPEND    IF   E           K DISK
004000970813     FDEPNDC    IF   E           K DISK
004100970813     F                                     RENAME(DEPENR:DEPENCR)
004200020405     FDCOVC     IF   E           K DISK
004300970812     FMEMBER    IF   E           K DISK
004400970813     FSPCMST    IF   E           K DISK
004500970926     FCARMST    IF   E           K DISK
004600980821     FMCOV      IF   E           K DISK
004700980821     FGRATE     IF   E           K DISK
004800980821     FPLNMST    IF   E           K DISK
004900020417     FPLNMSTN1  IF   E           K DISK    RENAME(PLNMSR:PLNMS1)
005000020417     FSPCCAR    IF   E           K DISK
005100020417     FPCPL1     IF   E           K DISK    RENAME(PCPR:PCPL)
005101081118     FTRNCFSP   IF   E           K DISK
005200081105     FTRNMIT    O  A F 1474        DISK
0053009709240600 D                UDS
0054009707230601 D  CONAME               201    240
005500020312     D CDC             S              1
005600020312     D WRTREC          S              1
005700020417     D FOUND           S              1
005800020501     D ACTIVE          S              1
005900010110SSK1 D #HOLDSSN        S              9S 0
006000001127SSK1 D #ISO            S               D   DATFMT(*ISO)
006100001127SSK1 D #USA            S               D   DATFMT(*USA)
006200020312SK   D PHNPLAN#        S              4A
006300020312SK   D PHNMCVTYP       S              3A
0063010810290025
0063030811140651 D                 DS                  Inz
006304081114     D  QQTIME                 1      6S 0
0063050811140651 D                 DS                  Inz
006306081114     D  QQDATE                 1      8S 0
0063070811140651 D                 DS                  Inz
006308081114     D  QQUSER                 1     10
0063090811140651 D                 DS                  Inz
006310081114     D  QQFLAG                 1      1
0063110811140651 D                 DS                  Inz
006312081114     D  QQPGNM                 1     10
0063130811140651 D                 DS                  Inz
006314081114     D  QQFIXF                 1      1
0063150811140651 D                 DS                  Inz
006316081114     D  QQPCPE                 1      8S 0
0063170811140651 D                 DS                  Inz
006318081114     D  QQPCPC                 1      8S 0
0063190811140651 D                 DS                  Inz
006320081114     D  QQRVWR                 1     10
006321081114
006322081029      * Program status data structure
006323081029     D PGMD          ESDS                  EXTNAME(IOPGMD)
0063240810290025
006400981119     C*****************************************************************
006500971103     C     *ENTRY        PLIST
006600971103     C                   PARM                    SSNIN             9
006700001127SSK1 C*DLT               MOVE      SSNIN         ISSN
006800001127SSK1 C                   MOVE      SSNIN         #HOLDSSN
006900971103     C*
007000001127     C     DEPKY2        KLIST
007100001127     C                   KFLD                    R3SSN
007200001127     C                   KFLD                    R3DSEQ
007300001127     C     DEPKEY        KLIST
007400001127     C                   KFLD                    PCSSN
007500001127     C                   KFLD                    PCDSEQ
007600970813     C     PCPKEY        KLIST
007700970813     C                   KFLD                    ISSN
007800970813     C                   KFLD                    KSEQ
007900970813     C                   KFLD                    KID
008000970813     C                   KFLD                    KSPC
008100970813     C*
008200980821     C     PLNKEY        KLIST
008300980821     C                   KFLD                    MCTRST
008400980821     C                   KFLD                    MCSUB#
008500980821     C                   KFLD                    MCPLAN
008600980821     C*
008700980821     C     RATKEY        KLIST
008800980821     C                   KFLD                    MCTRST
008900980821     C                   KFLD                    MCSUB#
009000980821     C                   KFLD                    MCPLAN
009100980821     C                   KFLD                    MCAGEB
009200980821     C                   KFLD                    MCOVTP
009300020417     C*
009400020417     C     CKEY          KLIST
009500020417     C                   KFLD                    CARR
009600020417     C                   KFLD                    MCTRST
009700020417     C                   KFLD                    MCSUB#
009800020417     C                   KFLD                    MCPLAN
009900020417     C*
010000020417     C     PCKEY         KLIST
010100020417SSK1 C                   KFLD                    R3SSN
010200020417SSK1 C                   KFLD                    R3DSEQ
010300020417     C                   KFLD                    R3SPCD
010400980821     C*
010500980821     C*
010600970723     C     #START        TAG
010700970723     C*
010800970812     C* DISPLAY FIRST SCREEN
010900970723     C*
011000970812     C     #T0015        TAG
011100001127SSK1 C                   Z-ADD     #HOLDSSN      ISSN
011200970813     C                   EXFMT     S01
011300970813     C                   MOVE      ISSN          OSSN
011400001127SSK1 C                   Z-ADD     ISSN          #HOLDSSN
011500970812     C*
011600970812     C* CMD7 END
011700970812     C*
011800970812     C     *INKG         CABEQ     '1'           #END
011900970813     C*
012000970813     C* VALIDATE SSN
012100970813     C*
012200970813     C     ISSN          CHAIN     MEMBER                             21
012300970813     C     *IN21         CABEQ     '1'           #T0015
012400970812     C*
012500970812     C* CMD6 - DSPLAY SELECTION SCREEN
012600970812     C*
012700970812     C     *INKF         IFEQ      '1'
012800970812     C                   EXSR      #DSP02
012900970813     C*
013000970813     C                   ELSE
013100970813     C*
013200970813     C* DISPLAY UPDATE SCREEN (IF ADD SELECTED FROM FIRST SCREEN, FORCE
013300970813     C* A NO HIT ON CHAIN BY CLEARING KEY VALUES)
013400970813     C*
013500970813     C                   MOVE      *ZEROS        KSEQ
013600970813     C                   MOVE      *ZEROS        KID
013700970813     C                   MOVE      *ZEROS        KSPC
013800970813     C                   END
013900970813     C*
014000970813     C                   EXSR      #DSP03
014100971103     C                   MOVE      *ZEROS        ISSN
014200970813     C                   GOTO      #START
014300970812     C*
014400970812     C     #END          TAG
014500970812     C                   MOVE      *ON           *INLR
014600970812     C*
014700970813     C*******************************************************
014800970813     C* SCREEN 2 SUBROUTINE - SELECT RECORD TO UPDATE       *
014900970813     C*******************************************************
015000970812     C*
015100970812     C     #DSP02        BEGSR
015200970723     C*
015300970723     C* CLEAR SUBFILE
015400970723     C*
015500001127     C                   MOVEL     MFNAME        C2FNAME
015600001127     C                   MOVEL     MLNAME        C2LNAME
015700970813     C                   MOVEA     '0010'        *IN(60)
015800970813     C                   MOVE      ' '           SELECT
015900970812     C                   WRITE     S02CTL
016000970723     C                   MOVE      '0'           *IN62
016100970723     C*
016200970813     C* BUILD SUBFILE - LOAD ALL FOR THIS SSN
016300970723     C*
016400970723     C                   Z-ADD     1             SFREC#
016500970812     C                   MOVE      *ZEROS        RR2               5 0
016600970723     C                   MOVE      *ZEROS        COUNT             5 0
016700970813     C     ISSN          SETLL     PCP
016800970723     C     #T0100        TAG
016900970723     C*
017000970812     C                   READ      PCP                                    64
017100970723     C*
017200001127    1C     *IN64         IFEQ      '0'
017300970813     C     ISSN          ANDEQ     PCSSN
017400001127     C                   CLEAR                   S02SFL
017500001127    2C                   IF        PCDSEQ > 0
017600001127     C     DEPKEY        CHAIN     DEPNDC
017700001127    3C                   IF        %FOUND(DEPNDC)
017800001127     C                   MOVEL     DFNAME        S2NAME
017900001127    3C                   ELSE
018000001127     C                   MOVE      *BLANKS       S2NAME
018100001127    3C                   ENDIF
018200001127    2C                   ENDIF
018300001127     C                   Z-ADD     PCDSEQ        S2DSEQ
018400001127     C                   MOVEL     PCID#         S2ID#
018500020111     C                   MOVEL     PCSPCD        S2SPCD
018600001127    2C                   IF        PCEFF <> 0
018700001127     C                   MOVE      PCEFF         #ISO
018800001127     C                   MOVE      #ISO          #USA
018900001127     C                   MOVE      #USA          S2EFF
019000001127    2C                   ENDIF
019100001127    2C                   IF        PCCAN <> 0
019200001127     C                   MOVE      PCCAN         #ISO
019300001127     C                   MOVE      #ISO          #USA
019400001127     C                   MOVE      #USA          S2CAN
019500001127    2C                   ENDIF
019600001127     C                   MOVEL     PCCUR         S2CUR
019700970812     C                   ADD       1             RR2
019800970723     C                   ADD       1             COUNT
019900970812     C                   WRITE     S02SFL
020000970723     C                   GOTO      #T0100
020100001127    1C                   END
020200970723     C*
020300970723     C* DISPLAY SUBFILE
020400970723     C*
020500970723     C     #T0120        TAG
020600970813     C     RR2           IFGT      0
020700970813     C                   MOVE      '1'           *IN60
020800970813     C                   END
020900970813     C                   MOVE      '1'           *IN61
021000970813     C*
021100970813     C                   WRITE     S02CMDKY
021200970813     C                   EXFMT     S02CTL
021300970813     C*
021400970813     C* CMD1 RETURN
021500970813     C*
021600970813     C     *INKA         CABEQ     '1'           #T0015
021700970723     C*
021800970813     C* READ SUBFILE FOR PCP SELECTED
021900970723     C*
022000970813     C     *IN60         IFEQ      '1'
022100970723     C     #T0130        TAG
022200970812     C                   READC     S02SFL                                 66
022300970723     C  N66SELECT        CABEQ     ' '           #T0130
022400970723     C  N66SELECT        IFEQ      'X'
022500001127     C                   MOVE      S2DSEQ        KSEQ              2 0
022600050321     C                   MOVE      S2ID#         KID              20
022700001127     C                   MOVE      S2SPCD        KSPC              5
022800970723     C                   GOTO      #T0200
022900970723     C                   END
023000970813     C                   END
023100970723     C*
023200970813     C* ENTER PRESSED ... RE-DISPLAY AND TRY AGAIN
023300970723     C*
023400970813     C                   GOTO      #T0120
023500970723     C*
023600970723     C     #T0200        TAG
023700970812     C                   ENDSR
023800970813     C*
023900970813     C*******************************************************
024000970813     C* SCREEN 3 - UPDATE                                   *
024100970813     C*******************************************************
024200970813     C*
024300970812     C     #DSP03        BEGSR
024400970723     C*
024500970814     C* GET RECORD FOR UPDATE OR CLEAR FIELDS FOR ADD
024600970723     C*
024700020417     C                   MOVEA     '000000000'   *IN(32)
024800970813     C     PCPKEY        CHAIN     PCP                                31
024900001127     C                   MOVEL     MFNAME        R3FNAME
025000001127     C                   MOVEL     MLNAME        R3LNAME
025100970813     C*
025200001127    1C     *IN31         IFEQ      '1'
025300001127SSK1 C                   CLEAR                   PCPR
025400001127SSK1 C                   MOVE      ISSN          PCSSN
025500001127SSK1 C                   MOVE      ISSN          R3SSN
025600001127SSK1 C                   MOVE      *ZEROS        R3DSEQ
025700001127SSK1 C                   MOVE      *BLANKS       R3ID#
025800001127SSK1 C                   MOVE      *BLANKS       R3SPCD
025900001127SSK1 C                   MOVE      *ZEROS        R3EFF
026000001127SSK1 C                   MOVE      *ZEROS        R3CAN
026100070323SSK1 C                   MOVE      'N'           R3CUR
026200001127    1C                   ELSE
026300001127SSK1 C                   MOVE      ISSN          R3SSN
026400070323SSK1 C                   MOVE      PCCUR         R3CUR
026500001127SSK1 C                   MOVE      PCDSEQ        R3DSEQ
026600001127SSK1 C                   MOVE      PCID#         R3ID#
026700020111     C                   MOVE      PCSPCD        R3SPCD
026800001127    2C                   IF        PCEFF <> 0
026900001127     C                   MOVE      PCEFF         #ISO
027000001127     C                   MOVE      #ISO          #USA
027100001127     C                   MOVE      #USA          R3EFF
027200001127    2C                   ENDIF
027300001127    2C                   IF        PCCAN <> 0
027400001127     C                   MOVE      PCCAN         #ISO
027500001127     C                   MOVE      #ISO          #USA
027600001127     C                   MOVE      #USA          R3CAN
027700020808     C                   ELSE
027800020808     C                   MOVE      *ZEROS        R3CAN
027900001127    2C                   ENDIF
028000001127    1C                   END
028100970925     C* HOLD FOR COMPARE
028200001127     C                   MOVE      R3DSEQ        HPCDSE            2 0
028300050317     C                   MOVE      R3ID#         HPCID#           20
028400001127     C                   MOVE      R3SPCD        HPCSPC            5
028500001127     C                   MOVE      R3EFF         HPCEFF            8 0
028600001127     C                   MOVE      R3CAN         HPCCAN            8 0
028700070323SSK  C                   MOVE      R3CUR         HPCCUR            1
028800970813     C*
028900970723     C     #REDSP        TAG
029000970813     C                   EXFMT     S03
029100020417     C                   MOVEA     '000000000'   *IN(32)
029200970813     C*
029300970813     C     *INKA         CABEQ     *ON           #T0015
029400970813     C*
029500970813     C* DISPLAY DEPENDENTS IN WINDOW
029600970813     C*
029700970813     C     *INKB         IFEQ      *ON
029800970813     C                   EXSR      #DSPDP
029900970813     C                   GOTO      #REDSP
030000970813     C                   END
030100970723     C*
030200970813     C* EDIT
030300970813     C*
030400001127     C                   MOVE      *ZEROS        #R3ISOE
030500001128    1C                   IF        R3EFF = 0
030600001127     C                   MOVE      '1'           *IN32
030700001127     C                   GOTO      #REDSP
030800001128    1C                   ELSE
030900001128     C     *USA          TEST (DE)               R3EFF
031000001128    2C                   IF        %ERROR
031100001128     C                   MOVE      '1'           *IN32
031200001128     C                   GOTO      #REDSP
031300001128    2C                   ELSE
031400001127     C                   MOVE      R3EFF         #USA
031500001127     C                   MOVE      #USA          #ISO
031600001127     C                   MOVE      #ISO          #R3ISOE           8 0
031700050421    3C     #R3ISOE       IFLT      19900101
031800970813     C                   MOVE      '1'           *IN32
031900970813     C                   GOTO      #REDSP
032000001128    3C                   END
032100001128    2C                   END
032200001128    1C                   END
032300970813     C*
032400001127     C                   MOVE      *ZEROS        #R3ISOC
032500001128    1C                   IF        R3CAN <> 0
032600001128     C     *USA          TEST (DE)               R3CAN
032700001128    2C                   IF        %ERROR
032800001128     C                   MOVE      '1'           *IN34
032900001128     C                   GOTO      #REDSP
033000001128    2C                   ELSE
033100001127     C                   MOVE      R3CAN         #USA
033200001127     C                   MOVE      #USA          #ISO
033300001127     C                   MOVE      #ISO          #R3ISOC           8 0
033400001128    3C                   IF        #R3ISOC < #R3ISOE
033500970813     C                   MOVE      '1'           *IN34
033600970813     C                   GOTO      #REDSP
033700001128    3C                   END
033800001128    2C                   END
033900001128    1C                   END
034000970813     C*
034100001115SSK  C* CURRENT PATIENT
034200070323SSK  C                   IF        R3CUR <> 'Y' AND R3CUR <> 'N'
034300070323SSK  C                   MOVE      *ON           *IN38
034400070323SSK  C                   GOTO      #REDSP
034500070323SSK  C                   END
034600020111SSK  C
034700001127     C     R3SPCD        CHAIN     SPCMST                             33
034800970813     C     *IN33         CABEQ     '1'           #REDSP
034900970813     C*
035000001127     C     R3DSEQ        IFNE      0
035100001127     C     DEPKY2        CHAIN     DEPNDC                             35
035200970813     C     *IN35         CABEQ     '1'           #REDSP
035300020315     c                   move      dsex          dsexout           1
035400020315     c                   move      dbirth        dbirthout         8
035500020315     c                   move      drelcd        drelcdout         2
035600970813     C                   END
035700970813     C*
035800970813     C* SEX EDIT
035900970813     C*
036000970813     C     SPSEX         IFNE      'B'
036100970813     C* MEMBER
036200001127     C     R3DSEQ        IFEQ      0
036300970813     C     SPSEX         IFNE      SEX
036400970813     C                   MOVE      '1'           *IN36
036500970813     C                   GOTO      #REDSP
036600970813     C                   END
036700970813     C* DEPENDENT
036800970813     C                   ELSE
036900970813     C     SPSEX         IFNE      DSEX
037000970813     C                   MOVE      '1'           *IN36
037100970813     C                   GOTO      #REDSP
037200970813     C                   END
037300970813     C                   END
037400970813     C*
037500970813     C                   END
037600020530      *
037700020530      *  VALIDATES SPECIALTY CODE FROM INPUT SCREEN TO MAKE SURE MEM/DEP HAS PLA
037800020530      *  REQUIRES PCP INFO TO BE ENTERED AND USES SPECIALTY CODE FROM INPUT SCRE
037900020530      *
038000020417     C                   EVAL      FOUND = *BLANK
038100020417     C     R3SPCD        SETLL     SPCRR
038200020417     C     R3SPCD        READE     SPCRR                                  99
038300020417     C                   DOW       *IN99 = *OFF
038400020417     C     R3SSN         SETLL     MCOVR
038500020417     C     R3SSN         READE     MCOVR                                  98
038600020417     C                   DOW       *IN98 = *OFF
038700020417     C     CKEY          CHAIN     PLNMS1                             50
038800020417     C                   IF        *IN50 = *OFF
038900020417     C                   EVAL      FOUND = 'Y'
039000020417     C                   ENDIF
039100020417     C     R3SSN         READE     MCOVR                                  98
039200020417     C                   ENDDO
039300020417     C                   IF        FOUND = 'Y'
039400020417     C                   LEAVE
039500020417     C                   ENDIF
039600020417     C     R3SPCD        READE     SPCRR                                  99
039700020417     C                   ENDDO
039800020417     C
039900020417     C                   IF        FOUND <> 'Y'
040000020417     C                   MOVE      '1'           *IN39
040100020417     C                   GOTO      #REDSP
040200020417     C                   ENDIF
040300020530      *
040400020530      *  CHECKS FOR AN EXISTING REC IN PCP THAT IS ACTIVE AND HAS THE SAME
040500020530      *  SPECIALTY CODE FROM THE INPUT SCREEN FOR A MEM/DEP
040600020530      *
040700020501     C                   EVAL      ACTIVE = *BLANK
040800020501     C     PCKEY         SETLL     PCPL
040900020501     C     PCKEY         READE     PCPL                                   97
041000020501     C                   DOW       *IN97 = *OFF
041100070327     C                   IF        PCCAN = *ZEROS and pcid# <> r3id#
041200020501     C                   EVAL      ACTIVE = 'Y'
041300020501     C                   LEAVE
041400020501     C                   ENDIF
041500020501     C     PCKEY         READE     PCPL                                   97
041600020501     C                   ENDDO
041700020501
041800020501     C                   IF        #R3ISOC = *ZEROS
041900020501     C                             AND ACTIVE = 'Y'
042000020417     C                   MOVE      '1'           *IN40
042100020417     C                   GOTO      #REDSP
042200020417     C                   ENDIF
042300020530      *
042400020501     C***  PCKEY         CHAIN     PCPL                               51
042500020501     C*                  IF        *IN51 = *OFF
042600020501     C*                            AND PCDSEQ = R3DSEQ
042700020501     C*                            AND PCID# = R3ID#
042800020501     C*                            AND PCSPCD = R3SPCD
042900020501     C*                            AND PCEFF = #R3ISOE
043000020501     C*                            AND PCCAN = #R3ISOC
043100020501     C*                  MOVE      '1'           *IN40
043200020501     C*                  GOTO      #REDSP
043300020501     C*                  ENDIF
043400020501     C**                           AND PCCAN = *ZEROS
043500020501     C**                           AND PCCUR = R3CUR
043600020501     C*
043700020417     C******
043800001127     C                   Z-ADD     R3DSEQ        PCDSEQ
043900001127     C                   MOVEL(P)  R3ID#         PCID#
044000001127     C                   MOVEL(P)  R3SPCD        PCSPCD
044100001127     C                   Z-ADD     #R3ISOE       PCEFF
044200001127     C                   Z-ADD     #R3ISOC       PCCAN
044300020506     C                   MOVEL(P)  *BLANK        PCCUR
044400070323     C                   MOVEL(P)  R3CUR         PCCUR
044500970813     C*
044600970813     C* UPDATE
044700970723     C*
044800020507     C   31              WRITE     PCPR                                 37
044900020507     C     *IN37         CABEQ     '1'           #REDSP
045000020507     C  N31              UPDATE    PCPR                                 37
045100970813     C*
045200970926     C* CHECK TRANSMIT Y OR N
045300970924     C*
045400020111     C***  'PHN'         CHAIN     CARMST                             38
045500020114     C*    PCARR         CHAIN     CARMST                             38
045600020114     C*    *IN38         CABEQ     *ON           #END03
045700020114     C*    TXMTYN        CABNE     'Y'           #END03
045800970926     C*
045900970926     C* CHECK FOR CHANGE IN FIELDS
046000970926     C*
046100001127     C     R3DSEQ        IFEQ      HPCDSE
046200001127     C     R3ID#         ANDEQ     HPCID#
046300001127     C     R3SPCD        ANDEQ     HPCSPC
046400001127     C     R3EFF         ANDEQ     HPCEFF
046500001127     C     R3CAN         ANDEQ     HPCCAN
046600070405     C**   R3CUR         ANDEQ     HPCCUR
046700970925     C                   GOTO      #END03
046800970925     C                   END
046900970925     C*
047000970925     C* FILL FIELDS FOR TRANSMISSION RECORD
047100970925     C*
047200001127     C                   MOVE      R3SSN         SOCSOC            9
047300001127     C     R3DSEQ        IFEQ      0
047400970925     C                   MOVE      *BLANKS       DEPSEQ            2
047500970924     C                   ELSE
047600001127     C                   MOVE      R3DSEQ        DEPSEQ
047700970924     C                   END
047800970925     C*
047900001127     C                   MOVE      #R3ISOE       ENROUT            8
048000001127     C                   MOVE      #R3ISOC       CANCDT            8
048100970925     C* MEMBER
048200001127     C     R3DSEQ        IFEQ      0
048300001127     C                   MOVEL     R3SPCD        PCPS              4
048400050321     C                   MOVE      R3ID#         PCPI             20
048500970925     C                   ELSE
048600970925     C* DEPEND
048700001127     C                   MOVEL     R3SPCD        DPCPS             4
048800050321     C                   MOVE      R3ID#         DPCPI            20
048900970924     C                   END
049000970924     C*
049100980821     C* GET GROUP # FOR TRANSMISSION
049200970925     C*
049300980821     C                   MOVE      *BLANKS       GRP#             15
049400020115     C                   EVAL      WRTREC = 'N'
049500111227     C     R3SSN         SETGT     MCOV
049600980821     C     #T0400        TAG
049700111227     C     R3SSN         READPE    MCOV                                   93
049800980821     C*
049900980821     C     *IN93         IFEQ      '0'
050000980821     C*
050100980821     C* GET MCOV REC FOR EFFDT OF PCP REC
050200040528     C*
050300040528     C*
050400020405     C     enrldt        CABeq     candt         #T0400
050500111227     C**** #R3ISOE       CABLT     ENRLDT        #T0400
050600980821     C     CANDT         IFNE      0
050700001127     C     #R3ISOE       CABGE     CANDT         #T0400
050800980821     C                   END
050900980821     C*
051000980821     C     PLNKEY        CHAIN     PLNMST                             94
051100980821     C     *IN94         CABEQ     *ON           #T0400
051200020115
051300020405     C                   IF        (pcarr  = 'PHN' AND
051400020115     C                             (PCSPCD <> 'MED  ' AND PCSPCD <> 'OBGYN')) OR
051500020115     C                             (PLNCAT = 'PDN' AND
051600040601     C                             (PCSPCD <> 'DEN  ' AND PCSPCD <> 'CDCDN')) or
051700040601
051800040601     C                             (pcspcd = 'COVMD' and
051900040601     C                             (pcarr  <> 'COV' AND pcarr  <> 'PRN'))
052000020115     C                   GOTO      #T0400
052100020115     C                   ENDIF
052101111227
052102111227      * Find the correct plan and use that one
052103111227     C                   Select
052104111227     C                   When      %trim(PCSPCD) = 'MED' and
052105111227     C                             %trim(PLNCAT) = 'PMM'
052106111227     C                   When      %trim(PCSPCD) = 'OBGYN' and
052107111227     C                             %trim(PLNCAT) = 'PMM'
052108111227     C                   When      %trim(PCSPCD) = 'DEN' and
052109111227     C                             %trim(PLNCAT) = 'PDN'
052110111227     C                   When      %trim(PCSPCD) = 'DEN' and
052111111227     C                             %trim(PLNCAT) = 'PDR'
052112111227     C                   Other
052113111227     C                   GOTO      #T0400
052114111227     C                   Endsl
052200020115
052300020114     C     PCARR         CHAIN     CARMST                             38
052400020114     C     *IN38         CABEQ     *ON           #T0400
052500040528     C****               IF        TXMTYN = 'Y' AND PCARR = 'PHN'
052600040528     C                   IF        TXMTYN = 'Y'
052700020115     C                   EVAL      WRTREC = 'Y'
052800020115     C                   ELSE
052900020115     C                   EVAL      WRTREC = 'N'
053000020115     C                   ENDIF
053100020114     C     TXMTYN        CABNE     'Y'           #T0400
053200980821     C*
053300980824     C* USE PCP EFFDT FOR RATE SEARCH
053400980824     C*
053401111227     c*****************  move      #r3isoe       hcymd             8 0
053500111227     c                   move      enrldt        hcymd             8 0
053600030521     c                   exsr      #grate
0537000305210867 C*
0538000305210867 C* IF NO RATE REC FOUND, USE today's date to find group #
0539000305210867 C*
0540000305210862 C                   if        grp# = *blanks
054100030521y2k  C                   Z-ADD     udate8        HCYMD
0542000305210866 C                   EXSR      #grate
0543000305210864 C                   end
054400030521
054500980821     C                   END
054600980821     C*
054700020312SK  ***
054800040601SK   C* FILL IN PLAN AND COVERAGE TYPES and eff/can dates
054900020312SK  ***
055000020405SK   C                   clear                   coveffout         8 0
055100020405SK   C                   clear                   covcanout         8 0
055200020405
055300040528SK   C***                IF        PCARR = 'PHN'
055400020312SK   C                   MOVEL(P)  MCPLAN        PHNPLAN#
055500020312SK   C                   MOVEL(P)  MCOVTP        PHNMCVTYP
055600020405SK   C                   move      enrldt        coveffout
055700020405SK   C                   move      candt         covcanout
055800020405     c* if this was a dependent transaction - get dcov eff/can dates instead
055900020405     c                   if        r3dseq <> 0
056000020405     c                   exsr      #getdcov
056100020405     c                   end
056200040528SK   C***                ENDIF
056300980821     C*
056301081118      * Set defaults
056302081118     C                   Exsr      TRNCFS
056312081029
056400980821     C* WRITE TRANSMISSION RECORD
056500980821     C*
056600040528     C                   IF        WRTREC = 'Y'
056700970925     C                   EXCEPT    TRNOUT
056800040528     C                   EVAL      WRTREC = 'N'
056900020115     C                   ENDIF
057000970924     C*
057100970925     C     #END03        ENDSR
057200970813     C*
057300970813     C**********************************************
057400970813     C* DISPLAY DEPENDENTS IN WINDOW               *
057500970813     C**********************************************
057600970813     C*
057700970813     C     #DSPDP        BEGSR
057800970813     C*
057900970813     C* CLEAR SUBFILE
058000970813     C*
058100970813     C                   MOVEA     '001'         *IN(90)
058200970813     C                   WRITE     S03CTL
058300970813     C                   MOVE      '0'           *IN92
058400970813     C*
058500970813     C* BUILD SUBFILE - LOAD ALL
058600970813     C*
058700970813     C                   MOVE      *ZEROS        RR3               5 0
058800970813     C     OSSN          SETLL     DEPEND
058900970813     C     #T0300        TAG
059000970813     C     OSSN          READE     DEPEND                                 91
059100970813     C     *IN91         IFEQ      '0'
059200970813     C                   ADD       1             RR3
059300970813     C                   WRITE     S03SFL
059400970813     C                   GOTO      #T0300
059500970813     C                   END
059600970813     C*
059700970813     C* DISPLAY SUBFILE IN WINDOW
059800970813     C*
059900970813     C     RR3           IFGT      0
060000970813     C                   MOVE      '1'           *IN90
060100970813     C                   END
060200970813     C*
060300970813     C                   WRITE     WINDOW
060400970813     C                   EXFMT     S03CTL
060500970813     C                   ENDSR
060600020405     C**********************************************
060700020405     C* get dcov rec for dates                     *
060800020405     C**********************************************
060900020405     C     #getdcov      BEGSR
061000020405     C*
061100020405     c                   clear                   coveffout
061200020405     c                   clear                   covcanout
061300020405
061400020405     C     depky2        setll     dcovc
061500020808     c                   dou       %eof(dcovc)
061600020405     C     depky2        reade     dcovc
061700020808     c                   if        not %eof(dcovc) and (denrdt <> ccandt) and
061800020405     c                             (#r3isoe >= denrdt) and (ccandt = 0 or
061900020405     c                             (ccandt <> 0 and #r3isoe < ccandt))
062000020405     c                   move      denrdt        coveffout
062100020405     c                   move      ccandt        covcanout
062200020405     c                   leave
062300020405     c                   end
062400020405     c                   enddo
062500020405
062600020405     C                   ENDSR
062700030521     C**********************************************
062800030521     C* get grate for group #                      *
062900030521     C**********************************************
063000030521     C     #grate        BEGSR
063100030521     c                   clear                   grp#
0632000305210074 C                   SETOFF                                           60
0633000305210076 C     RATKEY        SETLL     GRATE
0634000305210078 C     #READ         TAG
0635000305210080 C     RATKEY        READE     GRATE                                  60
0636000305210083
063700030521     C     *IN60         IFEQ      *OFF
0638000305210084 C     hcymd         IFGE      FRMDAT
0639000305210085 C     hcymd         ANDLE     TODAT
0640000305210086 C                   MOVE      GROUP#        GRP#
064100030521     C                   ELSE
064200030521     C                   GOTO      #READ
0643000305210089 C                   END
0644000305210089 C                   END
064500030521     C*
064600030521     C                   ENDSR
064601081118DTAQ  ******************************************************
064602081118      * Set defaults - CUSTOM FOR FM330
064603081118DTAQ  ******************************************************
064604081118DTAQ C     TRNCFS        BEGSR
064605081118     C                   eval      QQPGNM = WQPGMN
064606081118     C                   eval      QQUSER = WQUSRN
064607081118
064608081118     C     QQPGNM        Chain     TRNCFSP
064609081118     C                   if        %found(TRNCFSP)
064610081118     C                   if        OOSTAT = 'Y'
064611081118     C                   eval      QQFLAG = OOFLAG
064612081118     C                   else
064613081118     C                   eval      QQFLAG = OOOFFL
064614081118     C                   end
064615081118     C                   else
064616081118     C                   eval      QQFLAG = 'H'
064617081118     C                   end
064618081118
064619081118     C                   eval      QQFIXF = 'N'
064620081118     C                   z-add     *date         QQDATE
064621081118     C                   Time                    QQTIME
064624081118     C                   move      ENROUT        QQPCPE
064625081118     C                   move      CANCDT        QQPCPC
064626081118DTAQ C                   ENDSR
064700030521
064800030521     C     *inzsr        begsr
0649000305210621 C                   MOVE      *DATE         UDATE8            8 0
065000030521     C                   ENDSR
065100970925     OTRNMIT    EADD         TRNOUT
0652009709250149 O                                            2 'PC'
065300020315     O                       sex                393
065400020313     O                       MBTRST         B   412
065500020313     O                       MBSUB#         B   415
065600020313     O                       MBACCT         B   419
065700050321     O*** moved below        PCPI           B   544
065800970925     O                       PCPS           B   548
065900020315     O                       drelcdout      B   808
066000020315     O                       dsexout        B   926
066100050321     O*** moved below        DPCPI          B  1060
066200970925     O                       DPCPS          B  1064
066300020312SK   O                       PHNPLAN#       B  1068
066400020312SK   O                       PHNMCVTYP      B  1073
0665009808210828 O                       GRP#           B  1108
066600970925     O                       SOCSOC         B  1133
0667000201110149 O                       PCARR          B  1142
0668009709250149 O                                         1159 'FM330'
066900970925     O                       DEPSEQ         B  1161
0670000204050149 O                                         1168 'A'
067100020315     O                       birth          B  1224
067200020315     O                       dbirthout      B  1304
067300020405     o* for this transacion ONLY - store PCP effective & cancel
067400020405     o* date in pos 1329-1336 & 1337-1344 (normally used for MCOV enroll
067500020405     o* and cancel date)
067600020405     O                       ENROUT         B  1336
067700020405     O                       CANCDT         B  1344
067800020405     o* for this transacion ONLY - store MCOV/DCOV effective & cancel
067900020405     o* date in pos 1345-1352 & 1353-1360 (normally used for dcov enroll
068000020405     o* and cancel date)
068100020405     O                       coveffout      B  1352
068200020405     O                       covcanout      B  1360
0683000201110149 O**************************************** 1142 'PHN'
068400050321     O                       PCPI           B  1424
068500050321     O                       DPCPI          B  1444
068501081114      *
068600081114      * New fields placed here to bypass DS overlay above
0687000811144330 O                       QQTIME             126
0688000811144330 O                       QQDATE             463
0689000811144330 O                       QQUSER             718
0690000811144330 O                       QQFLAG             719
0691000811144330 O                       QQPGNM             976
0692000811144330 O                       QQFIXF             977
0693000811144336 O                       QQPCPE            1081
0694000811144336 O                       QQPCPC            1120
069500081114      *
