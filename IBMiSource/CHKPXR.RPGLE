000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300101220    ? *  Description:  Check Payroll SSN Xreference
000400000000    ? *
000500100520    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000601101220    ?FWEBPAYXRF IF   E           K DISK
000602101220     FMEMBER    IF   E           K DISK
000900000000    ? *
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100060303    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001101101202     D N_WAIT          S              3S 0 inz
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500101220    ?D WUDTA         E DS                  EXTNAME(WEBPAYXRF)
001600000810    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *___________________________________________________________________
002000000000    ? * Process check request
002100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002200000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002300000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002400000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002500000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002600000000    ?C                   Endcs                                                  END CASE
002700000000    ?C                   Return                                                 RETURN
002800000000    ? *___________________________________________________________________
002900000000    ? * Edit record
003000000000    ? *___________________________________________________________________
003100000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003200000810    ? *
003300000810    ? * Defualt Data
003400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003401100617    ? *
003402101220    ? * Check SSN
003404101220     C     PXSSN         Chain     MEMBER
003405101220     C                   if        not %found(MEMBER)
003406100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003407100617    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003408100617    ?C                   Exsr      SNDMSG                                       SEND MSG
003409100617     C                   End
003410101220    ? *
003411101220    ? * Check XREF
003412101220     C     PXREF         Chain     MEMBER
003413101220     C                   if        not %found(MEMBER)
003414101220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003415101220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
003416101220    ?C                   Exsr      SNDMSG                                       SEND MSG
003417101220     C                   End
005700031215    ? *
005800010913    ?C                   Endsr                                                  END DLT RQST
005900000000    ? *___________________________________________________________________
006000000000    ? * Edit delete request
006100000000    ? *___________________________________________________________________
006200000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
006201100617    ? *
006300000000    ?C                   Endsr                                                  END DLT RQST
006400000000    ? *___________________________________________________________________
006500000000    ? * Default data
006600000000    ? *___________________________________________________________________
006700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
006800000000    ?C                   Endsr                                                  END DFT DATA
006900000000    ? *___________________________________________________________________
007000000000    ? * Send messages
007100000000    ? *___________________________________________________________________
007200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
007300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
007400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
007500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
007600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
007700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
007800000000    ?C                   Endsr                                                  END SND ERRMSG
007900000000    ? *___________________________________________________________________
008000000000    ? * Process error
008100000000    ? *___________________________________________________________________
008200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
008300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
008500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
008600000000    ?C                   Endsr                                                  END PRCERR
008700000000    ? *___________________________________________________________________
008800000000    ? * Parameter list
008900000000    ? *___________________________________________________________________
009000000000    ?C     PLIST         Begsr                                                  PARM LISTS
009100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
009200000000    ?C                   Parm                    WIRQS             8            REQUEST
009300000000    ?C                   Parm                    WORTN             8            RETURN CODE
009400000614    ?C                   Parm                    WUDTA                          DATA
009500000000    ?C                   Endsr                                                  END PLIST
009600000000    ? *___________________________________________________________________
009700000000    ? * Define Variables and Key Lists
009800000000    ? *___________________________________________________________________
009900000000    ?C     DEFN          Begsr                                                  PARM LISTS
010000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
010100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
010200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010300000000    ?C                   Endsr                                                  END DEFN
010400010914    ? *___________________________________________________________________
010500010914    ? * Key lists
010600010914    ? *___________________________________________________________________
010700010914    ?C     KLIST         Begsr                                                  KEY LISTS
011200010914    ?C                   Endsr
011300000000    ? *___________________________________________________________________
011400000000    ? * Program error handler
011500000000    ? *___________________________________________________________________
011600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
011900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012300031215      *-------------------------------------------------------------------*
012400031215      * Format Date
012500031215      *-------------------------------------------------------------------*
012600031215     C     FMTDATE       Begsr
012700031215     C                   Eval      Input_Format  = 'MMDDYYYY'
012800031215     C                   Eval      Output_Format = 'MMDDYYYY'
012900031215     C                   Call      'FMTDATE'
013000031215     C                   Parm                    Input_Date       32
013100031215     C                   Parm                    Input_Format     32
013200031215     C                   Parm                    Output_Format    32
013300031215     C                   Parm                    Output_Date      32
013400031215     C                   Parm                    Output_Error     10
013500031215     C                   Endsr
013600000000    ? *___________________________________________________________________
013700000112** WTMP
01380000000000T-Record is not eligible for deletion.
01390010122000Request not supported by program CHKPXR.
014000000117** WTM
01400110122061Real SSN must already exist as a member
01400210122062X-Reference SSN must already exist as a member
