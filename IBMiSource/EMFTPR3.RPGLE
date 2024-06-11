000100000000      *_________________________________________________________________________
000200000000      *
000300020306      *  Description:  FTP AS/400 export
000400010907      *                check for valid transmit
000500000000      *
000600010906      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *_________________________________________________________________________
000900010907     FHEXPFTPOP IP   E             DISK
001000010910     D REC0            C                   ' 0 bytes transferred'
001100010910     D REC1            C                   'The system cannot find the file'
001200010910     D REC2            C                   'Cannot connect to host'
001300010914     D REC3            C                   'bytes transferred'
001400010910     D STRG_POS        S              2  0
001500010921     D STRG            S            150
001600010323      *
001700010907     C     *ENTRY        PLIST
001800010910     C     STRG_POS      PARM      STRG_POS      STRG_POS
001900010910     C     STRG          PARM      STRG          STRG
002000001107
002100010910     C                   EVAL      STRG_POS = %SCAN(REC2:OUTPUT80)
002200010910     C                   IF        STRG_POS = 1
002300010910     C                   EVAL      STRG = REC2
002400010910     C                   EVAL      STRG_POS = 99
002500010910     C                   EVAL      *INLR = *ON
002600010910     C                   RETURN
002700010907     C                   END
002800010910
002900010910     C                   EVAL      STRG_POS = %SCAN(REC1:OUTPUT80)
003000010910     C                   IF        STRG_POS = 17
003100010910     C                   EVAL      STRG = REC1
003200010910     C                   EVAL      STRG_POS = 99
003300010910     C                   EVAL      *INLR = *ON
003400010910     C                   RETURN
003500010910     C                   END
003600010910
003700010910     C                   EVAL      STRG_POS = %SCAN(REC0:OUTPUT80)
003800010910     C                   IF        STRG_POS = 5
003900010910     C                   EVAL      STRG = REC0
004000010910     C                   EVAL      STRG_POS = 99
004100010910     C                   EVAL      *INLR = *ON
004200010910     C                   RETURN
004300010910     C                   END
004400010914
004500010914     C                   EVAL      STRG_POS = %SCAN(REC3:OUTPUT80)
004600010920     C                   IF        STRG_POS <> *ZEROS
004700010914     C                   EVAL      STRG = 'file transfered'
004800010914     C                   EVAL      *INLR = *ON
004900010914     C                   RETURN
005000010914     C                   END
