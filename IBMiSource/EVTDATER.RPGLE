000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *_________________________________________________________________________
000400190722     FEVTMCOVP  UP   E           K Disk
000500160809
000600190711     D up              c                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
000700190711     D lo              c                   CONST('abcdefghijklmnopqrstuvwxyz')
000800190712
000900190722     d #len            S              3P 0
001000190722     D  pos            s              3s 0 inz
001100190722     D  pos2           s              3s 0 inz
001200190722     D  dif            s              3s 0 inz
001300190722     D mm              s              2a   inz
001400190722     D dd              s              2a   inz
001500190722     D yyyy            s              4a   inz
001600160725
001700160809     D                 DS
001800160809     D  suba                   1      9
001900160809     D  subn                   1      9  0
002000160809
002100000000      * Program status data structure
002200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300160725
002400190722     C                   Eval      mm    = *blanks
002500190722     C                   Eval      dd    = *blanks
002600190722     C                   Eval      yyyy  = *blanks
002700190722     C                   evalr     EVTEFF = EVTEFF
002800190722
002900190722     C                   Eval      Pos  = %Scan('/':EVTEFF)
003000190712     C                   If        Pos > 0
003100190722     C                   Eval      mm = %subst(EVTEFF:1:pos-1)
003200190722     C                   Eval      #len = %len(%TRIM(mm))
003300190722     C                   if        #len = 1
003400190722     C                   eval      mm = '0' + %trim(mm)
003500190722     C                   end
003600190722     C                   end
003700190722
003800190722     C                   Eval      Pos2 = %Scan('/':EVTEFF:pos+1)
003900190722     C                   If        Pos2 > 0
004000190722     C                   eval      dif = pos2-1 - pos
004100190722     C                   Eval      dd = %subst(EVTEFF:pos+1:dif)
004200190722     C                   Eval      #len = %len(%TRIM(dd))
004300190722     C                   if        #len = 1
004400190722     C                   eval      dd = '0' + %trim(dd)
004500190722     C                   end
004600190722     C                   end
004700190722
004800190722     C                   Eval      yyyy = %subst(EVTEFF:pos2+1:4)
004900190722
005000190722     C                   eval      EVTEFF = yyyy + mm + dd
005100190722     C                   update    evtr
005200000000      *___________________________________________________________________
005300000000      * Program open
005400000000      *___________________________________________________________________
005500000000     C     *INZSR        BEGSR
005600000000     C                   ENDSR
005700000000      *___________________________________________________________________
005800000000      * Program error handler
005900000000      *___________________________________________________________________
006000000000     C     *PSSR         BEGSR
006100000000     C                   CALL      'SNDRPGM'                            50
006200000000     C                   PARM                    WQPGMN
006300000000     C                   PARM                    WQSTSC
006400000000     C                   PARM                    WQRPGS
006500000000     C                   PARM                    WQMSG
006600000000     C                   ENDSR     '*CANCL'
