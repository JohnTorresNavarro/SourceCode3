000100000000      *_________________________________________________________________________
000200000000      *
000300020927      *  Description: Zip Code Cross Reference
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *  This document contains restricted materials of IO, Inc.
000700000000      *___________________________________________________________________
000800021003      *
000900021003     FNYSUASM0  IF   E           K DISK
001000000000      *
001100000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200000000    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001300000000      *
001400000000      *___________________________________________________________________
001500000000      *
001600000000      * Data structure
001700020927    ?D WUDTA         E DS                  EXTNAME(NYZIPXF0)
001800000000      *
001900000000      * Program status data structure
002000000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000      *
002200000000      *
002300000000     D WIRQS           S              8A
002400000000     D WORTN           S              8A
002500000000     D WWDTAQ          S             10A
002600000000     D WWLIB           S             10A
002700000000     D WWLNGQ          S              5P 0
002800000000     D WWMSG           S             80A
002900000000     D WWRQS           S              8A
003000000000     D WWRTN           S              8A
003100000000      *
003200000000      *___________________________________________________________________
003300000000      * Process check request
003400000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003500020521     C     WIRQS         Caseq     'EDTCHG'      EDTRCD                         EDIT RECORD
003600020521     C     WIRQS         Caseq     'EDTADD'      EDTRCD                         EDIT RECORD
003700000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003800000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003900000000     C                   Cas                     PRCERR                         REQUEST ERROR
004000000000     C                   Endcs                                                  END CASE
004100000000    ?C                   Return                                                 RETURN
004200000000      *___________________________________________________________________
004300000000      * Edit record
004400000000      *___________________________________________________________________
004500000000     C     EDTRCD        Begsr                                                  EDIT RECORD
004600000000      *
004700020927     C                   If        ZXZIPCOD = *Blanks
004800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004900000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
005000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
005100000000     C                   Endif
005200000000      *
005300020927     C                   If        ZXREGION = *Blanks
005400020521    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005500020521    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005600020521    ?C                   Exsr      SNDMSG                                       SEND MSG
005700020521     C                   Endif
005800021003      *
005900021003     C     ZXREGION      CHAIN     RNYSUASM
006000021003     C                   IF        NOT %FOUND(NYSUASM0)
006100021003    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006200021003    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006300021003    ?C                   Exsr      SNDMSG                                       SEND MSG
006400021003     C                   Endif
006500020521      *
006600000000     C                   Endsr                                                  END DLT RQST
006700000000      *___________________________________________________________________
006800000000      * Edit delete request
006900000000      *___________________________________________________________________
007000000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007100000000     C                   Endsr                                                  END DLT RQST
007200000000      *___________________________________________________________________
007300000000      * Default data
007400000000      *___________________________________________________________________
007500000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
007600000000     C                   Endsr                                                  END DFT DATA
007700000000      *___________________________________________________________________
007800000000      * Send messages
007900000000      *___________________________________________________________________
008000000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
008100000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
008300000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
008400000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
008500000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
008600000000     C                   Endsr                                                  END SND ERRMSG
008700000000      *___________________________________________________________________
008800000000      * Process error
008900000000      *___________________________________________________________________
009000000000     C     PRCERR        Begsr                                                  PROCESS ERROR
009100000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009200000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009300000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009400000000     C                   Endsr                                                  END PRCERR
009500000000      *___________________________________________________________________
009600000000      * Parameter list
009700000000      *___________________________________________________________________
009800000000     C     PLIST         Begsr                                                  PARM LISTS
009900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
010000000000    ?C                   Parm                    WIRQS                          REQUEST
010100000000    ?C                   Parm                    WORTN                          RETURN CODE
010200000000    ?C                   Parm                    WUDTA                          DATA
010300000000     C                   Endsr                                                  END PLIST
010400000000      *___________________________________________________________________
010500000000      * Define Variables and Key Lists
010600000000      *___________________________________________________________________
010700000000     C     *INZSR        Begsr
010800000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010900000000     C                   Endsr                                                  END DEFN
011000000000      *___________________________________________________________________
011100000000      * Program error handler
011200000000      *___________________________________________________________________
011300000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
011400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
011600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
011700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
011800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
011900000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
012000020228      *___________________________________________________________________
012100000000** WTMP
01220000000000T-Record is not eligible for deletion.
01230002100300Request not supported by program CHKZIP.
012400000000** WTM
01250002092761ZIP CODE CANNOT BE BLANK
01260002092762REGION CODE CANNOT BE BLANK
01270002100362REGION CODE IS INVALID
