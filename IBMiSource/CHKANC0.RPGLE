000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100506    ? *  Description:  Check Payroll Deduction Data
000400000000    ? *
000500100506    ? *  (c)Copyright 2010 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000601070516    ? *
000900050318    ? *___________________________________________________________________
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001201101019    ?D WTM             S             80    DIM(15) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700101019    ?D WUDTA         E DS                  EXTNAME(WEBPAY0DS)
002100000810    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000    ? *___________________________________________________________________
003200000000    ? * Process check request
003300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003301100818    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003500000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003600000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003700000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003800000000    ?C                   Endcs                                                  END CASE
003900000000    ?C                   Return                                                 RETURN
003901101110    ? *___________________________________________________________________
003902101110    ? * Edit record
003903101110    ? *___________________________________________________________________
003904101110    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003905101110     C                   Endsr
007001100818    ? *___________________________________________________________________
007002100818    ? * Edit record
007003100818    ? *___________________________________________________________________
007004101110    ?C     EDTRCDx       Begsr                                                  EDIT RECORD
007008100818    ? *
007010101019    ? * Annual Salary Required
007011101019     C                   If        WSSALY   =    *Zeros
007012101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007013101019    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
007014101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007015101019     C                   Endif
007016101019    ? *
007017101019    ? * Pay Frequency Required
007018101019     C                   If        WSPFRQ   =    *Zeros
007019101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007020101019    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
007021101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007022101019     C                   Endif
007023101019      *
007024101019     C                   Select
007025101019     C                   When      WSPFRQ   =    52    or
007026101019     C                             WSPFRQ   =    26    or
007027101019     C                             WSPFRQ   =    24    or
007028101019     C                             WSPFRQ   =    12    or
007030101019     C                             WSPFRQ   =    04
007031101019     C                   Other
007032101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007033101019    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
007034101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007035101019     C                   Endsl
007036101019    ? *
007037101019    ? * Hire Date Required
007038101019     C                   If        WSHIRE   =    *Zeros
007039101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007040101019    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
007041101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007042101019     C                   End
007043101019    ? *
007044101019     C                   If        WSHIRE   <>   *Zeros
007045101019     C                   Movel     WSHIRE        Input_Date
007046101019     C                   Exsr      EDTDAT
007047101019     C                   If        Output_Error <> *Blanks
007048101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007049101019    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
007050101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007051101019     C                   End
007052101019     C                   End
007053101019    ? *
007054101019    ? * Qualifying Event Date
007055101019     C                   If        WSQEVT   <>   *Zeros
007056101019     C                   Movel     WSQEVT        Input_Date
007057101019     C                   Exsr      EDTDAT
007058101019     C                   If        Output_Error <> *Blanks
007059101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007060101019    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
007061101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007062101019     C                   End
007063101019     C                   End
007064101019    ? *
007065101019    ? * Birth Date Required
007066101019     C                   If        WSBIRTH  =    *Zeros
007067101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007068101019    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007069101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007070101019     C                   Endif
007071101019    ? *
007072101019     C                   If        WSBIRTH  <>   *Zeros
007073101019     C                   Movel     WSBIRTH       Input_Date
007074101019     C                   Exsr      EDTDAT
007075101019     C                   If        Output_Error <> *Blanks
007076101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007077101019    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007078101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007079101019     C                   End
007080101019     C                   End
007081101019    ? *
007082101019    ? * Available Plan Date Required
007083101019     C                   If        WSAVLD   =    *Zeros
007084101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007085101019    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
007086101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007087101019     C                   Endif
007088101019    ? *
007089101019    ? * Coverage Period Required
007090101019     C                   If        WSPRD    =    *Zeros
007091101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007092101019    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
007093101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007094101019     C                   Endif
007095101019    ? *
007096101019    ? * Coverage Level Required
007097101019     C                   If        WSCLVL   =    *BLANKS
007098101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007099101019    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
007100101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007101101019     C                   Endif
007102101019    ? *
007103101019    ? * Coverage Level Required
007104101019     C                   If        WSCLVL   =    *BLANKS
007105101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007106101019    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
007107101019    ?C                   Exsr      SNDMSG                                       SEND MSG
007108101019     C                   Endif
007109100818    ? *
007110100818    ?C                   Endsr                                                  END EDIT RECORD
007396010301    ? *___________________________________________________________________
007397010301    ? * format Date edit
007398010301    ? *___________________________________________________________________
007399010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007400010301     C                   movel     'MMDDYYYY'    Input_Format
007401010301     C                   Call      'FMTDATE'
007402010301     C                   Parm                    Input_Date       32
007403010301     C                   Parm                    Input_Format     32
007404010301     C                   Parm                    Output_Format    32
007405010301     C                   Parm                    Output_Date      32
007406010301     C                   Parm                    Output_Error     10
007407010301    ?C                   Endsr                                                  END DLT RQST
007408000000    ? *___________________________________________________________________
007409000000    ? * Edit delete request
007410000000    ? *___________________________________________________________________
007411000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007500000000    ?C                   Endsr                                                  END DLT RQST
007600000000    ? *___________________________________________________________________
007700000000    ? * Default data
007800000000    ? *___________________________________________________________________
007900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
007901101019     C                   If        WSSMOKE = *BLANKS
007902101019     C                   Eval      WSSMOKE = 'X'
007903100921     C                   End
007904101019     C                   If        WSGENDER = *BLANKS
007905101019     C                   Eval      WSGENDER = 'X'
007906100917     C                   End
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
01290010081800Request not supported by program CHKANC
013500101019** WTM
01350110101961Annual Salary Required
01350210101962Valid Payroll Frequency Required
01350310101963Valid Hire Date Required
01350410101964Valid Birth Date Required
01350510101965Valid Plan Available Date Required
01350610101966Valid Coverage Period Required
01350710101967Valid Coverage Level Required
01360010101968Valid Qualifying Event Date Required
