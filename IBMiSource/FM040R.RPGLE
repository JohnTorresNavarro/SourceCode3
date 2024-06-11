000100220131        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220131                         DftActGrp(*no)
000300220131                         bnddir('GBSBIND' )   ;
000400000218     **********************************************************************
000500000218     ** FM040 APPLICATION = GROUP RATE FILE MAINTENANCE
000600000218     **
000700151109     ** *** Any time Cov Level codes change - this pgm must be changed -
000800151109     ** *** Search for 'nxttyp' to find code!!!!
000900151109     **
001000000218     ** FM040R - MAINTENANCE PROGRAM TO ADD/CHANGE GRATE FILE RECORDS.
001100000218     **
001200000218     ** ORIGINAL SOURCE BY MICHAEL C. DUNPHY 19880713 [S/36-RPGII]
001300000218     **                    GROUP BENEFIT SERVICES SOFTWARE  1988
001400000218     **
001500000218     ** REWRITTEN SOURCE BY STEPHEN S. KING 20000218 [AS/400-RPGIV]
001600000218     **                     INNOVATIVE OUTSOURCING SOFTWARE  2000
001700030509     **
001800000218     **********************************************************************
001900000218     **
002000000218     ** MODIFICATION HISTORY
002100000218     **
002200000218     ** ### UUU CCYYMMDD X---->
002300000218     ** 000 SSK 20000218 REWRITE OF 1988 SOURCE
002400000831     ** 001 DLK 20000413 REMOVE SKIP OF DELETED REC ON COPY
002500000831     ** 002 DLK 20000731 ADD EDIT: NET AND BILL RATE MUST BE ENTERED
002600001011     ** 003 SSK 20001011 FIX AGE BAND EDIT TO NOT BE Y/N
002700001018     ** 004 SSK 20001018 MORE STUFF CHANGED
002800001107     ** 005 SSK 20001107 WHEN WILL THEY STOP CHANGING THEIR MINDS?
002900001107     **                   ADDED AUTO POP STATUS/GROUP FOR SGR<>'B'
003000001107     **                   ADDED BIL MUST <> NET AMTS EDIT FOR NON B'S
003100011009     ** 006 SSK 20011009 ADD TRUST, SUB, & PLAN INQUIRIES
003200011009     **                   ADD FULL COPY LOGIC FOR HIST RECS
003300030509     ** 007 dlk 20021025 add group # edit for delegated billing.
003400030509     ** 008 ssk 20030509 add temp group file
003500040728     ** 009 KSJ 20040723 Call Market Size Maint. Pgm (FM063)
003600040728     **                  ADD MCOVL1 to get acct for call to fm063cl
003700070925     **     dlk 20070925 change bilrte and netrte to 6 decimal
003800080822     **     dlk 20080822 hard code carrier "MBF" to allow billed rate
003900080822     **                  = 0 and net rate <> 0
004000091214     **     dlk 20091214 hard code carrier "NAB" to allow billed rate
004100091214     **                  = 0 and net rate <> 0
004200110415     **     szz 20100506 Show command key for Payroll Deduction Maintenance.
004300110415     **     jon 20110415 On Change, also create payroll deduction records
004400110415     **                  from previous date range deductions (copy)
004500120120     **     SSK 20120120 GO RAVENS!  OH, AND FIXED THE BUG FOR BLANKS ALSO.
004600140409     **     SSK 20140409 ADD ACA PLAN GROUP# PROTECTION *IN60(PR) IF ACA
004700150312     **     jon 20140715 prevent F8 deductions if not in security file
004800150313     **     jon 20150312 add F9 for deductions selection
004900150313     **     jon 20150312 prevent F9 deductions if not in security file
005000140409     **
005100150622     **     jon 20150400 check plnauxp shop/aca
005200150622     **     jon 20150400 check annicilary deductions
005300140409     **
005400151109     **     rlj 20151109 change Cov Type sequence in SF IO02S
005500161215     **     dlk 20161215 hard code carrier "ABF" to allow billed rate
005600161215     **                  = 0 and net rate <> 0
005700181001     **    B.Rees  10/01/2018   Added option to run Plan Rate Copy
005800191120     **     dlk 20191120 hard code carrier "MBC" to allow billed rate
005900191120     **                  = 0 and net rate <> 0
006000200224     **     jt  20200224 Added UHC mapping files
006100140409     **
006200200311     **    J.Allen 03/11/2020   Display F8/F9 for critical care plans
006300200311     **                         New action code 'X'
006400220202     **
006500220304     **    J.Allen 02/01/2022   Converted to Profound Logic screens
006600220304     **    J.Allen 02/04/2022   Clear when subfile scroll on empty lines
006601220812     **    jt      08/12/2022   Clear pos for scanning group # for UHC purpose.
006700000218     **********************************************************************
006800000211     FGRATE     O  A E           K DISK
006900000218     ** GROUP RATE PHYSICAL FILE
007000001205     FGRAT24    UF A E           K DISK    RENAME(GRATER:G24)
007100000218     ** GROUP RATE LOGICAL
007200001205     FGRATEX    UF A E           K DISK    RENAME(GRATER:GX)
007300000218     ** GROUP RATE LOGICAL
007400150402     FPLNMST    IF   E           K DISK
007500150402     FPLNAUXP   IF   E           K DISK
007600000218     ** PLAN MASTER FILE
007700000210     FTRSMST    IF   E           K DISK
007800000218     ** TRUST MASTER FILE
007900000210     FSUBMST    IF   E           K DISK
008000000218     ** SUBDIVISION MASTER FILE
008100000210     FCODES     IF   E           K DISK
008200040723     ** CODES MASTER FILE
008300021023     Fcarmst    IF   E           K DISK
008400040723     Fmcovl1    IF   E           K DISK
008500110415     FPAYDED    UF a E           K Disk
008600110415     FPAYDEDANP UF a E           K Disk
008700101115     FWEBPAYSEC IF   E           K DISK
008800100527     F********CLASS     IF   E           K Disk
008900030509     ftempg#    uf a e           k disk
009000030509    *** temporary group file
009100000211     FGRTHIST0  O  A E             DISK
009200000218     ** GROUP RATE HISTORY TRANSACTION FILE
009300200221     **
009400200221     fcarplnz   uf   e           k disk    rename(carplnr:uhcPlan)
009500200221
009600200224     fuhcplancrtif   e           k disk    rename(uhcpcr:uhcPlncrt) usropn
009700200221
009800200221
009900000428     FFM040D    CF   E             WORKSTN INFDS(WSDS)
010000000210     F                                     SFILE(IO03S:RRT)
010100000210     F                                     SFILE(IO02S:RR2)
010200220131     F                                     HANDLER('PROFOUNDUI(HANDLER)')
010300000218     ** MAINTENANCE SCREEN
010400000209   X***X
010500001107      *
010600150506
010700001107    *** MISC FIELDS
010800001107      *
010900150622     D ANCFLG          S              1A
011000110415     D @AUTO           S              1A
011100150506     D CHGDAT          S              1A
011200150506     D REFPLN          S              4A
011300120127     D WWDATE          S              8S 0
011400120127     D TODAY           S              8S 0
011500151109     D nxttyp          S              3A
011600151109     D typfnd          S              1A
011700200221     d pos             s              2  0
011800200221     d pos2            s              2  0
011900200221     d pos3            s              2  0
011901220812     d #len            s              2  0
012000200221     d lenght          s              1  0
012100220131     d WF8KEY          s             20
012200220208     d WF9KEY          s             20
012300220302     d W89             s              2
012400220208     d @4              s              4
012500220208
012600220208      *?Trust Selection Window
012700220208     D Trust_Window    pr                  extpgm('WN0014R')
012800220208     D   iTrust                       3s 0
012900220208     D   iDescr                      20
013000220208     D   iCancel                      1
013100220208     d iDescr          s             20
013200220208     D iTrust          s              3s 0
013300220208     d Cancel          s              1
013400220208
013500220208      *?Subdivision Selection Window
013600220208     D Sub_Window      pr                  extpgm('WN0015R')
013700220208     D   iTrust                       3s 0
013800220208     D   iSub#                        3s 0
013900220208     D   iDescr                      20
014000220208     D   iCancel                      1
014100220208     D iSub#           s              3s 0
014200220208
014300220208      *?Plan Selection Window
014400220208     D Pln_Window      pr                  extpgm('WN0012R')
014500220208     D   iTrust                       3s 0
014600220208     D   iSub#                        3s 0
014700220208     D   iAcct                        4s 0
014800220208     D   iPlan                        4
014900220208     D   iCancel                      1
015000220208     D   iClass                       4
015100220208     D iAcct           s              4s 0
015200220208     D iPlan           s              4a
015300220208     D iClass          s              4a
015400200221
015500000218    *** COMPANY TITLE
015600001107      *
015700000211     D                UDS
015800000211     D  TITLE                201    240A
015900001018      *
016000001018    *** DATE WORK FIELDS
016100001018      *
016200001018     D #ISO            S               D   DATFMT(*ISO)
016300001018     D #USA            S               D   DATFMT(*USA)
016400001019     D #F03ISO         S              8S 0
016500001019     D #T03ISO         S              8S 0
016600001019     D #NKFISO         S              8S 0
016700001019     D #NKTISO         S              8S 0
016800100505    ***
016900100817     D WDTA          E DS                  extname(PAYDED)
017000111012     D WDTAA         E DS                  extname(PAYDEDANP) inz
017100111012     D WALERT        E DS                  extname(GRTHIST0)
017200030512      *
017300030512     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
017400030512     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
017500000218      *
017600000218    *** INDICATOR FIELDS DATA STRUCTURE
017700000218      *
017800000209     D WSDS            DS
017900000209     D  FKEY                 369    369A
018000000218      *
018100000218    *** TIMESTAMP FIELDS DATA STRUCTURE
018200000218      *
018300000211     D @TIMESTAMP      DS
018400000211     D  #TSCYMD                1      8S 0
018500000211     D  #TSTIME                9     14S 0
018600000211     D  @TSJOB                15     24
018700000211     D  @TSUSER               25     34
018800000211     D  #TSNBR                35     40S 0
018900000218      *
019000000218    *** FM041 PARAMETERS DATA STRUCTURE
019100000218      *
019200000216     D @PARM           DS
019300000216     D  #TRSTN                 1      3S 0
019400000216     D  #SUBNO                 4      6S 0
019500000216     D  @PLNCD                 7     10A
019600000216     D  @TRNAM                11     24A
019700000216     D  @SBNAM                25     38A
019800000216     D  @PCNAM                39     52A
019900000218      *
020000000218    *** DATE CHECK FIELD DATA STRUCTURE
020100000218      *
020200000211     D #CYMDF          DS
020300000210     D  #CYF                   1      4S 0
020400000210     D  #MF                    5      6S 0
020500000210     D  #DF                    7      8S 0
020600000210     D #CYMDT          DS
020700000210     D  #CYT                   1      4S 0
020800000210     D  #MT                    5      6S 0
020900000210     D  #DT                    7      8S 0
021000021023     D                 DS
021100021023     D O2GROP                  1     15
021200021023     D g14                     1      4
021300021023     D g58                     5      8
021400021023     D g912                    9     12
021500021023     D g1315                  13     15
021600000218      *
021700040723    *** PARMS FOR CALL TO FM063CL
021800040723     D                 DS
021900040723     D @@TSA                   1     10A
022000040723     D  @TRST                  1      3S 0
022100040723     D  @SUB                   4      6S 0
022200040723     D  @ACCT                  7     10S 0
022300040723      *
022400000218    *** FUNCTION KEY CONSTANTS
022500000218      *
022600000209     D  F1             C                   CONST(X'31')
022700000209     D  F2             C                   CONST(X'32')
022800000209     D  F3             C                   CONST(X'33')
022900000209     D  F4             C                   CONST(X'34')
023000000209     D  F5             C                   CONST(X'35')
023100000209     D  F6             C                   CONST(X'36')
023200000209     D  F7             C                   CONST(X'37')
023300000209     D  F8             C                   CONST(X'38')
023400000209     D  F9             C                   CONST(X'39')
023500000209     D  F10            C                   CONST(X'3A')
023600000209     D  F11            C                   CONST(X'3B')
023700000209     D  F12            C                   CONST(X'3C')
023800000209     D  F13            C                   CONST(X'B1')
023900000209     D  F14            C                   CONST(X'B2')
024000000209     D  F15            C                   CONST(X'B3')
024100000209     D  F16            C                   CONST(X'B4')
024200000209     D  F17            C                   CONST(X'B5')
024300000209     D  F18            C                   CONST(X'B6')
024400000209     D  F19            C                   CONST(X'B7')
024500000209     D  F20            C                   CONST(X'B8')
024600000209     D  F21            C                   CONST(X'B9')
024700000209     D  F22            C                   CONST(X'BA')
024800000209     D  F23            C                   CONST(X'BB')
024900000209     D  F24            C                   CONST(X'BC')
025000000218      *
025100000218    *** ERROR MESSAGE AND DAYS OF MONTH ARRAYS
025200000218      *
025300150415     D MSG             S             45    DIM(31) CTDATA PERRCD(1)
025400000210     D DOM             S              2  0 DIM(12) CTDATA PERRCD(12)
025500220202
025600220202       dcl-pr WN0024R ExtPgm('WN0024R');
025700220202         pType   Char(1);
025800220202         pfCode  Char(2);
025900220202         pcancel Char(1);
026000220202       End-Pr;
026100220202       dcl-s pType  Char(1);
026200220202       dcl-s pfCode  Char(2);
026300220202       dcl-s pcancel Char(1);
026400000218      *
026500000218    *** AGE BANDS FROM DATE ARRAY
026600000218      *
026700000210     D                 DS
026800000210     D AFR                     1     60  0 DIM(20)
026900000210     D  PABF01                 1      3  0
027000000210     D  PABF02                 4      6  0
027100000210     D  PABF03                 7      9  0
027200000210     D  PABF04                10     12  0
027300000210     D  PABF05                13     15  0
027400000210     D  PABF06                16     18  0
027500000210     D  PABF07                19     21  0
027600000210     D  PABF08                22     24  0
027700000210     D  PABF09                25     27  0
027800000210     D  PABF10                28     30  0
027900000210     D  PABF11                31     33  0
028000000210     D  PABF12                34     36  0
028100000210     D  PABF13                37     39  0
028200000210     D  PABF14                40     42  0
028300000210     D  PABF15                43     45  0
028400000210     D  PABF16                46     48  0
028500000210     D  PABF17                49     51  0
028600000210     D  PABF18                52     54  0
028700000210     D  PABF19                55     57  0
028800000211     D  PABF20                58     60  0
028900000218      *
029000000218    *** AGE BANDS TO DATE ARRAY
029100000218      *
029200000210     D                 DS
029300000211     D ATO                     1     60  0 DIM(20)
029400000210     D  PABT01                 1      3  0
029500000210     D  PABT02                 4      6  0
029600000210     D  PABT03                 7      9  0
029700000210     D  PABT04                10     12  0
029800000210     D  PABT05                13     15  0
029900000210     D  PABT06                16     18  0
030000000210     D  PABT07                19     21  0
030100000210     D  PABT08                22     24  0
030200000210     D  PABT09                25     27  0
030300000210     D  PABT10                28     30  0
030400000210     D  PABT11                31     33  0
030500000210     D  PABT12                34     36  0
030600000210     D  PABT13                37     39  0
030700000210     D  PABT14                40     42  0
030800000210     D  PABT15                43     45  0
030900000210     D  PABT16                46     48  0
031000000210     D  PABT17                49     51  0
031100000210     D  PABT18                52     54  0
031200000210     D  PABT19                55     57  0
031300000211     D  PABT20                58     60  0
031400101115
031500101115    ? * Program status data structure
031600101115    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
031700101115
031800000209   X***X
031900000210     C*
032000000210     C* MAIN CONTROL LOOP
032100000210     C*
032200000211    1C                   DOU       @STEP = 'EXIT  '
032300000211    2C     @STEP         CASEQ     'STEP1 '      $STEP1
032400000211    2C     @STEP         CASEQ     'STEP2 '      $STEP2
032500000211    2C     @STEP         CASEQ     'STEP3 '      $STEP3
032600000211    2C     @STEP         CASEQ     'STEP4 '      $STEP4
032700000216    2C     @STEP         CASEQ     'STEP5 '      $STEP5
032800000211    2C                   ENDCS
032900000211    1C                   ENDDO
033000000210     C                   MOVE      *ON           *INLR
033100000218     C*
033200000218     C* INITIAL SUBROUTINE
033300000210     C*
033400000211    SC     *INZSR        BEGSR
033500000210     C*
033600011009     C     *LIKE         DEFINE    PLTRST        VLTRST
033700011009     C     *LIKE         DEFINE    PLSUB#        VLSUB#
033800011009     C     *LIKE         DEFINE    PLPLAN        VLPLAN
033900000210     C     *LIKE         DEFINE    FRMDAT        #HLFRM
034000000210     C     *LIKE         DEFINE    TODAT         #HLTO
034100000210     C     *LIKE         DEFINE    FRMDAT        #FDATE
034200000210     C     *LIKE         DEFINE    TODAT         #TDATE
034300000211     C     *LIKE         DEFINE    AGEBND        #ABND
034400000211     C     *LIKE         DEFINE    TYPECD        @TYPE
034500000211     C     *LIKE         DEFINE    CODE          @CODE
034600000218     C     *LIKE         DEFINE    WFROM         #WFROM
034700000218     C     *LIKE         DEFINE    WTO           #WTO
034800000210     C*
034900011009     C     KEY#SUB       KLIST
035000011009     C                   KFLD                    VLTRST
035100011009     C                   KFLD                    VLSUB#
035200011009     C*
035300011009     C     KEY#PLAN      KLIST
035400011009     C                   KFLD                    VLTRST
035500011009     C                   KFLD                    VLSUB#
035600011009     C                   KFLD                    VLPLAN
035700110909     C     F8KEY         KLIST
035800110909     C                   KFLD                    VLTRST
035900110909     C                   KFLD                    VLSUB#
036000110909     C                   KFLD                    VLPLAN
036100110909     C                   KFLD                    WWDATE
036200011009     C*
036300000218     C                   MOVE      *ZERO         #8                8 0
036400000210     C                   MOVE      *ZERO         RRT               3 0
036500000211     C                   MOVE      *ZERO         RR2               3 0
036600000210     C                   MOVE      *ZEROS        #CNTREC           3 0
036700000210     C                   MOVE      *ZEROS        #BANDS            2 0
036800000210     C                   MOVE      *ZEROS        A                 2 0
036900000211     C                   MOVE      *ZEROS        #DLOOP            3 0
037000000211     C                   MOVE      *ZEROS        #BNDFLG           3 0
037100000211     C                   MOVE      *ZEROS        #O2CREC           3 0
037200000210     C*
037300000211     C                   MOVE      'T'           @T                1
037400000210     C                   MOVE      '0'           @1STLOOP          1
037500000210     C                   MOVE      *BLANKS       @EMSG            50
037600000210     C                   MOVE      'STEP1 '      @STEP             6
037700000211     C                   MOVE      '0'           @GC               1
037800000211     C                   MOVE      '0'           @ENF              1
037900000211     C                   MOVE      '0'           @ENT              1
038000000211     C                   MOVE      *BLANKS       @TS40            40
038100000210     C*
038200000210     C     G24FKY        KLIST
038300000210     C                   KFLD                    TRUST#
038400000210     C                   KFLD                    SUB#
038500000210     C                   KFLD                    PLANCD
038600000210     C                   KFLD                    #FDATE
038700000210     C                   KFLD                    #TDATE
038800000211     C     GXKEY         KLIST
038900000211     C                   KFLD                    TRUST#
039000000211     C                   KFLD                    SUB#
039100000211     C                   KFLD                    PLANCD
039200000211     C                   KFLD                    #ABND
039300000211     C                   KFLD                    @TYPE
039400000211     C                   KFLD                    #FDATE
039500000211     C                   KFLD                    #TDATE
039600000210     C     SUBKEY        KLIST
039700000210     C                   KFLD                    TRUST#
039800000210     C                   KFLD                    SUB#
039900000210     C     PLNKEY        KLIST
040000000210     C                   KFLD                    TRUST#
040100000210     C                   KFLD                    SUB#
040200000210     C                   KFLD                    PLANCD
040300000211     C     CODEKY        KLIST
040400000211     C                   KFLD                    @T
040500000211     C                   KFLD                    @CODE
040600100505     C*
040700100505     C     CLSKEY        KLIST
040800100505     C                   KFLD                    TRUST#
040900100505     C                   KFLD                    SUB#
041000100505     C                   KFLD                    PLANCD
041100100506     C                   KFLD                    TYPECD
041200000210     C*
041300000211    SC                   ENDSR
041400000210     C*
041500000210     C* INITIAL SCREEN FOR TRUST/SUB/PLAN
041600000210     C*
041700000211    SC     $STEP1        BEGSR
041800000210     C*
041900000210     C                   MOVEL(P)  @EMSG         SMSG
042000000210     C                   EXFMT     IO01
042100000210     C*
042200000210     C                   MOVE      *BLANKS       @EMSG
042300011009     C                   MOVE      *BLANKS       TNAME
042400011009     C                   MOVE      *BLANKS       SUBNAM
042500011009     C                   MOVE      *BLANKS       PDESCR
042600000210     C*
042700220201    1C                   IF        *IN07 = *on
042800000210     C                   MOVEL(P)  'EXIT  '      @STEP
042900000210     C                   LEAVESR
043000000211    1C                   ENDIF
043100030521     C*
043200220201    1C                   IF        *in09 = *on
043300030521     c                   call      'WRKTMPCL'
043400220201     C                   eval      *in09 = *off
043500030521     C                   LEAVESR
043600030521    1C                   ENDIF
043700181001     C
043800220201br01 C                   IF        *in10 = *on
043900181001 |   c                   call      'UTL200CL'
044000220201     C                   eval      *in10 = *off
044100181001 |   C                   LEAVESR
044200181001br01 C                   ENDIF
044300030521     C*
044400011009    *** TRUST SELECTOR
044500220201    1C                   IF        FKEY = *IN02
044600011009     C                   EXSR      $F2PROC
044700011009     C                   LEAVESR
044800011009    1C                   ENDIF
044900011009    *** SUB SELECTOR
045000220131    1C                   IF        FKEY = *IN04
045100011009     C                   EXSR      $F4PROC
045200011009     C                   LEAVESR
045300011009    1C                   ENDIF
045400011009    *** PLAN SELECTOR
045500220131    1C                   IF        FKEY = *IN06
045600011009     C                   EXSR      $F6PROC
045700011009     C                   LEAVESR
045800011009    1C                   ENDIF
045900011009    *** VALIDATIONS
046000011009     C                   Z-ADD     TRUST#        VLTRST
046100011009     C                   EXSR      $CHK_TRST
046200011009    1C                   IF        @@VT <> '0'
046300011009     C                   MOVEL(P)  MSG(25)       @EMSG
046400011009     C                   LEAVESR
046500011009    1C                   ENDIF
046600000210     C*
046700011009     C                   Z-ADD     SUB#          VLSUB#
046800011009     C                   EXSR      $CHK_SUBD
046900011009    1C                   IF        @@VS <> '0'
047000011009     C                   MOVEL(P)  MSG(1)        @EMSG
047100011009     C                   LEAVESR
047200011009    1C                   ENDIF
047300000210     C*
047400011009     C                   MOVEL(P)  PLANCD        VLPLAN
047500011009     C                   EXSR      $CHK_PLAN
047600011009    1C                   IF        @@VP <> '0'
047700011009     C                   MOVEL(P)  MSG(2)        @EMSG
047800011009     C                   LEAVESR
047900011009    1C                   ENDIF
048000011009    ***
048100000210     C                   MOVE      *ZEROS        #BANDS
048200000210     C                   MOVE      *ZEROS        A
048300011009    1C     1             DO        20            A
048400011009    2C                   IF        AFR(A) <> 0
048500000210     C                   ADD       1             #BANDS
048600011009    2C                   ENDIF
048700011009    1C                   ENDDO     1
048800000210     C*
048900000210     C                   MOVEL(P)  'STEP2 '      @STEP
049000000210     C                   MOVE      *BLANKS       @EMSG
049100000210     C*
049200000211    SC                   ENDSR
049300011009   S***S
049400011009    *** TRUST SELECTION WINDOW
049500011009     C     $F2PROC       BEGSR
049600220208    *
049700220208             Trust_Window(iTrust : iDescr : Cancel);
049800220208             if Cancel = *Blanks;
049900220208                @3     = %char(%editc(iTrust:'X'));
050000220208             endif;
050100220208    *
050200220208     C***                MOVE      *BLANKS       @3                3
050300220208     C***                CALL      'FM006CL'
050400220208     C***                PARM                    @3
050500220208    1C***                IF        @3 = '*LR'
050600220208     C***                MOVEL(P)  MSG(22)       @EMSG
050700220208     C***                LEAVESR
050800220208    1C***                ENDIF
050900011009    ***
051000220208     C                   MOVE      @3            TRUST#
051100011009    ***
051200011009     C                   MOVE      @3            VLTRST
051300011009     C                   EXSR      $CHK_TRST
051400011009    1C                   IF        @@VT <> '0'
051500011009     C                   MOVEL(P)  MSG(25)       @EMSG
051600011009    1C                   ENDIF
051700011009    ***
051800011009     C                   ENDSR
051900011009   S***S
052000011009    *** SUBDIVISION SELECTION WINDOW
052100011009    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
052200011009     C     $F4PROC       BEGSR
052300011009    ***
052400011009     C                   MOVE      *BLANKS       @6                6
052500011009     C*
052600011009     C                   Z-ADD     TRUST#        VLTRST
052700011009     C                   EXSR      $CHK_TRST
052800011009     C*
052900011009    1C                   IF        @@VT <> '0'
053000011009     C                   MOVEL(P)  MSG(25)       @EMSG
053100011009     C                   LEAVESR
053200011009    1C                   ENDIF
053300011009    ***
053400011009     C                   MOVE      VLTRST        @3                3
053500011009     C                   MOVEL(P)  @3            @6
053600220208     C***                CALL      'FM007CL'
053700220208     C***                PARM                    @6
053800220208
053900220208             Sub_Window(iTrust : iSub# : iDescr : Cancel);
054000220208             if Cancel = *Blanks;
054100220208                @3     = %char(%editc(iSub#:'X'));
054200220208             endif;
054300220208
054400220208
054500220208     C***                MOVE      @6            @3
054600011009    ***
054700011009    1C                   IF        @3 = '*LR'
054800011009     C                   MOVEL(P)  MSG(23)       @EMSG
054900011009     C                   LEAVESR
055000011009    1C                   ENDIF
055100011009    ***
055200011009     C                   MOVE      @3            SUB#
055300011009     C*
055400220208     C                   MOVE      @3            VLSUB#
055500011009     C                   EXSR      $CHK_SUBD
055600011009    1C                   IF        @@VS <> '0'
055700011009     C                   MOVEL(P)  MSG(1)        @EMSG
055800011009    1C                   ENDIF
055900011009    ***
056000011009     C                   ENDSR
056100011009   S***S
056200011009    *** EXISTING PLAN NUMBER INQUIRY
056300011009    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
056400011009     C     $F6PROC       BEGSR
056500011009    ***
056600011009     C                   MOVE      *BLANKS       @10              10
056700011009    ***
056800011009     C                   Z-ADD     TRUST#        VLTRST
056900011009     C                   EXSR      $CHK_TRST
057000011009     C*
057100011009    1C                   IF        @@VT <> '0'
057200011009     C                   MOVEL(P)  MSG(25)       @EMSG
057300011009     C                   LEAVESR
057400011009    1C                   ENDIF
057500011009    ***
057600011009     C                   Z-ADD     SUB#          VLSUB#
057700011009     C                   EXSR      $CHK_SUBD
057800011009     C*
057900011009    1C                   IF        @@VS <> '0'
058000011009     C                   MOVEL(P)  MSG(1)        @EMSG
058100011009     C                   LEAVESR
058200011009    1C                   ENDIF
058300011009    ***
058400011009     C                   MOVE      VLTRST        @3
058500011009     C                   MOVEL(P)  @3            @10
058600011009     C                   MOVE      VLSUB#        @3
058700011009     C                   CAT       @3:0          @10
058800220208     C***                CALL      'FM004CL'
058900220208     C****               PARM                    @10
059000220208     C***  4             SUBST     @10:7         @4                4
059100220208
059200220208             iTrust = Trust#;
059300220208             iSub# = Sub#;
059400220208             iAcct = 0;
059500220208             Pln_Window(iTrust : iSub# : iAcct : iPlan : Cancel : Iclass);
059600220208             if Cancel = *Blanks;
059700220208                @4     = %char(iPlan);
059800220208             endif;
059900220208    *
060000011009    1C                   IF        @4 = '*LR '
060100011009     C                   MOVEL(P)  MSG(24)       @EMSG
060200011009     C                   LEAVESR
060300011009    1C                   ENDIF
060400011009    ***
060500011009     C                   MOVEL(P)  @4            PLANCD
060600011009    ***
060700011009     C                   MOVEL(P)  @4            VLPLAN
060800011009     C                   EXSR      $CHK_PLAN
060900011009    1C                   IF        @@VP <> '0'
061000011009     C                   MOVEL(P)  MSG(2)        @EMSG
061100011009    1C                   ENDIF
061200011009    ***
061300011009     C                   ENDSR
061400011009   S***S
061500011009     C     $CHK_TRST     BEGSR
061600011009    ***
061700011009     C                   MOVE      '1'           @@VT              1
061800011009    1C                   IF        VLTRST <> 0
061900150402     C     VLTRST        CHAIN(N)  TRSMSR
062000011009    2C                   IF        %FOUND(TRSMST)
062100011009     C                   MOVE      '0'           @@VT
062200011009    2C                   ENDIF
062300011009    1C                   ENDIF
062400011009    ***
062500011009     C                   ENDSR
062600011009   S***S
062700011009     C     $CHK_SUBD     BEGSR
062800011009    ***
062900011009     C                   MOVE      '1'           @@VS              1
063000011009    1C                   IF        VLSUB# <> 0
063100150402     C     KEY#SUB       CHAIN(N)  SUBMSR
063200011009    2C                   IF        %FOUND(SUBMST)
063300011009     C                   MOVE      '0'           @@VS
063400011009    2C                   ENDIF
063500011009    1C                   ENDIF
063600011009    ***
063700011009     C                   ENDSR
063800011009   S***S
063900011009     C     $CHK_PLAN     BEGSR
064000101115     c                   eval      *in80 = *off
064100110909     c                   eval      *in81 = *off
064200150312     c                   eval      *in82 = *off
064300150312     c                   eval      *in83 = *off
064400150622
064500150622     C                   eval      ANCFLG = ' '
064600150622     C     KEY#PLAN      CHAIN     PLNMST
064700150622     C                   If        %found(plnmst)
064800150622     C                   Movel     PLNCAT        TYPE
064900150622     C                   Move      PLNCAT        CODE
065000150622     C     KEYCOD        Chain     CODES
065100150622     C                   If        %found(codes)
065200150622     C                   select
065300150622     C                   when      %trim(action) = 'M' or
065400180103     C                             %trim(action) = 'D' or
065500180103     C                             %trim(action) = 'V' or
065600180103     C                             %trim(action) = 'W'
065700150622     C                   eval      ANCFLG = 'N'
065800200311     C                   when      %trim(action) = 'X'
065900200303     C                   eval      ANCFLG = 'N'
066000150622     C                   Endsl
066100150622     C                   End
066200150622     C                   End
066300150622
066400101115    ***
066500101115    *** Payroll Deduction Security
066600150402     C     WQUSRN        Chain     WEBPAYSEC
066700101115     C                   If        not %found(WEBPAYSEC)
066800101115     c                   eval      *in81 = *off
066900101115     C                   Else
067000101115     c                   eval      *in81 = *on
067100101115     C                   End
067200150622    ***
067300150622    *C                   If        ANCFLG = 'N'
067400150312    *** Highlight F8=PayDed$ or F9PayDed%
067500220208     C                   eval      WF8KEY = 'PayDed $'
067600220208     C                   eval      WF9KEY = 'PayDed %'
067700220302     C                   eval      W89 = '89'
067800110909     C     FRDATE        Mult      10000.0001    WWDATE
067900110912     C     F8KEY         Setll     PAYDED
068000150312    2C     F8KEY         Reade     PAYDED
068100150312     C                   dow       not %eof(PAYDED)
068200150312     C                   If        PDTRMD = 0
068300150312     C                   Select
068400150506     C                   when      PD$AMT <> 0  or
068500150506     C                             PDDAMT <> 0
068600110909     C                   eval      *in82 = *on
068700220208     C                   eval      W89 = 'F8'
068800150312     C                   when      PDPAMT <> 0  or
068900150506     C                             PDPDEP <> 0
069000150312     C                   eval      *in83 = *on
069100220208     C                   eval      W89 = 'F9'
069200180103     C                   when      %trim(VLPLAN) = 'HRA1'
069300180103     C                   eval      *in82 = *on
069400220208     C                   eval      W89 = 'F8'
069500150312     C                   Endsl
069600150312     C                   End
069700150312    2C     F8KEY         Reade     PAYDED
069800150622     C                   Enddo
069900150622     C                   End
070000150312
070100150622    *C                   If        ANCFLG <> 'N'
070200220208     C                   eval      WF8KEY = 'Ancillary'
070300220208     C                   eval      WF9KEY = 'Ancillary'
070400220302     C*** test           eval      W89 = 'F9'
070500150312     C     F8KEY         Setll     PAYDEDANP
070600150312     C     F8KEY         Reade     PAYDEDANP
070700150312    2C                   dow       not %eof(PAYDEDANP)
070800150312     C                   If        PATRMD = 0
070900150312     C                   Select
071000150313     C                   when      PAFORM <> *blanks
071100150312     C                   eval      *in82 = *on
071200220208     C                   eval      W89 = 'F9'
071300150312     C                   when      PAPAMT <> 0  or
071400150424     C                             PAPDEP <> 0  or
071500150424     C                             PAEAMT <> 0  or
071600150424     C                             PADAMT <> 0
071700150312     C                   eval      *in83 = *on
071800220208     C                   eval      W89 = 'F9'
071900150312     C                   Endsl
072000150312     C                   End
072100150312    2C     F8KEY         Reade     PAYDEDANP
072200150622     C                   Enddo
072300150622     C                   End
072400011009    ***
072500011009     C                   MOVE      '1'           @@VP              1
072600011009    1C                   IF        VLPLAN <> *BLANKS
072700150402     C     KEY#PLAN      CHAIN     PLNMSR
072800011009    2C                   IF        %FOUND(PLNMST)
072900011009     C                   MOVE      '0'           @@VP
073000021023     c                   clear                   delbil
073100021023     c     pcarr         chain     carmst
073200021023     c                   IF        %found(carmst) and carbc = 'D'
073300021023     c                   move      'Y'           delbil            1
073400021024     c                   eval      *in80 = *on
073500021023     c                   end
073600011009    2C                   ENDIF
073700011009    1C                   ENDIF
073800140409    ***
073900140409     C                   MOVE      *BLANKS       ACAPLAN          11
074000140409     C                   EVAL      ACAPLAN = %EDITC(PLTRST:'X') +
074100140409     C                             %EDITC(PLSUB#:'X') + PLPLAN + 'N'
074200140409     C                   CALL      'ACAPLNCHKC'
074300140409     C                   PARM                    ACAPLAN
074400011009    ***
074500150622    *C                   If        ANCFLG = 'N'
074600150622     C                   eval      *in82 = *on
074700220208     C                   eval      W89 = 'F8'
074800150622     C                   eval      *in83 = *off
074900150622     C                   End
075000150622    ***
075100011009     C                   ENDSR
075200011009   S***S
075300000210     C* INITIAL SCREEN FOR TRUST/SUB/PLAN
075400000210     C*
075500000211    SC     $STEP2        BEGSR
075600000210     C* CLEAR SFL
075700000210     C                   MOVEA     '011'         *IN(25)
075800000210     C                   WRITE     IO03C
075900000210     C                   MOVEA     '010'         *IN(25)
076000000210     C* SFL BUILD
076100000210     C*    CLEAR COUNTERS; LOAD ONLY THOSE RECORDS FOR A TRUST/SUB/PLAN
076200000210     C*    ONCE FOR EACH FROM/TO DATE RANGE. DO NOT EXCEED 100 RECORDS.
076300000210     C*
076400000210     C                   Z-ADD     *ZERO         RRT
076500000210     C                   MOVE      *ZEROS        #CNTREC
076600000210     C                   MOVE      '0'           @1STLOOP
076700000210     C                   MOVE      *ZEROS        #HLFRM
076800000210     C                   MOVE      *ZEROS        #HLTO
076900000210     C*
077000000210     C     PLNKEY        SETLL     G24
077100000211    1C                   DOU       %EOF(GRAT24)
077200021002     C     PLNKEY        READE(N)  G24
077300000211    2C                   IF        NOT %EOF(GRAT24) OR #CNTREC = 100
077400000210     C*
077500000211    3C                   IF        FRMDAT <> #HLFRM OR TODAT <> #HLTO
077600000210     C                   Z-ADD     FRMDAT        #HLFRM
077700000210     C                   Z-ADD     TODAT         #HLTO
077800000210     C                   ADD       1             #CNTREC
077900000210     C                   MOVE      *ON           *IN25
078000000210     C                   MOVE      *BLANKS       SEL03
078100001018     C                   MOVE      FRMDAT        #ISO
078200001018     C                   MOVE      #ISO          #USA
078300001018     C                   MOVE      #USA          FRM03
078400001018     C                   MOVE      TODAT         #ISO
078500001018     C                   MOVE      #ISO          #USA
078600001018     C                   MOVE      #USA          TOD03
078700000210     C*
078800000210     C                   ADD       1             RRT
078900000211    4C                   IF        @1STLOOP = '0'
079000000210     C                   Z-ADD     RRT           SFLPOS
079100000210     C                   MOVE      '1'           @1STLOOP
079200000211    4C                   ENDIF
079300000210     C                   WRITE     IO03S
079400000211    3C                   ENDIF
079500000210     C*
079600000211    2C                   ENDIF
079700000211    1C                   ENDDO
079800000210     C*
079900000210     C                   MOVEL(P)  'STEP3 '      @STEP
080000000210     C                   MOVE      *BLANKS       @EMSG
080100000210     C*
080200000211    SC                   ENDSR
080300000218     C*
080400000218     C* SELECT DATE RANGE TO PROCESS OR CHANGE THE DATES OF THE DATE RANGE;
080500000218     C* WHICH WILL AFFECT ALL AGE BANDS/TYPES FOR THAT RANGE.
080600000218     C*
080700000211    SC     $STEP3        BEGSR
080800000210     C*
080900000210     C                   MOVEL(P)  @EMSG         SMSG
081000001107     C                   MOVE      'N'           @AUTO
081100000210     C*
081200000210     C                   WRITE     IO03R
081300000210     C                   EXFMT     IO03C
081400000210     C*
081500000210     C                   MOVE      *BLANKS       @EMSG
081600000210     C*
081700000211    1C                   SELECT
081800000210     C*
081900000210     C* BACK TO INITIAL SCREEN
082000000210     C*
082100220201    1C                   WHEN      *IN01 = *ON
082200000210     C                   MOVEL(P)  'STEP1 '      @STEP
082300000210     C                   LEAVESR
082400000216     C*
082500000216     C* HISTORY INQUIRY
082600000216     C*
082700220201    1C                   WHEN      *IN04 = *ON
082800000216     C                   MOVEL(P)  '0000000000'  @PARM
082900000216     C                   Z-ADD     TRTRST        #TRSTN
083000000216     C                   MOVEL(P)  TNAME         @TRNAM
083100000216     C                   Z-ADD     SBSUB#        #SUBNO
083200000216     C                   MOVEL(P)  SUBNAM        @SBNAM
083300000216     C                   MOVEL(P)  PLPLAN        @PLNCD
083400000216     C                   MOVEL(P)  PDESCR        @PCNAM
083500000216     C                   MOVEL(P)  @PARM         @52              52
083600000216     C                   CALL      'FM041R'
083700000216     C                   PARM                    @52
083800000216     C                   LEAVESR
083900000210     C*
084000000210     C* EXIT OUT OF APPLICATION
084100000210     C*
084200220201    1C                   WHEN      *IN07 = *ON
084300000210     C                   MOVEL(P)  'EXIT  '      @STEP
084400000210     C                   LEAVESR
084500000210     C*
084600000210     C* ADD A NEW DATE RANGE [WILL EXIT TO STEP2 TO REBUILD]
084700000210     C*
084800220201    1C                   WHEN      *IN11 = *ON
084900000210     C                   EXSR      $ADDREC
085000000210     C*
085100000210     C* CHECK SELECTIONS
085200000210     C*
085300000211    1C                   OTHER
085400000210     C                   EXSR      $CHKSELC
085500000210     C*
085600000211    1C                   ENDSL
085700000210     C*
085800000211    SC                   ENDSR
085900000218     C*
086000000218     C* ADD A DATE RANGE; THEN TRANSFER CONTROL BACK TO STEP2 FOR REBUILD
086100000210     C*
086200000211    SC     $ADDREC       BEGSR
086300000210     C*
086400000210     C                   MOVE      '0'           @GC
086500000210     C*
086600220201    1C                   DOU       FKEY = *IN01 OR @GC = '1'
086700000210     C*
086800000210     C                   MOVE      @EMSG         WMSG
086900000210     C                   EXFMT     IO03W
087000000210     C                   MOVE      *BLANKS       @EMSG
087100000210     C*
087200220201    2C                   IF        *IN01 = *ON
087300000210     C                   LEAVESR
087400000211    2C                   ENDIF
087500000210     C*
087600001018     C                   EXSR      $VALADD
087700001018     C*
087800001018    2C                   IF        @EMSG = *BLANKS
087900000218     C                   Z-ADD     #WFROM        #FDATE
088000000218     C                   Z-ADD     #WTO          #TDATE
088100150402     C     G24FKY        CHAIN(N)  G24
088200000211    3C                   IF        %FOUND(GRAT24)
088300000210     C                   MOVEL(P)  MSG(17)       @EMSG
088400000211    3C                   ENDIF
088500001024     C*
088600001024    2C                   IF        @EMSG = *BLANKS
088700001024     C     PLNKEY        SETLL     G24
088800001024    3C                   DOU       %EOF(GRAT24)
088900021002     C     PLNKEY        READE(N)  G24
089000001024    4C                   IF        NOT %EOF(GRAT24)
089100001024    5C                   SELECT
089200001024    5C                   WHEN      #WFROM > FRMDAT AND #WFROM < TODAT
089300001024     C                   MOVEL(P)  MSG(18)       @EMSG
089400001024    5C                   WHEN      #WTO > FRMDAT AND #WTO < TODAT
089500001024     C                   MOVEL(P)  MSG(19)       @EMSG
089600001024    5C                   WHEN      #WTO > FRMDAT AND #WFROM < FRMDAT
089700001024     C                   MOVEL(P)  MSG(20)       @EMSG
089800001024    5C                   ENDSL
089900001024    4C                   ENDIF
090000001024    3C                   ENDDO
090100001024    2C                   ENDIF
090200000210     C*
090300001018    2C                   ENDIF
090400000210     C*
090500000211    2C                   IF        @EMSG = *BLANKS
090600001107     C                   MOVE      'Y'           @AUTO
090700000216     C                   Z-ADD     WFROM         FRDATE
090800000216     C                   Z-ADD     WTO           TODATE
090900000210     C                   MOVEL(P)  'STEP4 '      @STEP
091000000210     C                   MOVE      '1'           @GC
091100000211    2C                   ENDIF
091200000210     C*
091300000211    1C                   ENDDO
091400000210     C*
091500000211    SC                   ENDSR
091600001018   S***S
091700001018    SC     $VALADD       BEGSR
091800001018     C*
091900001018     C                   IF        WFROM = 0
092000001018     C                   MOVEL(P)  MSG(18)       @EMSG
092100001018     C                   LEAVESR
092200001018     C                   ENDIF
092300001018     C*
092400001018     C                   IF        WTO = 0
092500001018     C                   MOVEL(P)  MSG(19)       @EMSG
092600001018     C                   LEAVESR
092700001018     C                   ENDIF
092800001018     C*
092900001018     C     *USA          TEST (DE)               WFROM
093000001019     C                   IF        %ERROR
093100001018     C                   MOVEL(P)  MSG(18)       @EMSG
093200001018     C                   LEAVESR
093300001018     C                   ENDIF
093400001018     C*
093500001018     C     *USA          TEST (DE)               WTO
093600001019     C                   IF        %ERROR
093700001018     C                   MOVEL(P)  MSG(19)       @EMSG
093800001018     C                   LEAVESR
093900001018     C                   ENDIF
094000001018     C*
094100001019     C                   MOVE      WFROM         #USA
094200001019     C                   MOVE      #USA          #ISO
094300001019     C                   MOVE      #ISO          #WFROM
094400001019     C*
094500001019     C                   MOVE      WTO           #USA
094600001019     C                   MOVE      #USA          #ISO
094700001019     C                   MOVE      #ISO          #WTO
094800001019     C*
094900001019     C                   IF        #WTO < #WFROM
095000001018     C                   MOVEL(P)  MSG(19)       @EMSG
095100001019     C                   ENDIF
095200001018     C*
095300001018    SC                   ENDSR
095400001018   S***S
095500000218     C*
095600000218     C* CHECK SUBFILE FOR SELECTION OF DATE RANGE
095700000210     C*
095800000216    SC     $CHKSELC      BEGSR
095900000216     C*
096000000216     C                   MOVE      *OFF          *IN33
096100000216    1C                   DOU       *IN33 = *ON OR @EMSG <> *BLANKS
096200000216     C                   READC     IO03S                                  33
096300000216    2C                   IF        *IN33 = *OFF
096400000216     C*
096500001019    3C                   IF        SEL03 <> *BLANKS AND FRM03 <> 0
096600001019     C                   MOVE      FRM03         #USA
096700001019     C                   MOVE      #USA          #ISO
096800001019     C                   MOVE      #ISO          #F03ISO
096900001019     C                   MOVE      TOD03         #USA
097000001019     C                   MOVE      #USA          #ISO
097100001019     C                   MOVE      #ISO          #T03ISO
097200001019     C*
097300000920    4C                   SELECT
097400000920     C*
097500000920    4C                   WHEN      SEL03 = 'C'
097600000216     C                   EXSR      $CHGRECS
097700000920     C*
097800000920    4C                   WHEN      SEL03 = 'X'
097900000920     C                   MOVE      '1'           @GC
098000000920     C                   MOVEL(P)  'STEP4'       @STEP
098100001019     C                   Z-ADD     #F03ISO       #FDATE
098200001019     C                   Z-ADD     #T03ISO       #TDATE
098300000920     C                   Z-ADD     FRM03         FRDATE
098400000920     C                   Z-ADD     TOD03         TODATE
098500000920     C                   LEAVESR
098600000216     C*
098700000920    4C                   OTHER
098800000216     C                   MOVEL(P)  MSG(15)       @EMSG
098900000216     C*
099000000920    4C                   ENDSL
099100000216    3C                   ENDIF
099200001019     C                   MOVE      *BLANKS       SEL03
099300001019     C                   UPDATE    IO03S
099400000216     C*
099500000216    2C                   ENDIF
099600000216     C*
099700000216    1C                   ENDDO
099800000216     C*
099900000216    SC                   ENDSR
100000000218     C*
100100000218     C* CHANGE FROM &/OR TO DATES OF SELECT DATE RANGE
100200000216     C*
100300000216    SC     $CHGRECS      BEGSR
100400000216     C*
100500000216     C                   MOVE      '0'           @GC
100600001019     C                   Z-ADD     FRM03         OLDFDT
100700001019     C                   Z-ADD     TOD03         OLDTDT
100800001019     C                   Z-ADD     FRM03         NEWFDT
100900001019     C                   Z-ADD     TOD03         NEWTDT
101000000216     C*
101100220201    1C                   DOU       FKEY = *IN01 OR @GC = '1'
101200000216     C*
101300000216     C                   MOVE      @EMSG         SMSG
101400000216     C                   EXFMT     IO05
101500000216     C                   MOVE      *BLANKS       @EMSG
101600000216     C*
101700220216    2C                   IF        *IN01 = *on
101800000216     C                   LEAVESR
101900000216    2C                   ENDIF
102000000216     C*
102100220216    2C                   IF        *IN05 = *on
102200000216     C                   MOVE      '1'           @GC
102300000216     C                   MOVEL(P)  'STEP4'       @STEP
102400001019     C                   Z-ADD     #F03ISO       #FDATE
102500001019     C                   Z-ADD     #T03ISO       #TDATE
102600001019     C                   Z-ADD     FRM03         FRDATE
102700001019     C                   Z-ADD     TOD03         TODATE
102800000216     C                   LEAVESR
102900000216    2C                   ENDIF
103000000216     C*
103100000216    2C                   IF        NEWFDT <> OLDFDT OR NEWTDT <> OLDTDT
103200000216     C*
103300000216     C                   EXSR      $DATEVLD
103400000216     C*
103500000216    3C                   SELECT
103600000216     C*
103700000216    3C                   WHEN      @ENF = '1'
103800000216     C                   MOVEL(P)  MSG(11)       @EMSG
103900000216     C*
104000000216    3C                   WHEN      @ENF = '2'
104100000216     C                   MOVEL(P)  MSG(12)       @EMSG
104200000216     C*
104300000216    3C                   WHEN      @ENT = '1'
104400000216     C                   MOVEL(P)  MSG(13)       @EMSG
104500000216     C*
104600000216    3C                   WHEN      @ENT = '2'
104700000216     C                   MOVEL(P)  MSG(14)       @EMSG
104800000216     C*
104900000216    3C                   ENDSL
105000000216     C*
105100000216    3C                   IF        @EMSG = *BLANKS
105200000216     C*
105300001019     C                   MOVE      NEWFDT        #USA
105400001019     C                   MOVE      #USA          #ISO
105500001019     C                   MOVE      #ISO          #NKFISO
105600001019     C                   MOVE      NEWTDT        #USA
105700001019     C                   MOVE      #USA          #ISO
105800001019     C                   MOVE      #ISO          #NKTISO
105900001019     C                   Z-ADD     #NKFISO       #FDATE
106000001019     C                   Z-ADD     #NKTISO       #TDATE
106100000216     C*
106200000216     C     G24FKY        CHAIN     G24
106300000216    4C                   IF        %FOUND(GRAT24)
106400000216     C                   MOVEL(P)  MSG(17)       @EMSG
106500000216    4C                   ELSE
106600151109      *
106700151109     C                   Z-ADD     #F03ISO       #FDATE
106800001019     C                   Z-ADD     #T03ISO       #TDATE
106900000216     C     G24FKY        SETLL     G24
107000000216    5C                   DOU       %EOF(GRAT24)
107100000216     C     G24FKY        READE     G24
107200151109    6C                   IF        NOT %EOF(GRAT24)
107300151109      *
107400000216     C                   EXSR      $SETJRN
107500001019     C                   MOVE      FRMDAT        HFBFFRDT
107600001019     C                   MOVE      TODAT         HFBFTODT
107700001019     C                   MOVE      AGEBND        HFBFAGBN
107800001019     C                   MOVE      GRDLTD        HFBFDLTC
107900001019     C                   MOVEL     TYPECD        HFBFTYCD
108000001019     C                   MOVE      BILRTE        HFBFBILR
108100001019     C                   MOVE      NETRTE        HFBFNETR
108200001019     C                   MOVEL     GROUP#        HFBFGRP#
108300001019     C                   Z-ADD     #NKFISO       HFAFFRDT
108400001019     C                   Z-ADD     #NKTISO       HFAFTODT
108500001019     C                   MOVE      AGEBND        HFAFAGBN
108600001019     C                   MOVE      GRDLTD        HFAFDLTC
108700001019     C                   MOVEL     TYPECD        HFAFTYCD
108800001019     C                   MOVE      BILRTE        HFAFBILR
108900001019     C                   MOVE      NETRTE        HFAFNETR
109000001019     C                   MOVEL     GROUP#        HFAFGRP#
109100000216     C                   WRITE     RGRTHIST
109200111012     C                   Exsr      RateAlert
109300000216     C*
109400001019     C                   Z-ADD     #NKFISO       FRMDAT
109500001019     C                   Z-ADD     #NKTISO       TODAT
109600200221     C                   UPDATE    G24
109700200221       exsr updateUHC;
109800000216     C*
109900000216    6C                   ENDIF
110000000216    5C                   ENDDO
110100110415     C*
110200110415     C* What Changed?
110300110415     C                   Eval      CHGDAT = ' '
110400110415     C                   Select
110500110415    2C                   When      NEWFDT <> OLDFDT  and
110600110415    2C                             NEWTDT <> OLDTDT
110700110415     C                   Eval      CHGDAT = 'B'
110800110415    2C                   When      NEWFDT <> OLDFDT
110900110415     C                   Eval      CHGDAT = 'F'
111000110415    2C                   When      NEWTDT <> OLDTDT
111100110415     C                   Eval      CHGDAT = 'T'
111200110415     C                   Endsl
111300120127     C*
111400120127     C     *date         Mult      10000.0001    Today
111500110415     C* Change Payroll Deductions F/T Dates
111600110415     C     G24FKY        Setll     PAYDED
111700110415     C     G24FKY        Reade     PAYDED
111800110415    5C                   Dow       not %eof(PAYDED)
111900110415     C                   Select
112000110415     C                   When      CHGDAT = 'B'
112100131021     C                   Eval      PDTRMD = Today
112200131021     C                   Eval      PDTRMU = WQUSRN
112300120127     C                   Update    PAYDEDR
112400120127     C                   Eval      PDBEDT = #NKFISO
112500120127     C                   Eval      PDENDT = #NKTISO
112600120127     C                   Eval      PDTRMD = *zero
112700120127     C                   Eval      PDTRMU = *blanks
112800110415     C                   Write     PAYDEDR
112900110415     C                   When      CHGDAT = 'F'
113000131021     C                   Eval      PDTRMD = Today
113100131021     C                   Eval      PDTRMU = WQUSRN
113200120127     C                   Update    PAYDEDR
113300120127     C                   Eval      PDBEDT = #NKFISO
113400120127     C                   Eval      PDENDT = #NKTISO
113500120127     C                   Eval      PDTRMD = *zero
113600120127     C                   Eval      PDTRMU = *blanks
113700110415     C                   Write     PAYDEDR
113800110415     C                   When      CHGDAT = 'T'
113900120127     C                   Eval      PDBEDT = #NKFISO
114000120127     C                   Eval      PDENDT = #NKTISO
114100110415     C                   Update    PAYDEDR
114200110415     C                   Endsl
114300110415     C     G24FKY        Reade     PAYDED
114400110415     C                   Enddo
114500110415     C*
114600110415     C     G24FKY        Setll     PAYDEDANP
114700110415     C     G24FKY        Reade     PAYDEDANP
114800110415    5C                   Dow       not %eof(PAYDEDANP)
114900110415     C                   Select
115000110415     C                   When      CHGDAT = 'B'
115100120127     C                   Eval      PATRMD = Today
115200120127     C                   Eval      PATRMU = WQUSRN
115300120127     C                   Update    PAYDEDANR
115400120127     C                   Eval      PABEDT = #NKFISO
115500120127     C                   Eval      PAENDT = #NKTISO
115600120127     C                   Eval      PATRMD = *zero
115700120127     C                   Eval      PATRMU = *blanks
115800110415     C                   Write     PAYDEDANR
115900110415     C                   When      CHGDAT = 'F'
116000131021     C                   Eval      PATRMD = Today
116100131021     C                   Eval      PATRMU = WQUSRN
116200120127     C                   Update    PAYDEDANR
116300120127     C                   Eval      PABEDT = #NKFISO
116400120127     C                   Eval      PAENDT = #NKTISO
116500120127     C                   Eval      PATRMD = *zero
116600120127     C                   Eval      PATRMU = *blanks
116700110415     C                   Write     PAYDEDANR
116800110415     C                   When      CHGDAT = 'T'
116900120127     C                   Eval      PABEDT = #NKFISO
117000120127     C                   Eval      PAENDT = #NKTISO
117100110415     C                   Update    PAYDEDANR
117200110415     C                   Endsl
117300110415     C     G24FKY        Reade     PAYDEDANP
117400110415     C                   Enddo
117500000216     C*
117600000216     C                   Z-ADD     NEWFDT        FRDATE
117700000216     C                   Z-ADD     NEWTDT        TODATE
117800001019     C                   Z-ADD     #NKFISO       #FDATE
117900001019     C                   Z-ADD     #NKTISO       #TDATE
118000000216     C                   MOVE      '1'           @GC
118100000216     C                   MOVEL(P)  'STEP4'       @STEP
118200000216     C*
118300000216    4C                   ENDIF
118400000216     C*
118500000216    3C                   ENDIF
118600000216     C*
118700000216    2C                   ENDIF
118800040723     C*
118900040723     C*                  EXSR      $MKTSZSR
119000000216     C*
119100000216    1C                   ENDDO
119200000216     C*
119300000216    SC                   ENDSR
119400000216     C*
119500000218     C* VALIDATE INPUTTED DATE
119600000218     C*
119700000216    SC     $DATEVLD      BEGSR
119800000216     C*
119900000216     C                   MOVE      '0'           @ENF
120000000216     C                   MOVE      '0'           @ENT
120100001019     C*
120200001019     C                   IF        NEWFDT <> 0
120300001019     C     *USA          TEST (ED)               NEWFDT
120400001019     C                   IF        %ERROR
120500001019     C                   MOVE      '1'           @ENF
120600001019     C                   LEAVESR
120700001019     C                   ENDIF
120800001019     C                   ENDIF
120900001019     C*
121000001019     C                   IF        NEWTDT <> 0
121100001019     C     *USA          TEST (ED)               NEWTDT
121200001019     C                   IF        %ERROR
121300001019     C                   MOVE      '1'           @ENT
121400001019     C                   LEAVESR
121500001019     C                   ENDIF
121600001019     C                   ENDIF
121700001019     C*
121800000218     C     NEWFDT        MULT      10000.0001    #8
121900000218     C                   MOVE      #8            #CYMDF
122000000218     C     NEWTDT        MULT      10000.0001    #8
122100000218     C                   MOVE      #8            #CYMDT
122200000216     C*
122300000216    1C                   SELECT
122400000216     C*
122500000216    1C                   WHEN      NEWFDT = 0
122600000216     C                   MOVE      '1'           @ENF
122700000216     C                   LEAVESR
122800000216     C*
122900000216    1C                   WHEN      #CYF > 2100 AND #CYF < 1900
123000000216     C                   MOVE      '1'           @ENF
123100000216     C                   LEAVESR
123200000216     C*
123300000216    1C                   WHEN      #MF < 1  AND #MF > 12
123400000216     C                   MOVE      '1'           @ENF
123500000216     C                   LEAVESR
123600000216     C*
123700000216    1C                   WHEN      #DF <> 01
123800000216     C                   MOVE      '2'           @ENF
123900000216     C                   LEAVESR
124000000216     C*
124100000216    1C                   WHEN      NEWTDT = 0
124200000216     C                   MOVE      '1'           @ENT
124300000216     C                   LEAVESR
124400000216     C*
124500000216    1C                   WHEN      #CYT > 2100 AND #CYT < 1900
124600000216     C                   MOVE      '1'           @ENT
124700000216     C                   LEAVESR
124800000216     C*
124900000216    1C                   WHEN      #MT < 1  AND #MT > 12
125000000216     C                   MOVE      '1'           @ENT
125100000216     C                   LEAVESR
125200000216     C*
125300001205    1C                   WHEN      #DT < DOM(#MT)
125400000216     C                   MOVE      '2'           @ENT
125500000216     C                   LEAVESR
125600000216     C*
125700000216    1C                   WHEN      #CYMDT < #CYMDF
125800000216     C                   MOVE      '1'           @ENT
125900000216     C                   LEAVESR
126000000216     C*
126100000216    1C                   ENDSL
126200000216     C*
126300000216    SC                   ENDSR
126400000218     C*
126500000218     C* BUILD RATES MAINTENANCE SCREEN SUBFILE
126600000216     C*
126700000211    SC     $STEP4        BEGSR
126800000210     C*
126900000210     C* BUILD SUBFILE FOR RATES
127000000210     C*
127100000210     C                   MOVE      *BLANKS       @EMSG
127200000210     C                   MOVE      *BLANKS       SMSG
127300000211     C                   MOVE      *ZEROS        A
127400000210     C                   MOVE      *ZEROS        #BNDFLG
127500000210     C*
127600000210     C* CLEAR SUBFILE
127700110909     c                   eval      *in80 = *off
127800110909     c                   eval      *in81 = *off
127900150312     c                   eval      *in82 = *off
128000150312     c                   eval      *in83 = *off
128100110909    ***
128200110909    *** Payroll Deduction Security
128300110909     C     WQUSRN        Chain     WEBPAYSEC
128400110909     C                   If        not %found(WEBPAYSEC)
128500110909     c                   eval      *in81 = *off
128600110909     C                   Else
128700110909     c                   eval      *in81 = *on
128800110909     C                   End
128900000210     C*
129000150312    *** Highlight F8=PayDed$ or F9PayDed%
129100220302     C                   eval      W89 = '89'
129200150312     C     FRDATE        Mult      10000.0001    WWDATE
129300150312     C     F8KEY         Setll     PAYDED
129400150312    2C     F8KEY         Reade     PAYDED
129500150312     C                   dow       not %eof(PAYDED)
129600150312     C                   If        PDTRMD = 0
129700150312     C                   Select
129800150506     C                   when      PD$AMT <> 0  or
129900150506     C                             PDDAMT <> 0
130000150312     C                   eval      *in82 = *on
130100220208     C                   eval      W89 = 'F8'
130200220322     C                   eval      WF8KEY = 'PayDed $'
130300150312     C                   when      PDPAMT <> 0  or
130400150506     C                             PDPDEP <> 0
130500150312     C                   eval      *in83 = *on
130600220208     C                   eval      W89 = 'F9'
130700220322     C                   eval      WF9KEY = 'PayDed %'
130800180103     C                   when      %trim(VLPLAN) = 'HRA1'
130900180103     C                   eval      *in82 = *on
131000220208     C                   eval      W89 = 'F8'
131100150312     C                   Endsl
131200150312     C                   End
131300150312    2C     F8KEY         Reade     PAYDED
131400150312     C                   Enddo
131500150312
131600150312     C     F8KEY         Setll     PAYDEDANP
131700150312     C     F8KEY         Reade     PAYDEDANP
131800150312    2C                   dow       not %eof(PAYDEDANP)
131900150312     C                   If        PATRMD = 0
132000150312     C                   Select
132100150313     C                   when      PAFORM <> *blanks
132200150312     C                   eval      *in82 = *on
132300220208     C                   eval      W89 = 'F9'
132400150312     C                   when      PAPAMT <> 0  or
132500150424     C                             PAPDEP <> 0  or
132600150424     C                             PAEAMT <> 0  or
132700150424     C                             PADAMT <> 0
132800150312     C                   eval      *in83 = *on
132900220208     C                   eval      W89 = 'F9'
133000150312     C                   Endsl
133100150312     C                   End
133200150312    2C     F8KEY         Reade     PAYDEDANP
133300150312     C                   Enddo
133400150312    ***
133500000210     C                   MOVEA     '011'         *IN(28)
133600000210     C                   WRITE     IO02C
133700000210     C                   MOVEA     '010'         *IN(28)
133800000210     C*
133900000210     C* BUILD SUBFILE
134000000210     C*
134100000210     C                   Z-ADD     *ZERO         RR2
134200000210     C                   MOVE      *ZEROS        #O2CREC
134300000210     C                   MOVE      '0'           @1STLOOP
134400151109      *       Set Cov Type seq correctly IN, PC, P2, HW, FA, MI
134500151109     C                   eval      nxttyp = 'AAA'
134600151109      *
134700151109     C                   dou       nxttyp = 'XXX'
134800151109      *
134900151109    4C                   if        nxttyp = 'AAA'
135000151109     C                   eval      nxttyp = 'TIN'
135100151109    4C                   else
135200151109    4C                   if        nxttyp = 'TIN'
135300190719     C                   eval      nxttyp = 'TDB'
135400190719    4C                   else
135500190719    4C                   if        nxttyp = 'TDB'
135600190719     C                   eval      nxttyp = 'TPC'
135700151109    4C                   else
135800151109    4C                   if        nxttyp = 'TPC'
135900151109     C                   eval      nxttyp = 'TP2'
136000151109    4C                   else
136100151109    4C                   if        nxttyp = 'TP2'
136200151109     C                   eval      nxttyp = 'THW'
136300151109    4C                   else
136400151109    4C                   if        nxttyp = 'THW'
136500151109     C                   eval      nxttyp = 'TFA'
136600151109    4C                   else
136700151109    4C                   if        nxttyp = 'TFA'
136800151109     C                   eval      nxttyp = 'TMI'
136900151109    4C                   else
137000151109    4C                   if        nxttyp = 'TMI'
137100170731     C                   eval      nxttyp = 'TMP'
137200170731    4C                   else
137300170731    4C                   if        nxttyp = 'TMP'
137400170731     C                   eval      nxttyp = 'TMH'
137500170731    4C                   else
137600170731    4C                   if        nxttyp = 'TMH'
137700170731     C                   eval      nxttyp = 'TMF'
137800170731    4C                   else
137900170731    4C                   if        nxttyp = 'TMF'
138000170731     C                   eval      nxttyp = 'XXX'
138100151109    4C                   endif
138200170731    4C                   endif
138300170731    4C                   endif
138400190719    4C                   endif
138500170731    4C                   endif
138600151109    4C                   endif
138700151109    4C                   endif
138800151109    4C                   endif
138900151109    4C                   endif
139000151109    4C                   endif
139100151109    4C                   endif
139200151109      *
139300151109     C                   eval      typfnd = 'N'
139400151109      *
139500000210     C     G24FKY        SETLL     G24
139600000211    1C                   DOU       %EOF(GRAT24)
139700021002     C     G24FKY        READE(N)  G24
139800000211    2C                   IF        NOT %EOF(GRAT24) OR #O2CREC = 100
139900151109      *
140000151109     C                   if        typecd <> nxttyp
140100151109     C                   iter
140200151109     C                   else
140300151109     C                   eval      typfnd = 'Y'
140400151109     C                   endif
140500151109      *
140600000210     C                   CLEAR                   IO02S
140700000210     C                   ADD       1             #O2CREC
140800000210     C                   MOVE      *ON           *IN28
140900000210     C                   MOVE      *OFF          *IN31
141000000210     C*
141100000210     C                   MOVE      GRDLTD        STAX
141200000210     C                   MOVE      TYPECD        O2TCOD
141300000210     C                   MOVE      AGEBND        O2ABND
141400000210     C                   MOVE      NETRTE        O2NETR
141500000210     C                   MOVE      BILRTE        O2BILR
141600000210     C                   MOVE      GROUP#        O2GROP
141700140409     C*
141800140409     C                   IF        %SUBST(ACAPLAN:11:1) = 'Y'
141900140409     C                   EVAL      *IN60 = *ON
142000140409     C                   ELSE
142100140409     C                   EVAL      *IN60 = *OFF
142200140409     C                   ENDIF
142300001019     C*
142400001019     C                   MOVE      GRDLTD        HSTAX
142500000210     C                   MOVE      TYPECD        H2TCOD
142600000210     C                   MOVE      AGEBND        H2ABND
142700000210     C                   MOVE      NETRTE        H2NETR
142800000210     C                   MOVE      BILRTE        H2BILR
142900000210     C                   MOVE      GROUP#        H2GROP
143000001019     C*
143100001011003 3C                   IF        PABFL <> 'N' AND #BANDS > 0
143200000210     C                   EXSR      $LOADBAND
143300000216     C                   MOVE      *OFF          *IN31
143400000216     C                   ELSE
143500000216     C                   MOVE      *ON           *IN31
143600000211    3C                   ENDIF
143700001018    3C                   IF        SGRRMT = 'B'
143800001018     C                   MOVE      *ON           *IN50
143900001018    3C                   ELSE
144000001018     C                   MOVE      *OFF          *IN50
144100001018    3C                   ENDIF
144200000210     C*
144300000210     C                   ADD       1             RR2
144400000211    3C                   IF        @1STLOOP = '0'
144500000210     C                   Z-ADD     RR2           SFLPOS2
144600000210     C                   MOVE      '1'           @1STLOOP
144700000211    3C                   ENDIF
144800000210     C*
144900000210     C                   WRITE     IO02S
145000000210     C*
145100000211    2C                   ENDIF
145200000210     C*
145300000211    1C                   ENDDO
145400151109      *
145500151109    1C                   enddo
145600151109      *
145700000211    1C                   IF        #O2CREC < 100
145800000210     C*
145900000211     C                   MOVE      *ZEROS        #DLOOP
146000000210     C                   EVAL      #DLOOP = 100 - #O2CREC
146100000210     C*
146200000211    2C                   DOU       #DLOOP = 0
146300000210     C*
146400000210     C                   CLEAR                   IO02S
146500000210     C                   MOVE      *ON           *IN28
146600000210     C                   SUB       1             #DLOOP
146700000210     C*
146800000210     C                   MOVE      *BLANKS       STAX
146900000210     C                   MOVE      *BLANKS       O2TCOD
147000000210     C                   MOVE      *ZEROS        O2ABND
147100000210     C                   MOVE      *ZEROS        O2NETR
147200000210     C                   MOVE      *ZEROS        O2BILR
147300000216     C                   MOVE      *BLANKS       O2GROP
147400001019     C                   MOVE      *BLANKS       HSTAX
147500000210     C                   MOVE      *BLANKS       H2TCOD
147600000210     C                   MOVE      *ZEROS        H2ABND
147700000210     C                   MOVE      *ZEROS        H2NETR
147800000210     C                   MOVE      *ZEROS        H2BILR
147900000210     C                   MOVE      *ZEROS        H2GROP
148000000210     C*
148100001011003 3C                   IF        PABFL <> 'N' AND #BANDS > 0
148200000210     C                   EXSR      $LOADBAND
148300000216     C                   MOVE      *OFF          *IN31
148400000216     C                   ELSE
148500000216     C                   MOVE      *ON           *IN31
148600000211    3C                   ENDIF
148700001018    3C                   IF        SGRRMT = 'B'
148800001018     C                   MOVE      *ON           *IN50
148900001018    3C                   ELSE
149000001018     C                   MOVE      *OFF          *IN50
149100001018    3C                   ENDIF
149200000210     C*
149300000210     C                   ADD       1             RR2
149400000216    3C                   IF        @1STLOOP = '0'
149500000216     C                   Z-ADD     RR2           SFLPOS2
149600000216     C                   MOVE      '1'           @1STLOOP
149700000216    3C                   ENDIF
149800000210     C*
149900000210     C                   WRITE     IO02S
150000000210     C*
150100000211    2C                   ENDDO
150200000210     C*
150300000211    1C                   ENDIF
150400000210     C*
150500000210     C                   MOVEL(P)  'STEP5 '      @STEP
150600000210     C                   MOVE      *BLANKS       @EMSG
150700000210     C*
150800000211    SC                   ENDSR
150900000210     C*
151000000210     C* LOAD AGE BANDS
151100000210     C*
151200000211    SC     $LOADBAND     BEGSR
151300000210     C*
151400000210     C                   MOVE      *ON           *IN31
151500000210     C                   ADD       1             #BNDFLG
151600000211    1C                   IF        #BNDFLG = 21
151700000210     C                   Z-ADD     1             #BNDFLG
151800000211    1C                   ENDIF
151900000210     C                   MOVE      #BNDFLG       A
152000000211    1C                   IF        AFR(A) > 0
152100000210     C                   MOVEL(P)  '#'           O2ABC
152200000210     C                   MOVE      A             O2ABC
152300000210     C                   MOVE      AFR(A)        O2ABF
152400000210     C                   MOVE      ATO(A)        O2ABT
152500000211    1C                   ENDIF
152600220304     C*
152700220304     C* Clear when subfile scroll on empty lines
152800220304     C                   if        STAX   = *blanks and
152900220304     C                             O2ABND = *zeros  and
153000220304     C                             O2TCOD = *blanks
153100220307     C***                clear                   O2ABC
153200220307     C***                clear                   O2ABC
153300220307     C***                clear                   O2ABF
153400220307     C***                clear                   O2ABT
153500220304     C                   end
153600000210     C*
153700000211    SC                   ENDSR
153800000210     C*
153900000218     C* RATE MAINTENANCE SCREEN
154000000210     C*
154100000211    SC     $STEP5        BEGSR
154200000210     C*
154300000210     C                   MOVEL(P)  @EMSG         SMSG
154400220302     C*
154500220302     C                   exsr      CheckF89
154600000210     C*
154700000210     C                   WRITE     IO02R
154800000210     C                   EXFMT     IO02C
154900000210     C*
155000000210     C                   MOVE      *OFF          *IN32
155100000210     C                   MOVE      *BLANKS       @EMSG
155200000210     C*
155300220201    1C                   IF        *IN01 = *on
155400000216     C                   MOVEL(P)  'STEP2'       @STEP
155500000210     C                   LEAVESR
155600000211    1C                   ENDIF
155700000210     C*
155800220201    1C                   If        *in08 = *on AND
155900150312     C                             *IN81 = *off  OR
156000220201    1C                             *in09 = *on  AND
156100140715     C                             *IN81 = *off
156200140715     C                   LeaveSR
156300140715     C                   End
156400140715     C*
156500220201    1C                   If        *in08 = *on AND
156600150312     C                             *IN81 = *on   OR
156700220201    1C                             *in09 = *on AND
156800150312     C                             *IN81 = *on
156900220302
157000220302     C                   select
157100220302    1C                   when      *in08 = *on
157200220302     C                   eval      W89 = 'F8'
157300220302    1C                   when      *in09 = *on
157400220302     C                   eval      W89 = 'F9'
157500220302     C                   endsl
157600100819
157700100819     C     KEYCOD        Klist
157800100819     C                   Kfld                    TYPE
157900100819     C                   Kfld                    CODE
158000100819     C                   Movel     PLNCAT        TYPE
158100100819     C                   Move      PLNCAT        CODE
158200100819     C     KEYCOD        Chain     CODES
158300100819
158400100817     C                   Select
158500101011     C                   When      PLANCD = 'OPTM'  or
158600101130     C                             PLANCD = 'OPTD'  or
158700101130     C                             PLANCD = 'CRED'
158800101011     C                   MOVEL(P)  MSG(28)       @EMSG
158900101011      * Not allowed, use WRKOPT
159000100819     C                   When      ACTION = 'M'  or
159100100819     C                             ACTION = 'R'  or
159200100819     C                             ACTION = 'V'  or
159300200311     C                             ACTION = 'D'  or
159400200311     C                             ACTION = 'X'  or
159500200303     C                             PLNCAT = 'PP8' or
159600140131     C                             PLNCAT = 'PHR'
159700100506     C                   Eval      PDTRST   =    TRUST#
159800100506     C                   Eval      PDSUB#   =    SUB#
159900100506     C                   Eval      PDPLAN   =    PLANCD
160000100506     C                   Eval      PDCVTP   =    TYPECD
160100100506     C                   Eval      PDBEDT   =    #FDATE
160200100506     C                   Eval      PDENDT   =    #TDATE
160300220208    1C*******            If        FKEY = F8
160400220208    1C                   If        W89  = 'F8'
160500150402     C                   Eval      WIFKEY = 'F8'
160600150402     C                   Exsr      SHOPORTIER
160700150317     C                   end
160800220208    1C*****              If        FKEY = F9
160900220208    1C                   If        W89  = 'F9'
161000150402     C                   Eval      WIFKEY = 'F9'
161100150402     C                   Exsr      SHOPORTIER
161200150317     C                   end
161300150415     C                   If        %trim(@EMSG) = *blanks
161400100505     C                   Call      'WRKPRDCL'
161500150402     C                   Parm                    WDTA
161600150402     C                   Parm                    WIFKEY            2
161700150402     C                   Parm                    WISTFLG           1
161800150415     C                   End
161900100819     C*
162000100819     C                   When      ACTION = 'L'  or
162100100819     C                             ACTION = 'A'  or
162200100819     C                             ACTION = 'S'  or
162300100819     C                             ACTION = 'T'  or
162400100915     C                             ACTION = 'E'  or
162500130423     C                             PLNCAT = 'PEP' or
162600120920     C                             PLNCAT = 'P2P' or
162700100915     C                             PLNCAT = 'PP1' or
162800100915     C                             PLNCAT = 'PP2' or
162900110117     C                             PLNCAT = 'PPR' or
163000110117     C                             PLNCAT = 'PPS' or
163100100915     C                             PLNCAT = 'PP3' or
163200100915     C                             PLNCAT = 'PP4' or
163300100915     C                             PLNCAT = 'PP5' or
163400100915     C                             PLNCAT = 'PP6' or
163500110103     C                             PLNCAT = 'PP7' or
163600110108     C                             PLNCAT = 'PV0' or
163700110108     C                             PLNCAT = 'PV1' or
163800110108     C                             PLNCAT = 'PV2' or
163900110108     C                             PLNCAT = 'PV3' or
164000110108     C                             PLNCAT = 'PV4' or
164100110108     C                             PLNCAT = 'PV5' or
164200110108     C                             PLNCAT = 'PV6' or
164300110108     C                             PLNCAT = 'PV7' or
164400110108     C                             PLNCAT = 'PV8' or
164500110108     C                             PLNCAT = 'PV9' or
164600101229     C                             PLNCAT = 'PFM' or
164700101229     C                             PLNCAT = 'PFD'
164800100817     C                   Eval      PATRST   =    TRUST#
164900100817     C                   Eval      PASUB#   =    SUB#
165000100817     C                   Eval      PAPLAN   =    PLANCD
165100100817     C                   Eval      PABEDT   =    #FDATE
165200100817     C                   Eval      PAENDT   =    #TDATE
165300100817     C                   Call      'WRKANCCL'
165400100817     C                   Parm                    WDTAA
165500100817     C                   Parm                    PLNCAT
165600100819     C                   Other
165700100817     C                   Endsl
165800100603     C                   LEAVESR
165900100506    1C                   End
166000100505     C*
166100220201    1C                   IF        *IN10 = *on
166200220202
166300220202         pType = 'T';
166400220202         wn0024r(pType : pfCode : pCancel );
166500220202         if pCancel = '';
166600220202           @3 = %trim(pfCode);
166700220202         endif;
166800220202
166900000217     C                   LEAVESR
167000000217    1C                   ENDIF
167100000217     C*
167200000831     C                   MOVE      *BLANKS       @CAPGRP          15
167300000831     C                   MOVE      'N'           @CAPTUREGRP       1
167400001026     C                   MOVE      'N'           @CAPGRP2          1
167500000831     C*
167600000211    1C                   DOU       *IN32 = *ON OR @EMSG <> *BLANKS
167700000210     C                   READC     IO02S                                  32
167800000211    2C                   IF        *IN32 = *OFF
167900000831     C*
168000001107    3C                   IF        @AUTO = 'Y'
168100001107    4C                   IF        @CAPGRP2 = 'N'
168200001026     C                   MOVE      STAX          @CAPSTS           1
168300001026     C                   MOVE      'Y'           @CAPGRP2
168400001107    4C                   ENDIF
168500001107    4C                   IF        STAX = *BLANKS
168600001026     C                   MOVE      @CAPSTS       STAX
168700001026     C                   MOVE      @CAPSTS       HSTAX
168800001107    4C                   ENDIF
168900001107    4C                   IF        @CAPTUREGRP = 'N'
169000000831     C                   MOVE      'Y'           @CAPTUREGRP
169100000831     C                   MOVEL     O2GROP        @CAPGRP
169200001107    4C                   ENDIF
169300001107     C*
169400001107    4C                   IF        O2GROP = *BLANKS
169500001107     C                   MOVEL     @CAPGRP       O2GROP
169600001107    4C                   ENDIF
169700001107    3C                   ENDIF
169800000901     C*
169900001107    3C                   IF        SGRRMT = 'B'
170000000901     C                   Z-ADD     O2BILR        O2NETR
170100001019    3C                   ENDIF
170200000210     C*
170300001019    3C                   IF        STAX <> HSTAX OR O2ABND <> H2ABND OR
170400000210     C                             O2TCOD <> H2TCOD OR O2NETR <> H2NETR OR
170500000210     C                             O2BILR <> H2BILR OR O2GROP <> H2GROP
170600000210     C*
170700000210     C                   EXSR      $PROCHG
170800000210     C*
170900000211    3C                   ENDIF
171000001107     C*
171100001107     C                   MOVE      STAX          HSTAX
171200001107     C                   MOVE      O2ABND        H2ABND
171300001107     C                   MOVE      O2TCOD        H2TCOD
171400001107     C                   MOVE      O2NETR        H2NETR
171500001107     C                   MOVE      O2BILR        H2BILR
171600001107     C                   MOVEL     O2GROP        H2GROP
171700000210     C*
171800001011003 3C                   IF        PABFL <> 'N'
171900000901     C                   MOVE      *OFF          *IN31
172000000901     C                   ELSE
172100000901     C                   MOVE      *ON           *IN31
172200000211    3C                   ENDIF
172300001018    3C                   IF        SGRRMT = 'B'
172400001018     C                   MOVE      *ON           *IN50
172500001018    3C                   ELSE
172600001018     C                   MOVE      *OFF          *IN50
172700001018    3C                   ENDIF
172800000901     C*
172900000210     C                   UPDATE    IO02S
173000000210     C*
173100000211    2C                   ENDIF
173200000210     C*
173300040723     C*
173400000211    1C                   ENDDO
173500040723     C                   EXSR      $MKTSZSR
173600001205     C                   MOVE      'N'           @AUTO
173700000210     C*
173800000211    SC                   ENDSR
173900000218     C*
174000000218     C* PROCESS RATE CHANGE(S)
174100000211     C*
174200000211    SC     $PROCHG       BEGSR
174300000210     C*
174400120120     C                   EXSR      $VALABT
174500120120    1C                   IF        O2ABND <> H2ABND OR O2TCOD <> H2TCOD
174600120120     C                   EXSR      $VALDUP
174700120120    1C                   ENDIF
174800001019     C*
174900000211    1C                   IF        @EMSG = *BLANKS
175000001019     C*
175100000211    2C                   SELECT
175200000211    2C                   WHEN      O2GROP = *BLANKS
175300000210     C                   MOVEL(P)  MSG(7)        @EMSG
175400000210     C                   MOVE      *ON           *IN45
175500000831    2C                   WHEN      O2NETR = 0 AND O2BILR <> 0
175600000210     C                   MOVEL(P)  MSG(5)        @EMSG
175700000210     C                   MOVE      *ON           *IN43
175800080822
175900080822      * 8/22/08 allow carrier MBF to have bill = 0 and net <> 0
176000091214      *12/14/09 allow carrier NAB to have bill = 0 and net <> 0
176100161215      *12/15/16 allow carrier ABF to have bill = 0 and net <> 0
176200191120      *11/20/19 allow carrier MBC to have bill = 0 and net <> 0
176300091214
176400161215    2C                   WHEN      (pcarr <> 'MBF' and pcarr <> 'NAB' and
176500191120    2C                              pcarr <> 'ABF' and pcarr <> 'MBC') and
176600091214    2C                             (O2BILR = 0 and O2NETR <> 0)
176700000210     C                   MOVEL(P)  MSG(6)        @EMSG
176800000210     C                   MOVE      *ON           *IN44
176900080822
177000000211    2C                   WHEN      STAX <> 'A' AND STAX <> 'D'
177100000210     C                   MOVEL(P)  MSG(10)       @EMSG
177200000210     C                   MOVE      *ON           *IN40
177300001107    2C                   WHEN      O2BILR = O2NETR AND O2NETR <> 0 AND
177400001107     C                             SGRRMT <> 'B'
177500001107     C                   MOVEL(P)  MSG(21)       @EMSG
177600001107     C                   MOVE      *ON           *IN43
177700021023      * DB group edit
177800021023      * group # format is "XXXX    9999   "
177900030520     c                   WHEN      (delbil = 'Y') and (g14 <> 'TEMP'
178000030520     c                             and g14 <> 'temp') and
178100030520     c                             (g14 = *BLANKS or g58 <> *blanks
178200021023     c                             or g912 = *blanks or g1315 <> *blanks)
178300021023     C                   MOVEL(P)  MSG(27)       @EMSG
178400021023     C                   MOVE      *ON           *IN45
178500000211    2C                   ENDSL
178600001019     C*
178700000211    1C                   ENDIF
178800001019     C*
178900000211    1C                   IF        @EMSG = *BLANKS
179000001019     C*
179100000211    2C                   IF        O2ABND <> H2ABND OR O2TCOD <> H2TCOD
179200000210     C                   EXSR      $UPDTKC
179300000210     C                   ELSE
179400000210     C                   EXSR      $UPDTNK
179500000211    2C                   ENDIF
179600000211    1C                   ENDIF
179700000211    SC                   ENDSR
179800000218     C*
179900000218     C* VALIDATE AGE BAND AND TYPE CODE
180000000218     C*
180100000211    SC     $VALABT       BEGSR
180200000210     C*
180300001011003 1C                   IF        PABFL <> 'N' AND (O2ABND > #BANDS OR
180400000210     C                                              O2ABND = 0)
180500000210     C                   MOVEL(P)  MSG(9)        @EMSG
180600000210     C                   MOVE      *ON           *IN41
180700000210     C                   LEAVESR
180800000211    1C                   ENDIF
180900000210     C*
181000000210     C                   MOVEL(P)  O2TCOD        @CODE
181100000210     C     CODEKY        CHAIN     CODESR
181200000216    1C                   IF        NOT %FOUND(CODES)
181300001201     C                   MOVEL(P)  MSG(4)        @EMSG
181400000210     C                   MOVE      *ON           *IN42
181500000210     C                   LEAVESR
181600000211    1C                   ENDIF
181700000210     C*
181800120120    SC                   ENDSR
181900120120     C*
182000120120     C* VALIDATE AGE BAND AND TYPE CODE
182100120120     C*
182200120120    SC     $VALDUP       BEGSR
182300120120     C*
182400000210     C                   MOVEL(P)  'T'           @TYPE
182500000210     C                   MOVE      O2TCOD        @TYPE
182600000210     C                   Z-ADD     O2ABND        #ABND
182700000210     C     GXKEY         CHAIN     GX
182800000211    1C                   IF        %FOUND(GRATEX)
182900021002     C                   MOVEL(P)  MSG(26)       @EMSG
183000000210     C                   MOVE      *ON           *IN41
183100000210     C                   MOVE      *ON           *IN42
183200000211    1C                   ENDIF
183300000210     C*
183400000211    SC                   ENDSR
183500000218     C*
183600000218     C* UPDATE ALL RATE RECORDS FOR A KEY CHANGE IN ADDITION TO OTHER CHANGES
183700000210     C*
183800000211    SC     $UPDTKC       BEGSR
183900000210     C*
184000000210     C                   MOVEL(P)  'T'           @TYPE
184100000210     C                   MOVE      H2TCOD        @TYPE
184200000210     C                   Z-ADD     H2ABND        #ABND
184300000210     C*
184400000210     C     GXKEY         CHAIN     GX
184500000211    1C                   IF        %FOUND(GRATEX)
184600000211     C                   EXSR      $SETJRN
184700001019     C                   MOVE      FRMDAT        HFBFFRDT
184800001019     C                   MOVE      TODAT         HFBFTODT
184900001019     C                   MOVE      AGEBND        HFBFAGBN
185000001019     C                   MOVE      GRDLTD        HFBFDLTC
185100001019     C                   MOVEL     TYPECD        HFBFTYCD
185200001019     C                   MOVE      BILRTE        HFBFBILR
185300001019     C                   MOVE      NETRTE        HFBFNETR
185400001019     C                   MOVEL     GROUP#        HFBFGRP#
185500001019     C                   MOVE      FRMDAT        HFAFFRDT
185600001019     C                   MOVE      TODAT         HFAFTODT
185700001019     C                   MOVE      AGEBND        HFAFAGBN
185800001019     C                   MOVE      GRDLTD        HFAFDLTC
185900001019     C                   MOVEL     TYPECD        HFAFTYCD
186000001019     C                   MOVE      BILRTE        HFAFBILR
186100001019     C                   MOVE      NETRTE        HFAFNETR
186200001019     C                   MOVEL     GROUP#        HFAFGRP#
186300001019     C                   MOVE      'D'           HFAFDLTC
186400000211     C                   WRITE     RGRTHIST
186500111012     C                   Exsr      RateAlert
186600001019     C                   MOVE      'D'           GRDLTD
186700000210     C                   UPDATE    GX
186800200221       exsr updateUHC;
186900000211    1C                   ENDIF
187000030509    ***
187100000211     C                   CLEAR                   GRATER
187200000210     C                   Z-ADD     TRUST#        GRTRST
187300000210     C                   Z-ADD     SUB#          GRSUB#
187400000210     C                   MOVEL     PLANCD        GRPLAN
187500000218     C     FRDATE        MULT      10000.0001    FRMDAT
187600000218     C     TODATE        MULT      10000.0001    TODAT
187700001011003 1C                   IF        PABFL <> 'N'
187800000210     C                   Z-ADD     O2ABND        AGEBND
187900000211    1C                   ENDIF
188000000210     C                   MOVE      STAX          GRDLTD
188100000210     C                   MOVEL(P)  'T'           @TYPE
188200000210     C                   MOVE      O2TCOD        @TYPE
188300000210     C                   MOVE      @TYPE         TYPECD
188400000210     C                   Z-ADD     O2NETR        NETRTE
188500000210     C                   Z-ADD     O2BILR        BILRTE
188600000210     C                   MOVEL     O2GROP        GROUP#
188700000211     C                   EXSR      $SETJRN
188800001019     C                   MOVE      FRMDAT        HFAFFRDT
188900001019     C                   MOVE      TODAT         HFAFTODT
189000001019     C                   MOVE      AGEBND        HFAFAGBN
189100001019     C                   MOVE      GRDLTD        HFAFDLTC
189200001019     C                   MOVEL     TYPECD        HFAFTYCD
189300001019     C                   MOVE      BILRTE        HFAFBILR
189400001019     C                   MOVE      NETRTE        HFAFNETR
189500001019     C                   MOVEL     GROUP#        HFAFGRP#
189600000211     C                   WRITE     RGRTHIST
189700000211     C                   WRITE     GRATER
189800111012     C                   Exsr      RateAlert
189900030509    * *
190000030509     c                   exsr      $chktemp
190100030509     c                   if        fnd@grp = '0'
190200030509     c                   exsr      $wrttemp
190300030509     c                   endif
190400030509    ***
190500000211    SC                   ENDSR
190600000210     C*
190700000218     C* SET UP GROUP RATE CHANGE HISTORY RECORD
190800000218     C*
190900000211    SC     $SETJRN       BEGSR
191000000211     C*
191100000211     C                   CLEAR                   RGRTHIST
191200001019     C                   Z-ADD     TRUST#        HFTRST
191300001019     C                   Z-ADD     SUB#          HFSUB#
191400001019     C                   MOVEL     PLANCD        HFPLAN
191500000211     C                   CLEAR                   @TIMESTAMP
191600000211     C                   MOVE      *BLANKS       @TS40
191700000211     C                   CALL      'TIMESTMP'
191800000211     C                   PARM                    @TS40
191900000211     C                   MOVEL     @TS40         @TIMESTAMP
192000001019     C                   MOVEL     @TSUSER       HFUSERID
192100001019     C                   MOVE      #TSCYMD       HFDATE
192200001019     C                   MOVE      #TSTIME       HFTIME
192300001019     C                   MOVEL     @TSJOB        HFJOBNAM
192400001019     C                   MOVE      #TSNBR        HFJOBNBR
192500000211     C*
192600000211    SC                   ENDSR
192700000210     C*
192800000218     C* UPDATE ALL RATE RECORDS FOR NON-KEY CHANGES
192900000218     C*
193000000211    SC     $UPDTNK       BEGSR
193100000210     C*
193200000210     C                   MOVEL(P)  'T'           @TYPE
193300000210     C                   MOVE      O2TCOD        @TYPE
193400000210     C                   MOVE      @TYPE         TYPECD
193500000901     C                   Z-ADD     H2ABND        #ABND
193600000210     C*
193700000210     C     GXKEY         CHAIN     GX
193800001205    1C                   IF        %FOUND(GRATEX)
193900000210     C*
194000000211     C                   EXSR      $SETJRN
194100001019     C*
194200001019     C                   MOVE      FRMDAT        HFBFFRDT
194300001019     C                   MOVE      TODAT         HFBFTODT
194400001019     C                   MOVE      AGEBND        HFBFAGBN
194500001019     C                   MOVE      GRDLTD        HFBFDLTC
194600001019     C                   MOVEL     TYPECD        HFBFTYCD
194700001019     C                   MOVE      BILRTE        HFBFBILR
194800001019     C                   MOVE      NETRTE        HFBFNETR
194900001019     C                   MOVEL     GROUP#        HFBFGRP#
195000030509    * *
195100030509     c                   exsr      $chktemp
195200030512    * *
195300030509     c                   if        fnd@grp = '1'
195400030509     c                   exsr      $updtemp
195500030512     c                   else
195600030512    * *
195700030512     c                   if        fnd@grp = 'X'
195800030512     c                   move      *blanks       key@grp          15
195900030512     c                   eval      key@grp = group#
196000030512    * *
196100030512     c     key@grp       chain(n)  tempgr
196200030512    * *
196300030512     c                   if        %found(tempg#)
196400030512     c                   exsr      $updtemp
196500030512     c                   endif
196600030512    * *
196700030509     c                   endif
196800030512    * *
196900030512     c                   endif
197000001019     C*
197100001019     C                   MOVE      FRMDAT        HFAFFRDT
197200001019     C                   MOVE      TODAT         HFAFTODT
197300001019     C                   MOVE      AGEBND        HFAFAGBN
197400001019     C                   MOVE      STAX          HFAFDLTC
197500001019     C                   MOVEL     TYPECD        HFAFTYCD
197600001019     C                   Z-ADD     O2BILR        HFAFBILR
197700001019     C                   Z-ADD     O2NETR        HFAFNETR
197800001019     C                   MOVEL     O2GROP        HFAFGRP#
197900001019     C*
198000000211     C                   WRITE     RGRTHIST
198100111012     C                   Exsr      RateAlert
198200000211     C*
198300000210     C                   MOVE      STAX          GRDLTD
198400000210     C                   Z-ADD     O2NETR        NETRTE
198500000210     C                   Z-ADD     O2BILR        BILRTE
198600000210     C                   MOVEL     O2GROP        GROUP#
198700000210     C                   UPDATE    GX
198800200221       exsr updateUHC;
198900030509    * *
199000001205     C                   ELSE
199100001205     C*
199200001205     C                   EXSR      $SETJRN
199300001205     C*
199400001205     C                   MOVE      FRMDAT        HFAFFRDT
199500001205     C                   MOVE      TODAT         HFAFTODT
199600001205     C                   MOVE      AGEBND        HFAFAGBN
199700001205     C                   MOVE      STAX          HFAFDLTC
199800001205     C                   MOVEL     TYPECD        HFAFTYCD
199900001205     C                   Z-ADD     O2BILR        HFAFBILR
200000001205     C                   Z-ADD     O2NETR        HFAFNETR
200100001205     C                   MOVEL     O2GROP        HFAFGRP#
200200001205     C*
200300001205     C                   WRITE     RGRTHIST
200400111012     C                   Exsr      RateAlert
200500001205     C*
200600001205     C                   CLEAR                   GRATER
200700001205     C                   Z-ADD     TRUST#        GRTRST
200800001205     C                   Z-ADD     SUB#          GRSUB#
200900001205     C                   MOVEL     PLANCD        GRPLAN
201000001205     C     FRDATE        MULT      10000.0001    FRMDAT
201100001205     C     TODATE        MULT      10000.0001    TODAT
201200001205003 1C                   IF        PABFL <> 'N'
201300001205     C                   Z-ADD     O2ABND        AGEBND
201400001205    1C                   ENDIF
201500001205     C                   MOVE      STAX          GRDLTD
201600001205     C                   MOVEL(P)  'T'           @TYPE
201700001205     C                   MOVE      O2TCOD        @TYPE
201800001205     C                   MOVE      @TYPE         TYPECD
201900001205     C                   Z-ADD     O2NETR        NETRTE
202000001205     C                   Z-ADD     O2BILR        BILRTE
202100001205     C                   MOVEL     O2GROP        GROUP#
202200001205     C                   WRITE     GX
202300030509    * *
202400030509     c                   exsr      $chktemp
202500030509     c                   if        fnd@grp = '0'
202600030509     c                   exsr      $wrttemp
202700030509     c                   endif
202800030509    * *
202900001205     C                   ENDIF
203000030509    ***
203100000211    SC                   ENDSR
203200030509   S***S
203300030509     c     $chktemp      begsr
203400030509    ***
203500030512     c                   movel     group#        @@4               4
203600030512     c     lo:up         xlate     @@4           @@4
203700030512    ***
203800030512     c                   if        @@4 <> 'TEMP'
203900030509     c                   eval      fnd@grp = 'X'
204000030509     c                   leavesr
204100030509     c                   endif
204200030509    ***
204300030509     c                   move      *blanks       key@grp          15
204400030512     c                   eval      key@grp = group#
204500030509    ***
204600030509     c     key@grp       chain(n)  tempgr
204700030509     c                   if        %found(tempg#)
204800030509     c                   move      '1'           fnd@grp           1
204900030509     c                   else
205000030509     c                   move      '0'           fnd@grp
205100030509     c                   endif
205200030509    ***
205300030509     c                   endsr
205400030509   S***S
205500030509     c     $wrttemp      begsr
205600030509    ***
205700030509     c                   clear                   tempgr
205800030509    * *
205900030512     c                   eval      tetempg# = group#
206000030509     c                   z-add     #tscymd       teaddt
206100030509     c                   movel     @tsuser       teaduser
206200030509    * *
206300030509     c                   write     tempgr
206400030509    ***
206500030509     c                   endsr
206600030509   S***S
206700030509     c     $updtemp      begsr
206800030509    ***
206900030509     c     key@grp       chain     tempgr
207000030509     c                   eval      terealg# = O2GROP
207100030509     c                   z-add     #tscymd       techdt
207200030509     c                   movel     @tsuser       techuser
207300030509    ***
207400030509     c                   update    tempgr
207500030509    ***
207600030509     c                   endsr
207700030509   S***S
207800040723     C     $MKTSZSR      BEGSR
207900040723
208000150402     C     KEY#PLAN      CHAIN(N)  MCOVR
208100040723    2C                   IF        %FOUND(MCOVL1)
208200040723     C                   MOVE      ACC#          @ACCT
208300040803    2C*                  ENDIF
208400040723
208500040723     C                   MOVE      TRUST#        @TRST
208600040723     C                   MOVE      SUB#          @SUB
208700040728     C                   CALL      'FM063CL'
208800040723     C                   PARM                    @@TSA
208900040728     C                   PARM                    PCARR
209000040728     C                   PARM                    CNAME
209100220201     C                   eval      *IN01 = *on
209200040803    2C                   ENDIF
209300040723
209400111010     C                   ENDSR
209500150402   S***S
209600220302     C     CheckF89      BEGSR
209700220302     C                   eval      W89 = '89'
209800220302
209900220302     C     F8KEY         Setll     PAYDED
210000220302    2C     F8KEY         Reade(n)  PAYDED
210100220302     C                   dow       not %eof(PAYDED)
210200220302     C                   if        PDTRMD = 0
210300220322     C                   Select
210400220322     C                   when      PD$AMT <> 0  or
210500220322     C                             PDDAMT <> 0
210600220322     C                   eval      *in82 = *on
210700220322     C                   eval      W89 = 'F8'
210800220322     C                   eval      WF8KEY = 'PayDed $'
210900220322     C                   LeaveSR
211000220322     C                   when      PDPAMT <> 0  or
211100220322     C                             PDPDEP <> 0
211200220322     C                   eval      *in83 = *on
211300220322     C                   eval      W89 = 'F9'
211400220322     C                   eval      WF9KEY = 'PayDed %'
211500220322     C                   LeaveSR
211600220322     C                   when      %trim(VLPLAN) = 'HRA1'
211700220322     C                   eval      *in82 = *on
211800220322     C                   eval      W89 = 'F8'
211900220322     C                   eval      WF8KEY = 'PayDed $'
212000220322     C                   LeaveSR
212100220322     C                   Endsl
212200220302     C                   end
212300220302    2C     F8KEY         Reade(n)  PAYDED
212400220302     C                   Enddo
212500220302
212600220302     C     F8KEY         Setll     PAYDEDANP
212700220302     C     F8KEY         Reade(n)  PAYDEDANP
212800220302    2C                   dow       not %eof(PAYDEDANP)
212900220302     C                   If        PATRMD = 0
213000220302     C                   Select
213100220302     C                   when      PAFORM <> *blanks
213200220302     C                   eval      *in82 = *on
213300220302     C                   eval      W89 = 'F9'
213400220302     C                   LeaveSR
213500220302     C                   Other
213600220302     C                   eval      *in83 = *on
213700220302     C                   eval      W89 = 'F9'
213800220302     C                   LeaveSR
213900220302     C                   Endsl
214000220302     C                   end
214100220302    2C     F8KEY         Reade(n)  PAYDEDANP
214200220302     C                   Enddo
214300220302
214400220302     C                   ENDSR
214500150402     C     SHOPORTIER    BEGSR
214600111010
214700150402     C     PLNKEY        CHAIN     PLNAUXP
214800150402     C                   If        %found(PLNAUXP)
214900150402     C                   select
215000220208    1C*****              when      FKEY = F8
215100220208    1C                   when      W89  = 'F8'
215200150415     C                   If        *in83 = *on
215300150415     C                   MOVEL(P)  MSG(31)       @EMSG
215400150415     C                   End
215500150402     C                   Eval      wiSTFLG = 'T'
215600220208    1C*******            when      FKEY = F9
215700220208    1C                   when      W89  = 'F9'
215800150415     C                   If        *in82 = *on
215900150415     C                   MOVEL(P)  MSG(31)       @EMSG
216000150415     C                   End
216100150402     C                   Eval      wiSTFLG = 'S'
216200150402     C                   Endsl
216300150402     C                   End
216400150402
216500150402     C                   ENDSR
216600111010   S***S
216700111012     C     RateAlert     BEGSR
216800111012
216900111012      * If payroll deductions exist...
217000150312     C                   If        *in82 = *on  or
217100150312     C                             *in83 = *on
217200111012      * If rates are changing...
217300111012     C                   If        HFBFAGBN <> HFAFAGBN and
217400111012     C                             HFBFAGBN <> *zeros   or
217500111012     C                             HFBFTYCD <> HFAFTYCD and
217600111012     C                             HFBFTYCD <> *blanks  or
217700111012     C                             HFBFNETR <> HFAFNETR and
217800111012     C                             HFBFNETR <> *zeros   or
217900111012     C                             HFBFBILR <> HFAFBILR and
218000111012     C                             HFBFBILR <> *zeros   or
218100111012     C                             HFBFGRP# <> HFAFGRP# and
218200111012     C                             HFBFGRP# <> *blanks  or
218300111012     C                             HFBFDLTC <> HFAFDLTC and
218400111012     C                             HFBFDLTC <> *blanks
218500111012     C                   Call      'SNDALERTC'
218600111012     C                   Parm                    WALERT
218700111012     C                   End
218800111012     C                   End
218900111012
219000200221     C                   ENDSR
219100200221
219200200221      //=======================================================================
219300200221      // update UHC files
219400200221      //=======================================================================
219500200221
219600200221       begsr updateUHC;
219700200224
219800200224        if not %open(uhcplancrt);
219900200224         open uhcplancrt;
220000220812        endif;
220001220812
220002220812        //pos = 0;
220003220812        //pos2 = 0;
220004220812        //pos3 = 0;
220100200221
220200200221        chain (grtrst : grsub# : grplan) plnauxr;
220300200221        if %found;
220400200221
220500200221         chain (grtrst : grsub# : pxacct : grplan) uhcPlncrt;
220600200221         if %found;
220700200221
220800200221          chain ('9000000290' : grtrst : grsub# : pxacct : grplan) uhcPlan;
220900200221          if %found;
221000200221
221100200221            select;
221200200221             when plncat = 'PDN';
221201220812
221202220812              #len = %len(%trim(group#));
221203220812              select;
221204220812               when #len = 15;
221205220812                cpcid5 = %subst(group#:11:5);
221206220812
221207220812               when #len = 14;
221208220812                cpcid5 = %subst(group#:10:5);
221209220812
221210220812               when #len = 13;
221211220812                cpcid5 = %subst(group#:9:5);
221213220812              endsl;
221214220812
221300220812              //pos3 = %scan('   ':group#:1);
221400220812              //pos2 = %scan('  ':group#:1);
221500220812              //pos = %scan(' ':group#:1);
221600200221
221700220812              //if pos3 > 0;
221800220812              // cpcid5 = %subst(group#:pos3 + 3 : 5);
221900220812              //  pos2 = 0;
222000220812              // pos = 0;
222100220812              //endif;
222200200221
222300220812              //if pos2 > 0;
222400220812              // cpcid5 = %subst(group#:pos2 + 2 : 5);
222500220812              // pos = 0;
222600220812              //endif;
222700200221
222800220812              //if pos > 0;
222900220812              // cpcid5 = %subst(group#:pos + 1 : 5);
223000220812              //endif;
223100200221
223200200221             when plncat = 'PDV' or plncat = 'PVS';
223201220812
223202220812              #len = %len(%trim(group#));
223203220812              select;
223204220812               when #len = 15;
223205220812                cpcid5 = %subst(group#:11:5);
223206220812
223207220812               when #len = 14;
223208220812                cpcid5 = %subst(group#:10:5);
223209220812
223210220812               when #len = 13;
223211220812                cpcid5 = %subst(group#:9:5);
223212220812              endsl;
223213220812
223300220812              //pos3 = %scan('   ':group#:1);
223400220812              //pos2 = %scan('  ':group#:1);
223500220812              //pos = %scan(' ':group#:1);
223600200221
223700220812              //if pos3 > 0;
223800220812              // cpcid5 = %subst(group#:pos3 + 3 : 5);
223900220812              //  pos2 = 0;
224000220812              // pos = 0;
224100220812              //endif;
224200200221
224300220812              //if pos2 > 0;
224400220812              // cpcid5 = %subst(group#:pos2 + 2 : 5);
224500220812              // pos = 0;
224600220812              //endif;
224700200221
224800220812              //if pos > 0;
224900220812              // cpcid5 = %subst(group#:pos + 1 : 5);
225000220812              //endif;
225100200221            endsl;
225200200221
225300200221            update uhcPlan;
225400200221
225500200221          endif;
225600200221         endif;
225700200221
225800200221        endif;
225900200224
226000200221        unlock carplnz;
226100200224        if %open(uhcplancrt);
226200200224         close uhcplancrt;
226300200224        endif;
226400200224
226500200221
226600200221       endsr;
226700200221
226800200221      //=======================================================================
226900200221
227000000210** CTDATA MSG
227100011009SUB IS BLANK OR INVALID FOR TRUST
227200000210PLAN# (TRUST/SUB/PLAN) IS INVALID
227300000210AGE BANDING INVALID FOR PLAN
227400000210COVERAGE TYPE INVALID
227500000831NET RATE MUST BE ENTERED
227600000831BILLING RATE MUST BE ENTERED
227700000210GROUP # IS BLANK
227800000210AGE RANGES INVALID
227900000210AGE BAND ENTERED IS INVALID
228000000210STATUS CODE MUST BE - A  OR  D
228100000210FROM DATE IS INVALID
228200000831FROM DATE (DAY) MUST EQUAL 01
228300001201TO DATE IS INVALID
228400001201TO DATE (DAY) IS INVALID
228500000210INVALID SELECTION
228600000920SELECT DATES W/"X"; CHANGE W/"C"
228700000210NEW DATE CHANGE ALREADY EXISTS
228800000210INVALID NEW FROM DATE
228900000210INVALID NEW TO DATE
229000001024OVERLAPPING RANGE OF DATES
229100001107BILL CANNOT = NET; UNLESS ZERO
229200011009NO SELECT FROM TRUST INQUIRY
229300011009NO SELECT FROM SUB INQUIRY
229400011009NO SELECT FROM PLAN INQUIRY
229500011009INVALID TRUST NUMBER
229600021002INVALID ADD, RECORD EXISTS
229700101011INVALID DELEGATED BILLING GROUP # FORMAT
229800150312F8 NOT VALID FOR PLAN TYPE, USE PAYROLL MENU
229900150407F9 NOT VALID FOR PLAN TYPE, USE PAYROLL MENU
230000150407F9 NOT VALID FOR PLAN TYPE
230100150415FUNCTION KEY NOT ALLOWED
230200000210** CTDATA DOM
230300001205312831303130313130313031
