000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300070524    ? *  Description:  Check Online Forms Plan
000400000000    ? *
000500070523    ? *  (c)Copyright 2007 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000601070612     FOLFSTATP  IF   E           K DISK
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900070613    ?D WTM             S             80    DIM(15) CTDATA PERRCD(1)             ERROR MESSAGE TBL
000901070612    ?D STA             S             20A   INZ                                  ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300070524    ?D WUDTA         E DS                  EXTNAME(OLFPLANP)
001301070613     D  OPSTATE               78     97    DIM(10)
001400000810    ? *
001500000000    ? * Program status data structure
001600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001700000000    ? *___________________________________________________________________
001800000000    ? * Process check request
001900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002000000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002100000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002200000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002300000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002400000000    ?C                   Endcs                                                  END CASE
002500000000    ?C                   Return                                                 RETURN
002600000000    ? *___________________________________________________________________
002700000000    ? * Edit record
002800000000    ? *___________________________________________________________________
002900000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003000000810    ? *
003100000810    ? * Defualt Data
003200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003300010219    ? *
003400070523    ? * TYPE
003500070524     C                   If        OPCARC = *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003900010219     C                   Endif
004000010220    ? *
004100070524    ? * COVG
004200070524     C                   If        OPTYPC = *BLANKS
004300010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500010220    ?C                   Exsr      SNDMSG                                       SEND MSG
004600010220     C                   Endif
004601070523    ? *
004602070523    ? * DESCRIPTION.
004603070524     C                   If        OPPLAN = *BLANKS
004604070523    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004605070523    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
004606070523    ?C                   Exsr      SNDMSG                                       SEND MSG
004607070523     C                   Endif
004608070612    ? *
004609070613    ? * TIER or HEAD.
004610070612     C                   If        OPTIER = 0  AND
004611070613     C                             OPHEAD = *BLANKS
004612070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004613070613    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004614070612    ?C                   Exsr      SNDMSG                                       SEND MSG
004615070612     C                   Endif
004616070613    ? *
004617070613    ? * TIER or TEXT.
004618070613     C                   If        OPTIER = 0  AND
004619070613     C                             OPTEXT = *BLANKS
004620070613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004621070613    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
004622070613    ?C                   Exsr      SNDMSG                                       SEND MSG
004623070613     C                   Endif
004624070612    ? *
004625070612    ? * STATES
004626070612     C                   If        OPST01 <> *BLANKS
004627070612     C     OPST01        CHAIN     OLFSTATP
004628070612     C                   If        not %found
004629070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004630070613    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
004631070612    ?C                   Exsr      SNDMSG                                       SEND MSG
004632070612     C                   End
004633070612     C                   End
008600000810    ? *
008601070612     C                   If        OPST02 <> *BLANKS
008602070612     C     OPST02        CHAIN     OLFSTATP
008603070612     C                   If        not %found
008604070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008605070613    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
008606070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008607070612     C                   End
008608070612     C                   End
008609070612    ? *
008610070612     C                   If        OPST03 <> *BLANKS
008611070612     C     OPST03        CHAIN     OLFSTATP
008612070612     C                   If        not %found
008613070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008614070613    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
008615070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008616070612     C                   End
008617070612     C                   End
008618070612    ? *
008619070612     C                   If        OPST04 <> *BLANKS
008620070612     C     OPST04        CHAIN     OLFSTATP
008621070612     C                   If        not %found
008622070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008623070613    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
008624070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008625070612     C                   End
008626070612     C                   End
008627070612    ? *
008628070612     C                   If        OPST05 <> *BLANKS
008629070612     C     OPST05        CHAIN     OLFSTATP
008630070612     C                   If        not %found
008631070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008632070613    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
008633070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008634070612     C                   End
008635070612     C                   End
008636070612    ? *
008637070612     C                   If        OPST06 <> *BLANKS
008638070612     C     OPST06        CHAIN     OLFSTATP
008639070612     C                   If        not %found
008640070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008641070613    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
008642070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008643070612     C                   End
008644070612     C                   End
008645070612    ? *
008646070612     C                   If        OPST07 <> *BLANKS
008647070612     C     OPST07        CHAIN     OLFSTATP
008648070612     C                   If        not %found
008649070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008650070613    ?C                   Move      WTM(12)       WWMSG                          PASS MSG
008651070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008652070612     C                   End
008653070612     C                   End
008654070612    ? *
008655070612     C                   If        OPST08 <> *BLANKS
008656070612     C     OPST08        CHAIN     OLFSTATP
008657070612     C                   If        not %found
008658070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008659070613    ?C                   Move      WTM(13)       WWMSG                          PASS MSG
008660070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008661070612     C                   End
008662070612     C                   End
008663070612    ? *
008664070612     C                   If        OPST09 <> *BLANKS
008665070612     C     OPST09        CHAIN     OLFSTATP
008666070612     C                   If        not %found
008667070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008668070613    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
008669070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008670070612     C                   End
008671070612     C                   End
008672070612    ? *
008673070612     C                   If        OPST10 <> *BLANKS
008674070612     C     OPST10        CHAIN     OLFSTATP
008675070612     C                   If        not %found
008676070612    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008677070613    ?C                   Move      WTM(15)       WWMSG                          PASS MSG
008678070612    ?C                   Exsr      SNDMSG                                       SEND MSG
008679070612     C                   End
008680070612     C                   End
008681070612    ? *
008700000000    ?C                   Endsr                                                  END EDIT RECORD
008800010220    ? *___________________________________________________________________
008900010220    ? * format Date edit
009000010220    ? *___________________________________________________________________
009100010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
009200010220     C                   movel     'MMDDYYYY'    Input_Format
009300010220     C                   Call      'FMTDATE'
009400010220     C                   Parm                    Input_Date       32
009500010220     C                   Parm                    Input_Format     32
009600010220     C                   Parm                    Output_Format    32
009700010220     C                   Parm                    Output_Date      32
009800010220     C                   Parm                    Output_Error     10
009900010220    ?C                   Endsr                                                  END DLT RQST
010000000000    ? *___________________________________________________________________
010100000000    ? * Edit delete request
010200000000    ? *___________________________________________________________________
010300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
010400000000    ?C                   Endsr                                                  END DLT RQST
010500000000    ? *___________________________________________________________________
010600000000    ? * Default data
010700000000    ? *___________________________________________________________________
010800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
010801070612     C                   Movea     OPSTATE       STA
010802070612     C                   If        %TRIM(STA)  = *BLANKS
010803070612     C                   Eval      OPST01      = '**'
010804070612     C                   End
010900000000    ?C                   Endsr                                                  END DFT DATA
011000000000    ? *___________________________________________________________________
011100000000    ? * Send messages
011200000000    ? *___________________________________________________________________
011300000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
011400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
011500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
011600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
011700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
011800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
011900000000    ?C                   Endsr                                                  END SND ERRMSG
012000000000    ? *___________________________________________________________________
012100000000    ? * Process error
012200000000    ? *___________________________________________________________________
012300000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
012400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
012600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
012700000000    ?C                   Endsr                                                  END PRCERR
012800000000    ? *___________________________________________________________________
012900000000    ? * Parameter list
013000000000    ? *___________________________________________________________________
013100000000    ?C     PLIST         Begsr                                                  PARM LISTS
013200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
013300000000    ?C                   Parm                    WIRQS             8            REQUEST
013400000000    ?C                   Parm                    WORTN             8            RETURN CODE
013500000614    ?C                   Parm                    WUDTA                          DATA
013600000000    ?C                   Endsr                                                  END PLIST
013700000000    ? *___________________________________________________________________
013800000000    ? * Define Variables and Key Lists
013900000000    ? *___________________________________________________________________
014000000000    ?C     DEFN          Begsr                                                  PARM LISTS
014100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
014200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
014300000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
014400000000    ?C                   Endsr                                                  END DEFN
014500000000    ? *___________________________________________________________________
014600000000    ? * Program error handler
014700000000    ? *___________________________________________________________________
014800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
014900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
015000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
015100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
015200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
015300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
015400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
015500000000    ? *___________________________________________________________________
015600000112** WTMP
01570000000000T-Record is not eligible for deletion.
01580007052400Request not supported by program CHKOLP.
015900000117** WTM
01590107052461Online Form Carrier Type must be valid.
01600007052462Online Form Coverage Type must be valid.
01600107061263Please enter a Plan Description.
01600207061364Non-Tiered Plans REQUIRE Text Heading.
01610007061365Non-Tiered Plans REQUIRE Text Description.
01620007061266Please enter a Valid State Code
01630007061267Please enter a Valid State Code
01640007061268Please enter a Valid State Code
01650007061269Please enter a Valid State Code
01660007061269Please enter a Valid State Code
01670007061269Please enter a Valid State Code
01680007061269Please enter a Valid State Code
01690007061269Please enter a Valid State Code
01700007061269Please enter a Valid State Code
01710007061269Please enter a Valid State Code
