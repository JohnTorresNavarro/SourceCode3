000100230206          Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200230206                           DftActGrp(*no)
000300230206                           bnddir('GBSBDIR' )   ;
000400230206
000500000000      *_________________________________________________________________________
000600000000      *
000700000000      *  Description:  Print OLE Forms by AA
000800000000      *
000900000000      *  (c)Copyright 2023 by Innovative Outsourcing, Inc.
001000000000      *
001100000000      *    Created by:  JALLEN - February 06, 2023
001200230914      *
001300230914      *   09.01.2023 - Add EDT(5) - Jon Allen
001400000000      *_________________________________________________________________________
001500230206       Dcl-f webtranl11 keyed;
001600230206
001700230206     FAACODE    IF   E           K DISK
001800230206
001900230206     D a#              S              2S 0 inz
002000230206     D p#              S              2S 0 inz
002100230206     d  wwaa           s              3a   dim(50) inz
002200230206
002300000000      * Program status data structure
002400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000      *
002600230206     C                   clear                   wwaa
002700230206     C                   eval      p# = 0
002800230206     C                   eval      a# = 0
002900230206     C     *loval        setll     webtranl11
003000230206     C                   read      webtranl11
003100230206     C                   dow       not %eof(webtranl11)
003200230206     C                   if        %trim(oeaacod) <> 'EDT'
003300230206     C                   eval      p# = %lookup(oeaacod:wwaa)
003400230206     C                   If        p# = 0
003500230206     C                   eval      a# = a#+1
003600230206     C                   eval      wwaa(a#) = oeaacod
003700230206     C     oeaacod       chain     aacode
003800230206     C                   if        %found(aacode)
003900230206     C                   call      'PRTOLEFRMC'
004000230222     C                   parm      'D'           run               1
004100230206     C                   parm      'Y'           batch             1
004200230206     C                   parm      oeaacod       aa                3
004300230228     C                   parm      ' '           in_ssid          16
004400230208     C                   parm      ' '           out_form          1
004500230208     C                   parm      ' '           out_DateTime     15
004600230208     C                   parm      ' '           out_Color        10
004700230206     C                   end
004800230206     C                   end
004900230206     C                   end
005000230206     C                   read      webtranl11
005100230206     C                   enddo
005200230901      * EDT
005300230901     C     *loval        setll     webtranl11
005400230901     C                   read      webtranl11
005500230901     C                   dow       not %eof(webtranl11)
005600230901     C                   if        %trim(oeaacod) = 'EDT'
005700230901     C                   eval      p# = %lookup(oeaacod:wwaa)
005800230901     C                   If        p# = 0
005900230901     C                   eval      a# = a#+1
006000230901     C                   eval      wwaa(a#) = oeaacod
006100230901     C     oeaacod       chain     aacode
006200230901     C                   if        %found(aacode)
006300230901     C                   call      'PRTOLEFRMC'
006400230901     C                   parm      '5'           run               1
006500230901     C                   parm      'Y'           batch             1
006600230901     C                   parm      oeaacod       aa                3
006700230901     C                   parm      ' '           in_ssid          16
006800230901     C                   parm      ' '           out_form          1
006900230901     C                   parm      ' '           out_DateTime     15
007000230901     C                   parm      ' '           out_Color        10
007100230901     C                   end
007200230901     C                   end
007300230901     C                   end
007400230901     C                   read      webtranl11
007500230901     C                   enddo
007600230206     C                   eval      *inlr = *on
007700230206     C                   return
007800000000      *___________________________________________________________________
007900000000      * Key Lists
008000000000      *___________________________________________________________________
008100000000     C     KLIST         BEGSR
008200000000     C                   ENDSR
008300000000      *___________________________________________________________________
008400000000      * Program open
008500000000      *___________________________________________________________________
008600000000     C     *INZSR        BEGSR
008700000000     C                   ENDSR
008800000000      *___________________________________________________________________
008900000000      * Program error handler
009000000000      *___________________________________________________________________
009100000000     C     *PSSR         BEGSR
009200000000     C                   CALL      'SNDRPGM'                            50
009300000000     C                   PARM                    WQPGMN
009400000000     C                   PARM                    WQSTSC
009500000000     C                   PARM                    WQRPGS
009600000000     C                   PARM                    WQMSG
009700000000     C                   ENDSR     '*CANCL'
