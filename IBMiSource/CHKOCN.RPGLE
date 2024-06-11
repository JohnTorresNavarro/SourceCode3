000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300090305    ? *  Description:  Check Onsite Dental Contact Data
000400000000    ? *
000500090224    ? *  (c)Copyright 2009 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000601070516    ? *
000900050318    ? *___________________________________________________________________
000901090319    ?FODCNTCP   IF   E           K DISK
001000090319    ?FODCCTL2   IF   E           K DISK
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300090323    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001401100726     D WWTRST          S              3S 0 inz
001500000000    ? *
001600000614    ? * Data structure
001700090305    ?D WUDTA         E DS                  EXTNAME(ODCNTCP)
002100000810    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000    ? *___________________________________________________________________
003200000000    ? * Process check request
003300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003400000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003500000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003600000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003700000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003800000000    ?C                   Endcs                                                  END CASE
003900000000    ?C                   Return                                                 RETURN
004000000000    ? *___________________________________________________________________
004100000000    ? * Edit record
004200000000    ? *___________________________________________________________________
004300000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
004400000810    ? *
004500000810    ? * Defualt Data
004600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
004601090319    ? *
004605090319    ?C     WKCCOD        Klist                                                  AGENCY
004606100726    ?C                   Kfld                    WWTRST                         POSITION TO 1
004607090319    ?C                   Kfld                    OCCCOD                         POSITION TO 1
004608100726    ?C                   Eval      WWTRST = 999                                 POSITION TO 1
004609090319     C                   Move      *blanks       CODFLG            1
004610090319    ? * Validate Code
004611090319     C     WKCCOD        Setll     ODCCTL2                                      PSN DB CURSOR
004612090319     C     WKCCOD        Reade     ODCCTL2                                50    READ FILE
004613090319     C                   Dow       not %eof(ODCCTL2)                            IF RECORD READ
004614100726     C                   If        OCACCT <> 0   AND
004615100726     C                             CCACCT = 9999 OR
004616100726     C                             OCACCT = 0    AND
004617100726     C                             CCACCT = 0000
004626090319     C                   Eval      CODFLG = 'Y'
004627090319     C                   Leave
004628090319     C                   End                                                    END IF REC READ
004629090319     C     WKCCOD        Reade     ODCCTL2                                50    READ FILE
004630090319     C                   Enddo                                                  END DO
004631090319    ? *
004632090319    ? * If none found, invalid code entity
004633090319     C                   If        CODFLG = *BLANKS
004634090319    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004635090319    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004636090319    ?C                   Exsr      SNDMSG                                       SEND MSG
004637090319     C                   End
006900000810    ? *
006902010301    ? * EFFECTIVE DATE
006903090305     C                   If        OCEFF  = *ZEROS
006904050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006905090224    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
006906050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006907050318     C                   Else
006908090305     C                   Movel     OCEFF         Input_Date
006909050318     C                   Exsr      EDTDAT
006910050318     C                   If        Output_Error <> *Blanks
006911050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006912090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006913050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006914050318     C                   Endif
006915050318     C                   Endif
006916010301    ? *
006917010301    ? * TERM DATE
006918090305     C                   If        OCTRM  <> *ZEROS
006919090305     C                   Movel     OCTRM         Input_Date
006920050318     C                   Exsr      EDTDAT
006921050318     C                   If        Output_Error <> *Blanks
006922050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006923090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006924050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006925050318     C                   Else
006926010301    ? *
006927010301    ? * TERM DATE > EFF DATE
006928090305     C                   If        OCEFF  <> *ZEROS and
006929090305     C                             OCTRM  <> *ZEROS
006930090305     C     OCEFF         Mult      10000.0001    WWBEDT            8 0
006931090305     C     OCTRM         Mult      10000.0001    WWENDT            8 0
006932050318     C                   If        WWBEDT  > WWENDT
006933050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006934050318    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006935050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006936050318     C                   Endif
006937050318     C                   Endif
006938050318     C                   Endif
006939050318     C                   Endif
006940090323    ? *
006941090323    ? * Zip
006942070516    ? *
006943090323     C                   Move      OCZIP         Zip4              4
006944090323     C                   Movel     OCZIP         Zip5              5
006945090323     C                   If        Zip5     =    *Blanks  And
006946090323     C                             Zip4    <>    *Blanks
006947090323     C                   Move      'ERROR   '    WORTN
006948090323    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006949090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006950090323     C                   Exsr      SNDMSG
006951090323     C                   Endif
006952090323     C                   If        Zip5    <>    *Blanks
006953090323     C                   TestN                   Zip5                 71
006954090323     C                   If        *In71    =    *Off
006955090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006956090323    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006957090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006958090323     C                   Exsr      SNDMSG
006959090323     C                   End
006960090323     C                   End
006961090323     C                   If        Zip4    <>    *Blanks
006962090323     C                   TestN                   Zip4                 71
006963090323     C                   If        *In71    =    *Off
006964090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006965090323    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006966090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006967090323     C                   Exsr      SNDMSG
006968090323     C                   Endif
006969090323     C                   End
006970090323    ? *
006971090323    ? * Phone #1
006972090323    ? *
006973090323     C                   If        OCPHN1  <>    *Blanks
006974090323     C                   TestN                   OCPHN1               72
006975090323     C                   If        *In72    =    *Off
006976090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006977090323    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
006978090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006979090323     C                   Exsr      SNDMSG
006980090323     C                   Endif
006981090323     C                   End
006982090323    ? *
006983090323    ? * Phone #2
006984090323    ? *
006985090323     C                   If        OCPHN2  <>    *Blanks
006986090323     C                   TestN                   OCPHN2               73
006987090323     C                   If        *In73    =    *Off
006988090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006989090323    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
006990090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006991090323     C                   Exsr      SNDMSG
006992090323     C                   Endif
006993090323     C                   End
006994090323    ? *
006995090323    ? * Phone #3
006996090323    ? *
006997090323     C                   If        OCPHN3  <>    *Blanks
006998090323     C                   TestN                   OCPHN3               74
006999090323     C                   If        *In74    =    *Off
007000090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007001090323    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
007002090323    ?C                   Exsr      SNDMSG                                       SEND MSG
007003090323     C                   Exsr      SNDMSG
007004090323     C                   Endif
007005090323     C                   End
007006090323    ? *
007007090323    ? * Fax
007008090323    ? *
007009090323     C                   If        OCFAX   <>    *Blanks
007010090323     C                   TestN                   OCFAX                75
007011090323     C                   If        *In75    =    *Off
007012090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007013090323    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
007014090323    ?C                   Exsr      SNDMSG                                       SEND MSG
007015090323     C                   Exsr      SNDMSG
007016090323     C                   Endif
007017090323     C                   End
007018090305    ? * Email Address
007019090323     C                   If        OCEMAL  <>    *Blanks
007020090305     C                   Z-add     *Zeros        PosDot            2 0
007021090305     C                   Z-add     *Zeros        Pos@              2 0
007022090305     C                   Eval      Pos@     = %Scan('@':OCEMAL)
007023090305     C                   Eval      PosDot   = %Scan('.':OCEMAL)
007024090305     C                   If        Pos@     = *Zeros   Or
007025090305     C                             PosDot   = *Zeros
007026070516    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007027090305    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
007028070516    ?C                   Exsr      SNDMSG                                       SEND MSG
007029070518     C                   Exsr      SNDMSG
007030090224     C                   Endif
007031090323     C                   End
007032010301    ? *
007033000000    ?C                   Endsr                                                  END EDIT RECORD
007034010301    ? *___________________________________________________________________
007035010301    ? * format Date edit
007036010301    ? *___________________________________________________________________
007037010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007038010301     C                   movel     'MMDDYYYY'    Input_Format
007039010301     C                   Call      'FMTDATE'
007040010301     C                   Parm                    Input_Date       32
007041010301     C                   Parm                    Input_Format     32
007042010301     C                   Parm                    Output_Format    32
007043010301     C                   Parm                    Output_Date      32
007044010301     C                   Parm                    Output_Error     10
007045010301    ?C                   Endsr                                                  END DLT RQST
007100000000    ? *___________________________________________________________________
007200000000    ? * Edit delete request
007300000000    ? *___________________________________________________________________
007400000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007500000000    ?C                   Endsr                                                  END DLT RQST
007600000000    ? *___________________________________________________________________
007700000000    ? * Default data
007800000000    ? *___________________________________________________________________
007900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
008000000000    ?C                   Endsr                                                  END DFT DATA
008100000000    ? *___________________________________________________________________
008200000000    ? * Send messages
008300000000    ? *___________________________________________________________________
008400000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
008500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
009000000000    ?C                   Endsr                                                  END SND ERRMSG
009100000000    ? *___________________________________________________________________
009200000000    ? * Process error
009300000000    ? *___________________________________________________________________
009400000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
009500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009800000000    ?C                   Endsr                                                  END PRCERR
009900000000    ? *___________________________________________________________________
010000000000    ? * Parameter list
010100000000    ? *___________________________________________________________________
010200000000    ?C     PLIST         Begsr                                                  PARM LISTS
010300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
010400000000    ?C                   Parm                    WIRQS             8            REQUEST
010500000000    ?C                   Parm                    WORTN             8            RETURN CODE
010600000614    ?C                   Parm                    WUDTA                          DATA
010700000000    ?C                   Endsr                                                  END PLIST
010800000000    ? *___________________________________________________________________
010900000000    ? * Define Variables and Key Lists
011000000000    ? *___________________________________________________________________
011100000000    ?C     DEFN          Begsr                                                  PARM LISTS
011200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
011300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
011400000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
011500000000    ?C                   Endsr                                                  END DEFN
011600000000    ? *___________________________________________________________________
011700000000    ? * Program error handler
011800000000    ? *___________________________________________________________________
011900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
012000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
012100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
012200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012600000000    ? *___________________________________________________________________
012700000112** WTMP
01280000000000T-Record is not eligible for deletion.
01290009032300Request not supported by program CHKOCN
013000000117** WTM
01310009030561Begin date must be a valid date.
01330009030562End date must be a valid date.
01340009032363
01340109031964Contact Type Code must be valid for this entity
01370009032371Zip must be numeric or blank.
01370109032372Phone #1 must be numeric or blank.
01370209032373Phone #2 must be numeric or blank.
01370309032374Phone #3 must be numeric or blank.
01370409032375Fax must be numeric or blank.
01370509030576Email address must be entered in email-address format.
01390009030577You must enter a valid case manager.
