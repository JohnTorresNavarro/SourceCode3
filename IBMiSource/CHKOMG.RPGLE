000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300090323    ? *  Description:  Check Onsite Dental Case Manager Data
000400000000    ? *
000500090224    ? *  (c)Copyright 2009 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000601070516    ? *
000900050318    ? *___________________________________________________________________
001000090323    ?FODCMGRP   IF   E           K DISK
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300090323    ?D WTM             S             80    DIM(13) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700090323    ?D WUDTA         E DS                  EXTNAME(ODCMGRP)
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
006940090323    ? *
006941090323    ? * Zip
006942090323    ? *
006943090323     C                   Move      CMZIP         Zip4              4
006944090323     C                   Movel     CMZIP         Zip5              5
006945090323     C                   If        Zip5     =    *Blanks  And
006946090323     C                             Zip4    <>    *Blanks
006947090323     C                   Move      'ERROR   '    WORTN
006948090323    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
006949090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006950090323     C                   Exsr      SNDMSG
006951090323     C                   Endif
006952090323     C                   If        Zip5    <>    *Blanks
006953090323     C                   TestN                   Zip5                 71
006954090323     C                   If        *In71    =    *Off
006955090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006956090323    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
006957090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006958090323     C                   Exsr      SNDMSG
006959090323     C                   End
006960090323     C                   End
006961090323     C                   If        Zip4    <>    *Blanks
006962090323     C                   TestN                   Zip4                 71
006963090323     C                   If        *In71    =    *Off
006964090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006965090323    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
006966090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006967090323     C                   Exsr      SNDMSG
006968090323     C                   Endif
006969090323     C                   End
006970090323    ? *
006971090323    ? * Phone #1
006972090323    ? *
006973090323     C                   If        CMPHN1  <>    *Blanks
006974090323     C                   TestN                   CMPHN1               72
006975090323     C                   If        *In72    =    *Off
006976090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006977090323    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
006978090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006979090323     C                   Exsr      SNDMSG
006980090323     C                   Endif
006981090323     C                   End
006982090323    ? *
006983090323    ? * Phone #2
006984090323    ? *
006985090323     C                   If        CMPHN2  <>    *Blanks
006986090323     C                   TestN                   CMPHN2               73
006987090323     C                   If        *In73    =    *Off
006988090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006989090323    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
006990090323    ?C                   Exsr      SNDMSG                                       SEND MSG
006991090323     C                   Exsr      SNDMSG
006992090323     C                   Endif
006993090323     C                   End
006994090323    ? *
006995090323    ? * Phone #3
006996090323    ? *
006997090323     C                   If        CMPHN3  <>    *Blanks
006998090323     C                   TestN                   CMPHN3               74
006999090323     C                   If        *In74    =    *Off
007000090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007001090323    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
007002090323    ?C                   Exsr      SNDMSG                                       SEND MSG
007003090323     C                   Exsr      SNDMSG
007004090323     C                   Endif
007005090323     C                   End
007006090323    ? *
007007090323    ? * Fax
007008090323    ? *
007009090323     C                   If        CMFAX   <>    *Blanks
007010090323     C                   TestN                   CMFAX                75
007011090323     C                   If        *In75    =    *Off
007012090323    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007013090323    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
007014090323    ?C                   Exsr      SNDMSG                                       SEND MSG
007015090323     C                   Exsr      SNDMSG
007016090323     C                   Endif
007017090323     C                   End
007018070516    ? *
007019090305    ? * Email Address
007020090323     C                   If        CMEMAL  <>    *Blanks
007021090305     C                   Z-add     *Zeros        PosDot            2 0
007022090305     C                   Z-add     *Zeros        Pos@              2 0
007023090323     C                   Eval      Pos@     = %Scan('@':CMEMAL)
007024090323     C                   Eval      PosDot   = %Scan('.':CMEMAL)
007025090305     C                   If        Pos@     = *Zeros   Or
007026090305     C                             PosDot   = *Zeros
007027070516    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007028090323    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
007029070516    ?C                   Exsr      SNDMSG                                       SEND MSG
007030070518     C                   Exsr      SNDMSG
007031090224     C                   Endif
007032090323     C                   End
007033090326    ? *
007034090326    ? * EFFECTIVE DATE
007035090326     C                   If        CMEFF  = *ZEROS
007036090326    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007037090326    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
007038090326    ?C                   Exsr      SNDMSG                                       SEND MSG
007039090326     C                   Else
007040090326     C                   Movel     CMEFF         Input_Date
007041090326     C                   Exsr      EDTDAT
007042090326     C                   If        Output_Error <> *Blanks
007043090326    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007044090326    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
007045090326    ?C                   Exsr      SNDMSG                                       SEND MSG
007046090326     C                   Endif
007047090326     C                   Endif
007048090326    ? *
007049090326    ? * TERM DATE
007050090326     C                   If        CMTRM  <> *ZEROS
007051090326     C                   Movel     CMTRM         Input_Date
007052090326     C                   Exsr      EDTDAT
007053090326     C                   If        Output_Error <> *Blanks
007054090326    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007055090326    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
007056090326    ?C                   Exsr      SNDMSG                                       SEND MSG
007057090326     C                   Else
007058090326    ? *
007059090326    ? * TERM DATE > EFF DATE
007060090326     C                   If        CMEFF  <> *ZEROS and
007061090326     C                             CMTRM  <> *ZEROS
007062090326     C     CMEFF         Mult      10000.0001    WWBEDT            8 0
007063090326     C     CMTRM         Mult      10000.0001    WWENDT            8 0
007064090326     C                   If        WWBEDT  > WWENDT
007065090326    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007066090326    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
007067090326    ?C                   Exsr      SNDMSG                                       SEND MSG
007068090326     C                   Endif
007069090326     C                   Endif
007070090326     C                   Endif
007071090326     C                   Endif
007072070518    ? *
007080000000    ?C                   Endsr                                                  END EDIT RECORD
007081010301    ? *___________________________________________________________________
007082010301    ? * format Date edit
007083010301    ? *___________________________________________________________________
007084010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007085010301     C                   movel     'MMDDYYYY'    Input_Format
007086010301     C                   Call      'FMTDATE'
007087010301     C                   Parm                    Input_Date       32
007088010301     C                   Parm                    Input_Format     32
007089010301     C                   Parm                    Output_Format    32
007090010301     C                   Parm                    Output_Date      32
007091010301     C                   Parm                    Output_Error     10
007092010301    ?C                   Endsr                                                  END DLT RQST
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
01290009032300Request not supported by program CHKOMG
013000000117** WTM
01310009030561Begin date must be a valid date.
01330009030562End date must be a valid date.
01340009022463You must enter a valid date.
01360007051864End Date cannot be less than Begin Date.
01370009030565error message goes here
01370109032371Zip must be numeric or blank.
01370209032372Phone #1 must be numeric or blank.
01370309032373Phone #2 must be numeric or blank.
01370409032374Phone #3 must be numeric or blank.
01370509032375Fax must be numeric or blank.
01370609030576Email address must be entered in email-address format.
01390009030577You must enter a valid case manager.
01400009030568Error message goes here
