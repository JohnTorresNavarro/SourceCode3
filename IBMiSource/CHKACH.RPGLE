000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300090224    ? *  Description:  Check ACH Supplemental Data
000400000000    ? *
000500090224    ? *  (c)Copyright 2009 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000601070516    ? *
000900050318    ? *___________________________________________________________________
001000090224    ?FACCACH    IF   E           K DISK
001001090520     FACCMST    IF   E           K Disk
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300110210    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
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
006903090520     C     AKey          Chain     ACCMST
006904090520     C                   If        Not %Found(ACCMST)
006905090520     C                   Else
006907090520     C     AHBEDT        Mult      10000.0001    CMBEDT            8 0
006908090520     C                   End
006909090520     C                   If        AHBEDT = *ZEROS
006910090520     C                                                  Or
006911090520     C                             CMBEDT < ENROLL
006912090521     C                                                  Or
006913090521     C                             CMBEDT < GBSBDT
006914050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006915090224    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
006916050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006917050318     C                   Else
006918090224     C                   Movel     AHBEDT        Input_Date
006919050318     C                   Exsr      EDTDAT
006920050318     C                   If        Output_Error <> *Blanks
006921050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006922090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006923050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006924050318     C                   Endif
006925050318     C                   Endif
006926010301    ? *
006927010301    ? * TERM DATE
006928090224     C                   If        AHENDT <> *ZEROS
006929090224     C                   Movel     AHENDT        Input_Date
006930050318     C                   Exsr      EDTDAT
006931050318     C                   If        Output_Error <> *Blanks
006932050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006933090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006934050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006935050318     C                   Else
006936010301    ? *
006937010301    ? * TERM DATE > EFF DATE
006938090224     C                   If        AHENDT <> *ZEROS and
006939090224     C                             AHBEDT <> *ZEROS
006940090224     C     AHBEDT        Mult      10000.0001    WWBEDT            8 0
006941090224     C     AHENDT        Mult      10000.0001    WWENDT            8 0
006942050318     C                   If        WWBEDT  > WWENDT
006943050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006944050318    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006945050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006946050318     C                   Endif
006947050318     C                   Endif
006948050318     C                   Endif
006949050318     C                   Endif
006950070516    ? *
006951090224    ? * ACH Routing Number
006952110210     C                   If        AHROUT   =    *Zeros
006953110210    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006954110210    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006955110210    ?C                   Exsr      SNDMSG                                       SEND MSG
006961110210     C                   Else
006962110210     C                   If        AHROUT  <>    AHROUTC
006963110210    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006964110210    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
006965110210    ?C                   Exsr      SNDMSG                                       SEND MSG
006967110210     C                   End
006968110210     C                   Endif
006969070518    ? *
006970090224    ? * ACH Account Number
006971010301    ? *
006972110210     C                   If        AHACT#   =    *Blanks
006973110210     C                   Move      'ERROR   '    WORTN
006974110210     C                   Move      WTM(7)        WWMSG
006975110210     C                   Exsr      SNDMSG
006976110210     C                   Else
006977110210     C                   If        AHACT#  <>    AHACT#C
006978110210    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006979110210    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
006980110210    ?C                   Exsr      SNDMSG                                       SEND MSG
006981110210     C                   End
006983110210     C                   Endif
006984090319    ? *
006985090224    ? * Checking/Savings Flag Required
006986070518    ? *
006987110210     C                   If        AHCSFL   <>   'C'    And
006988110210     C                             AHCSFL   <>   'S'
006989110210     C                   Move      'ERROR   '    WORTN
006990110210     C                   Move      WTM(8)        WWMSG
006991110210     C                   Exsr      SNDMSG
006992110210     C                   Endif
006993090304    ? *
006994090304    ? * Prenote
006995090304    ? *
006996090319     C************       If        AHPREN   <>   ' '
006997090319     C**********         If        AHPREN   <>   '1'    And
006998090319     C*******                      AHPREN   <>   '2'    And
006999090319     C*******                      AHPREN   <>   '3'
007000090319     C*******            Move      'ERROR   '    WORTN
007001090319     C*******            Move      WTM(9)        WWMSG
007002090319     C*******            Exsr      SNDMSG
007003090319     C**********         Endif
007004090319     C************       End
007005000000    ?C                   Endsr                                                  END EDIT RECORD
007006010301    ? *___________________________________________________________________
007007010301    ? * format Date edit
007008010301    ? *___________________________________________________________________
007009010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007010010301     C                   movel     'MMDDYYYY'    Input_Format
007011010301     C                   Call      'FMTDATE'
007012010301     C                   Parm                    Input_Date       32
007013010301     C                   Parm                    Input_Format     32
007014010301     C                   Parm                    Output_Format    32
007015010301     C                   Parm                    Output_Date      32
007016010301     C                   Parm                    Output_Error     10
007017010301    ?C                   Endsr                                                  END DLT RQST
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
010701090520      *
010702090520    ?C     KLIST         Begsr                                                  KEY LISTS
010703090520    ?C     AKey          Klist                                                  ACKCTL
010704090520    ?C                   Kfld                    AHTRST
010705090520    ?C                   Kfld                    AHSUB#
010706090520    ?C                   Kfld                    AHACCT                         POSITION TO 1
010707090520    ?C                   Endsr                                                  END PLIST
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
01290009022400Request not supported by program CHKACH
013000000117** WTM
01310009070861ACH Begin Date must be a valid date and after Enroll & GBS Admin Date.
01330009052062ACH End Date must be a valid date.
01340009022463You must enter a valid date.
01350009022464You must enter a Routing Number.
01360007051864End Date cannot be less than Begin Date.
01370007051865Run Out Date cannot be less than Begin Date.
01380009022466You must enter an Account Number.
01390009022467Enter C for Checking or S for Savings.
01400011021068The Routing Number does not match.
01410011021069The Account Number does not match.
