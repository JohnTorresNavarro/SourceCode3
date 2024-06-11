000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300101220    ? *  Description:  Check Payroll SSN Xreference
000400000000    ? *
000500100520    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000700130204    ?FWEBPLNXRFPIF   E           K DISK
000800130204     FACCMST    IF   E           K DISK
000900130204     FPLNMST    IF   E           K DISK
001000000000    ? *
001100010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200060303    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001300101202     D N_WAIT          S              3S 0 inz
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700130204    ?D WUDTA         E DS                  EXTNAME(WEBPLNXRFP)
001800000810    ? *
001900000000    ? * Program status data structure
002000991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000    ? *___________________________________________________________________
002200000000    ? * Process check request
002300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002400000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002500000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002600000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002700000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002800000000    ?C                   Endcs                                                  END CASE
002900000000    ?C                   Return                                                 RETURN
003000000000    ? *___________________________________________________________________
003100000000    ? * Edit record
003200000000    ? *___________________________________________________________________
003300000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003400000810    ? *
003500000810    ? * Defualt Data
003600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003700130204    ? *
003800130204    ? * Check ACC
003900130204     C     ACCKEY        Chain     ACCMST
004000130204     C                   if        not %found(ACCMST)
004100130204    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004200130204    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004300130204    ?C                   Exsr      SNDMSG                                       SEND MSG
004400130204     C                   End
004500100617    ? *
004600101220    ? * Check SSN
004700130204     C     PLNKEY        Chain     PLNMST
004800130204     C                   if        not %found(PLNMST)
004900100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005000130204    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005100100617    ?C                   Exsr      SNDMSG                                       SEND MSG
005200100617     C                   End
005300101220    ? *
005400101220    ? * Check XREF
005500130204     C     PLNKEYX       Chain     PLNMST
005600130204     C                   if        not %found(PLNMST)
005700101220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005800130204    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005900101220    ?C                   Exsr      SNDMSG                                       SEND MSG
006000101220     C                   End
006100031215    ? *
006200010913    ?C                   Endsr                                                  END DLT RQST
006300000000    ? *___________________________________________________________________
006400000000    ? * Edit delete request
006500000000    ? *___________________________________________________________________
006600000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
006700100617    ? *
006800000000    ?C                   Endsr                                                  END DLT RQST
006900000000    ? *___________________________________________________________________
007000000000    ? * Default data
007100000000    ? *___________________________________________________________________
007200000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
007300000000    ?C                   Endsr                                                  END DFT DATA
007400000000    ? *___________________________________________________________________
007500000000    ? * Send messages
007600000000    ? *___________________________________________________________________
007700000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
007800000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
007900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008000000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008100000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
008300000000    ?C                   Endsr                                                  END SND ERRMSG
008400000000    ? *___________________________________________________________________
008500000000    ? * Process error
008600000000    ? *___________________________________________________________________
008700000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
008800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008900000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009100000000    ?C                   Endsr                                                  END PRCERR
009200000000    ? *___________________________________________________________________
009300000000    ? * Parameter list
009400000000    ? *___________________________________________________________________
009500000000    ?C     PLIST         Begsr                                                  PARM LISTS
009600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
009700000000    ?C                   Parm                    WIRQS             8            REQUEST
009800000000    ?C                   Parm                    WORTN             8            RETURN CODE
009900000614    ?C                   Parm                    WUDTA                          DATA
010000000000    ?C                   Endsr                                                  END PLIST
010100000000    ? *___________________________________________________________________
010200000000    ? * Define Variables and Key Lists
010300000000    ? *___________________________________________________________________
010400000000    ?C     DEFN          Begsr                                                  PARM LISTS
010500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
010600000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
010700000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010800000000    ?C                   Endsr                                                  END DEFN
010900010914    ? *___________________________________________________________________
011000010914    ? * Key lists
011100010914    ? *___________________________________________________________________
011200010914    ?C     KLIST         Begsr                                                  KEY LISTS
011300130204     C     ACCKEY        Klist
011400130204     C                   Kfld                    XLTRST
011500130204     C                   Kfld                    XLSUB#
011600130204     C                   Kfld                    XLACCT
011700130204     C     PLNKEY        Klist
011800130204     C                   Kfld                    XLTRST
011900130204     C                   Kfld                    XLSUB#
012000130204     C                   Kfld                    XLPLAN
012100130204     C     PLNKEYx       Klist
012200130204     C                   Kfld                    XLTRST
012300130204     C                   Kfld                    XLSUB#
012400130204     C                   Kfld                    XLXPLN
012500010914    ?C                   Endsr
012600000000    ? *___________________________________________________________________
012700000000    ? * Program error handler
012800000000    ? *___________________________________________________________________
012900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
013000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
013100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
013200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
013300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
013400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
013500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
013600031215      *-------------------------------------------------------------------*
013700031215      * Format Date
013800031215      *-------------------------------------------------------------------*
013900031215     C     FMTDATE       Begsr
014000031215     C                   Eval      Input_Format  = 'MMDDYYYY'
014100031215     C                   Eval      Output_Format = 'MMDDYYYY'
014200031215     C                   Call      'FMTDATE'
014300031215     C                   Parm                    Input_Date       32
014400031215     C                   Parm                    Input_Format     32
014500031215     C                   Parm                    Output_Format    32
014600031215     C                   Parm                    Output_Date      32
014700031215     C                   Parm                    Output_Error     10
014800031215     C                   Endsr
014900000000    ? *___________________________________________________________________
015000000112** WTMP
01510000000000T-Record is not eligible for deletion.
01520013020400Request not supported by program CHKXRF.
015300000117** WTM
01540013020461Must be a valid TSA
01550013020462Plan is not valid
01560013020463Like plan is not valid
