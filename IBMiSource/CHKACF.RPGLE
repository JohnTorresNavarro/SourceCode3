000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300090319    ? *  Description:  Check ACH Supplemental Data from Finance Menu
000400000000    ? *
000500090224    ? *  (c)Copyright 2009 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000601070516    ? *
000900050318    ? *___________________________________________________________________
001000090224    ?FACCACH    IF   E           K DISK
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300090304    ?D WTM             S             80    DIM(9) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700090224    ?D WUDTA         E DS                  EXTNAME(ACCACH)
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
004601010219    ? *
004700000810    ? *
006900000810    ? *
006902010301    ? * EFFECTIVE DATE
006903090224     C                   If        AHBEDT = *ZEROS
006904050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006905090224    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
006906050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006907050318     C                   Else
006908090224     C                   Movel     AHBEDT        Input_Date
006909050318     C                   Exsr      EDTDAT
006910050318     C                   If        Output_Error <> *Blanks
006911050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006912090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006913050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006914050318     C                   Endif
006915050318     C                   Endif
006916010301    ? *
006917010301    ? * TERM DATE
006918090224     C                   If        AHENDT <> *ZEROS
006919090224     C                   Movel     AHENDT        Input_Date
006920050318     C                   Exsr      EDTDAT
006921050318     C                   If        Output_Error <> *Blanks
006922050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006923090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006924050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006925050318     C                   Else
006926010301    ? *
006927010301    ? * TERM DATE > EFF DATE
006928090224     C                   If        AHENDT <> *ZEROS and
006929090224     C                             AHBEDT <> *ZEROS
006930090224     C     AHBEDT        Mult      10000.0001    WWBEDT            8 0
006931090224     C     AHENDT        Mult      10000.0001    WWENDT            8 0
006932050318     C                   If        WWBEDT  > WWENDT
006933050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006934050318    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006935050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006936050318     C                   Endif
006937050318     C                   Endif
006938050318     C                   Endif
006939050318     C                   Endif
006940070516    ? *
006941090224    ? * ACH Routing Number
006942090224     C                   If        AHROUT   =    *Zeros
006950070516    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006951090224    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006952070516    ?C                   Exsr      SNDMSG                                       SEND MSG
006960070518     C                   Exsr      SNDMSG
006961090224     C                   Endif
006963070518    ? *
006964090224    ? * ACH Account Number
006965010301    ? *
006966090916     C                   If        AHACT#   =    *Blanks
006970070518     C                   Move      'ERROR   '    WORTN
006971070518     C                   Move      WTM(7)        WWMSG
006972070518     C                   Exsr      SNDMSG
006973070518     C                   Endif
006974070518    ? *
006975090224    ? * Checking/Savings Flag Required
006976070518    ? *
006977090224     C                   If        AHCSFL   <>   'C'    And
006978090224     C                             AHCSFL   <>   'S'
006979070518     C                   Move      'ERROR   '    WORTN
006980070518     C                   Move      WTM(8)        WWMSG
006981070518     C                   Exsr      SNDMSG
006982070518     C                   Endif
006983090304    ? *
006984090304    ? * Prenote
006985090304    ? *
006986090319     C************       If        AHPREN   <>   ' '
006987090319     C**********         If        AHPREN   <>   '1'    And
006988090319     C*******                      AHPREN   <>   '2'    And
006989090319     C*******                      AHPREN   <>   '3'
006990090319     C*******            Move      'ERROR   '    WORTN
006991090319     C*******            Move      WTM(9)        WWMSG
006992090319     C*******            Exsr      SNDMSG
006993090319     C**********         Endif
006994090319     C************       End
007000000000    ?C                   Endsr                                                  END EDIT RECORD
007001010301    ? *___________________________________________________________________
007002010301    ? * format Date edit
007003010301    ? *___________________________________________________________________
007004010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007005010301     C                   movel     'MMDDYYYY'    Input_Format
007006010301     C                   Call      'FMTDATE'
007007010301     C                   Parm                    Input_Date       32
007008010301     C                   Parm                    Input_Format     32
007009010301     C                   Parm                    Output_Format    32
007010010301     C                   Parm                    Output_Date      32
007011010301     C                   Parm                    Output_Error     10
007012010301    ?C                   Endsr                                                  END DLT RQST
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
01290009031900Request not supported by program CHKACF
013000000117** WTM
01310009022461AHC begin date must be a valid date.
01330009022462ACH end date must be a valid date.
01340009022463You must enter a valid date.
01350009022464You must enter a Routing Number.
01360007051864End Date cannot be less than Begin Date.
01370007051865Run Out Date cannot be less than Begin Date.
01380009022466You must enter an Account Number.
01390009022467Enter C for Checking or S for Savings.
01400009030468Enter 1, 2 or 3 for Prenote.
