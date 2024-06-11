000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Salesman Agency Override Report - Step 1
000400010203      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - January 31, 2001
000800020218      *
000900020218      *  JON  1.18.02 changed RPCDAT to RPEFDT for report selection.
001000030416      *  ssk  4.18.03 salesman relationship project
001100030701      *  dlk 07/01/03 add super agency selection
001200030703      *  dlk 07/03/03 temporary fix to get override for super agency.
001300031118      *  dlk 11/18/03 fix flat fee calc
001301110613      *  dlk 06/13/11 change to use override value from rpa060wk instead
001302110613      *               of calculating it
001400000000      *_________________________________________________________________________
001500010131     FRPA060WK  ip   e           k Disk
001800030416     FSPRAGXR2  IF   E           K DISK
001900030416     FSMANRLT   IF   E           K DISK
002000010201     FRPA170WK  o  a e             Disk
002100010201      *
002300030703     D rpccdewk        s                   like(rpccde)
003000040917      *
0031000307010600 D                UDS
0032000307010601 D lsuper                  1      3
003300030703
003400030703      *  get relation for this commission history record
003500030703
003600030703     c                   exsr      #getrel
003700030703
003800030703      * select super agency if all (999) not selected
003900030703
004000030703     c                   if        lsuper <> '999' and lsuper <> rpsuper
004100030703     c                   goto      #end
004200030703     c                   end
006200030703
006202110613     C                   Eval      wslsmn = %trim(RPSFNM) +
006203110613     C                             ' ' + %Trim(RPSLNM)
006205110613     C                   move      rpaoamt       wagovr
006206110613     C                   Write     RPA170R
006207110613
007100030703     c     #end          tag
009700030703
009800030703      ********************************
009900030703      * get relation
010000030703      ********************************
010100030703
010200030703     C     #getrel       BEGSR
010300030703
010400030703     C                   clear                   rpsuper
010500030416     C     RPRELID       CHAIN     SRF
010600030416     C                   IF        %FOUND(SMANRLT)
010700030416     C     SRASID        CHAIN     SXF
010800030416     C                   IF        %FOUND(SPRAGXR2)
010900030416     C                   EVAL      RPSUPER = SXSUPER
011000030416     C                   ENDIF
011100030416     C                   ENDIF
011200030703
011300030703      * ** TEMPORY FIX TO GET CORRECT RATE - 07/03/03
011400030703      *    If SA = "*NO" or "   " use the agency code to get override
011500030703      *       ELSE use the Super agency code to get the override
011600030703      *            (since the SA i.e. 307 is set up as an agency)
011700030703
011800040917     c                   if        rpsuper = '*NO' or rpsuper = *blanks or
011900040917     c                             rpsuper = '959'
012000030703     c                   move      rpccde        rpccdewk
012100030703     c                   else
012200030703     c                   move      rpsuper       rpccdewk
012300030703     c                   end
012400030703
012500030703     C                   ENDSR
