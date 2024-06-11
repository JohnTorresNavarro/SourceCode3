000100000000      *_________________________________________________________________________
000200000000      *
000300110712      *  Description: Check Account SDE Codes
000400000000      *
000500110712      *  (C)COPYRIGHT 2011 BY GROUP BENEFIT SERVICES, INC.
000501180212      * 02/12/18 dlk - make this pgm work for Senior Dental or Advanced
000502180212      *                Mobile based on parm in LDA from WRKSDE.
000600000000      *___________________________________________________________________
000700110712     FSDEXCL    if   e           k disk
000701110712     FCODES     IF   E           K Disk
000702110713     FTRSMST    IF   E           K Disk
000703110713     FSUBMST    IF   E           K Disk
000704110713     FACCMST    IF   E           K Disk
000800000000      *
000900110712    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001000110713    ?D WTM             S             80    DIM(7) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001100000000      *
001200000000      *___________________________________________________________________
001300000000      *
001400000000      * Data structure
001500110712    ?D WUDTA         E DS                  EXTNAME(SDEXCL)
001600000000      *
001700000000      * Program status data structure
001800000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000      *
001901061129      * RETREIVE JOB ATTRIBUTES API DATA STRUCTURE
001902061129     D WDJOBA          DS                  INZ
001903061129     D  WDJUSR                19     28
002000000000      *
002001061129     D                 DS
002002061129     D  WDRCVL                 1      4B 0 INZ(86)
002003061129      *
002100021008     D WIFKV           S             60A
002200021008     D WIFKY           S                   LIKE(WIFKV)
002300021008     D WIOPV           S                   LIKE(WIFKV)
002400021008     D WIRQS           S              8A
002500021008     D WORTN           S              8A
002600021008     D WUPGM           S             10A
002700021008     D WWCHG           S              1A
002800021008     D WWDLT           S              1A
002900021008     D WWDTAQ          S             10A
003000021008     D WWENDF          S              3A
003100021008     D WWENDO          S                   LIKE(WWENDF)
003200021008     D WWERR           S              1A
003300021008     D WWFIL           S             10A
003400021008     D WWFKA           S              8A
003500021008     D WWFKV           S                   LIKE(WIFKV)
003600021008     D WWFKY           S                   LIKE(WIFKV)
003700021008     D WWFLK           S            128A
003800021008     D WWFMTN          S              8A
003900021008     D WWFNC           S              8A
004000021008     D WWIJI           S             16A
004100021008     D WWIN            S             99A
004200021008     D WWLIB           S             10A
004300021008     D WWMSG           S             80A
004400021008     D WWMSGC          S              7A
004500021008     D WWOCD           S              8A
004600021008     D WWOPA           S              8A
004700021008     D WWOPN           S              1A
004800021008     D WWOPT           S              8A
004900021008     D WWOPV           S                   LIKE(WIFKV)
005000021008     D WWORQS          S                   LIKE(WIRQS)
005100021008     D WWPSNC          S              1A
005200021008     D WWQJN           S             26A
005300021008     D WWRQS           S                   LIKE(WIRQS)
005400021008     D WWRQSD          S                   LIKE(WIRQS)
005500021008     D WWRTN           S                   LIKE(WORTN)
005600021008     D WWRTND          S                   LIKE(WORTN)
005700021008     D WWRTNH          S                   LIKE(WORTN)
005800021008     D WWSFLE          S              1A
005900021008     D WWSTT           S              3A
006000021008     D WWTSK           S              8A
006100021008     D WWTXT           S             60A
006200021008     D WWUPD           S              1A
006300021008     D WWWRNF          S              1A
006400021008     D WWZERO          S             40A
006500021008     D WFRRN           S              4P 0
006600021008     D WW              S              3P 0
006700021008     D WWFKS           S              1P 0
006800021008     D WWFKSO          S                   LIKE(WWFKS)
006900021008     D WWLMT           S              2P 0
007000021008     D WWLNG           S             15P 5
007100021008     D WWLNGQ          S              5P 0
007200021008     D WWLOWR          S              4P 0
007300021008     D WWLSTS          S              2P 0
007400021008     D WWOPS           S              1P 0
007500021008     D WWOPSO          S                   LIKE(WWOPS)
007600021008     D WWPNL           S              1P 0
007700021008     D WWPNLN          S                   LIKE(WWPNL)
007800021008     D WWPNLO          S                   LIKE(WWPNL)
007900021008     D WWPSNI          S              2P 0
008000021008     D WWPSNN          S              1P 0
008100021008     D WWPSNP          S                   LIKE(WWPSNN)
008200021008     D WWRRN           S              4P 0
008201180213     D cmp_tscode      S                   LIKE(tscode)
008202180212
008203180212      * LDA
008204180212     D                UDS
008205180212     D  lclient                1      1
008300000000      *
008400000000      *___________________________________________________________________
008500000000      * Process check request
008600000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008700040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
008800040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
008900000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009000000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009100000000     C                   Cas                     PRCERR                         REQUEST ERROR
009200000000     C                   Endcs                                                  END CASE
009300000000    ?C                   Return                                                 RETURN
009400000000      *___________________________________________________________________
009500040305      * Edit record - ADD
009600000000      *___________________________________________________________________
009700040305     C     EDTADD        Begsr                                                  EDIT RECORD
009800000000      *
009900040305     C                   EXSR      $COMMON
010000040305      *
010100040305     C                   Endsr                                                  END DLT RQST
010200040305      *___________________________________________________________________
010300040305      * Edit record - COMMON EDITS
010400040305      *___________________________________________________________________
010500040305     C     $COMMON       Begsr                                                  EDIT RECORD
010501110713    ? *
010502180213    ? * Senior Dental or Advanced Mobile
010503110713    ? *
010504110713     C     SLTRST        Chain     TRSMST
010505110713     C                   If        %Found(TRSMST)
010506110713     C                   Else
010507180213     C                   If        TSCODE <> cmp_tscode
010508110713    ?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
010509110713    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
010510110713    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
010511110713     C                   End
010512110713     C                   End
010513110713    ? * Subdivision
010514110713    ? *
010515110713     C     SubKey        Chain     SUBMST
010516110713     C                   If        %Found(SUBMST)
010517110713     C                   Else
010518110713    ?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
010519110713    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
010520110713    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
010521110713     C                   End
010522110713    ? * Account
010523110713    ? *
010524110713     C     AccKey        Chain     ACCMST
010525110713     C                   If        %Found(ACCMST)
010526110713     C                   Else
010527110713    ?C                   Movel     WTM(7)        WWMSG                          PASS MESSAGE
010528110713    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
010529110713    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
010530110713     C                   End
010531110713    ? *
011801110712    ? * Coverage Month & Year must be valid.
011802110712     C                   If        SLDEMM  >     *Zero  And
011803110712     C                             SLDEMM  <     13
011805110712     C                   Else
011806110712    ?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
011807110712    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
011808110712    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
011809110712    ?C                   Endif                                                  END ERROR
011810110712
011811110712     C                   If        SLDEYY  >     1999   And
011812110712     C                             SLDEYY  <     2050
011814110712     C                   Else
011815110712    ?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
011816110712    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
011817110712     C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
011818110712    ?C                   Endif                                                  END ERROR
011819110712    ? *
011820110712    ? * Verify that the Reason Code exists in the CODES file with a V type.
011822110712    ?C     CodKey        Klist                                                  ACKCTL
011823110712    ?C                   Kfld                    KType
011824110712    ?C                   Kfld                    SLRECD
011825110712     C     CodKey        Chain     CODES
011826110712    ?C                   If        Not %Found(CODES)                            IF ENTERED
011827110712    ?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
011828110712    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
011829110712    ?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
011830110727    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
011831110712     C                   End
012700000000     C                   Endsr                                                  END DLT RQST
012800040305      *___________________________________________________________________
012900040305      * Edit record - CHANGE
013000040305      *___________________________________________________________________
013100040305     C     EDTCHG        Begsr                                                  EDIT RECORD
013200040305      *
013300040305      *
013400040305     C                   EXSR      $COMMON
013500040305      *
013600040305     C                   Endsr                                                  END DLT RQST
013700000000      *___________________________________________________________________
013800000000      * Edit delete request
013900000000      *___________________________________________________________________
014000000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
014001110712    ?C     ExlKey        Klist                                                  ACKCTL
014002110712    ?C                   Kfld                    SLTRST
014003110712    ?C                   Kfld                    SLSUB#
014004110712    ?C                   Kfld                    SLACCT
014005110712    ?C                   Kfld                    SLDEYY
014006110712    ?C                   Kfld                    SLDEMM
014100110712     c     ExlKey        chain     SDEXCLR
014200110712     c                   if        %found(SDEXCL)
014300040518    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
014400040518    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014500040518    ?C                   Exsr      SNDMSG                                       SEND MSG
014600040518     c                   endif
014700000000     C                   Endsr                                                  END DLT RQST
014800000000      *___________________________________________________________________
014900000000      * Default data
015000000000      *___________________________________________________________________
015100000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
015101061129      * RETRIEVE JOB ATTRIBUTES
015102061129     C                   Call      'QUSRJOBI'                                   RTV JOB INFO
015103061129     C                   Parm                    WDJOBA                         RECEIVER VAR
015104061129     C                   Parm                    WDRCVL                         RECEIVER LENGTH
015105061129     C                   Parm      'JOBI0100'    WWFMTN                         FORMAT NAME
015106061129     C                   Parm      '*'           WWQJN                          QUAL JOB NAME
015107061129     C                   Parm                    WWIJI                          INTERNAL JOB ID
015108061129      *
015200110712     c                   Eval      SLCHDT    =   Today
015201110712     C                   Eval      SLUSER    =   WDJUSR
015300000000     C                   Endsr                                                  END DFT DATA
015400000000      *___________________________________________________________________
015500000000      * Send messages
015600000000      *___________________________________________________________________
015700000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
015800000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
015900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
016000000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
016100000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
016200000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
016300000000     C                   Endsr                                                  END SND ERRMSG
016400000000      *___________________________________________________________________
016500000000      * Process error
016600000000      *___________________________________________________________________
016700000000     C     PRCERR        Begsr                                                  PROCESS ERROR
016800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016900000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
017000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
017100000000     C                   Endsr                                                  END PRCERR
017200000000      *___________________________________________________________________
017300000000      * Parameter list
017400000000      *___________________________________________________________________
017500000000     C     PLIST         Begsr                                                  PARM LISTS
017600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
017700000000    ?C                   Parm                    WIRQS                          REQUEST
017800000000    ?C                   Parm                    WORTN                          RETURN CODE
017900000000    ?C                   Parm                    WUDTA                          DATA
018000000000     C                   Endsr                                                  END PLIST
018100000000      *___________________________________________________________________
018200000000      * Define Variables and Key Lists
018300000000      *___________________________________________________________________
018400000000     C     *INZSR        Begsr
018500000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
018501061129     C     *DATE         Mult      10000.0001    Today             8 0
018502110712     C                   Movel     'V'           KType             1
018503180213
018504180213      * set senior dental or advanced mobile trust category based on lda
018505180213      * value lclient which says what menu it was called from
018506180213
018507180213       if lclient = 'S';
018508180213        cmp_tscode = 'O N';
018509180213       else;
018510180213        cmp_tscode = 'O M';
018511180213       endif;
018512180213
018513180213
018600000000     C                   Endsr                                                  END DEFN
018601110713      *___________________________________________________________________
018602110713      * Key lists
018603110713      *___________________________________________________________________
018604110713     C     KLIST         Begsr                                                  KEY LISTS
018609110713     C     AccKey        Klist                                                  ACKCTL
018610110713     C                   Kfld                    SLTRST                         POSITION TO 1
018611110713     C                   Kfld                    SLSUB#                         POSITION TO 1
018612110713     C                   Kfld                    SLACCT                         POSITION TO 1
018613110713     C     SubKey        Klist                                                  ACKCTL
018614110713     C                   Kfld                    SLTRST                         POSITION TO 1
018615110713     C                   Kfld                    SLSUB#                         POSITION TO 1
018616110713     C                   Endsr                                                  END KLIST
018700000000      *___________________________________________________________________
018800000000      * Program error handler
018900000000      *___________________________________________________________________
019000000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
019100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
019200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
019300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
019400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
019500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
019600000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
019700020228      *___________________________________________________________________
019800000000** WTMP
01990000000000T-Record is not eligible for deletion.
02000011071200Request not supported by program CHKSDE.
020100000000** WTM
02020011071361Please enter a valid Senior Dental Trust.
02020111071362Please enter a valid Month.
02030011071263Please enter a valid Year.
02040011072564Please enter a valid Reason Code.
02050011071365
02060011071366Please enter a valid Subdivision.
02070011071367Please enter a valid account.
