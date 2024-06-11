000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Convert CNVSMAN1 to SMAN/SMAN2 2016
000400000000      *
000500000000      *  (c)Copyright 2016 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 25, 2016
000800000000      *_________________________________________________________________________
000900160726     FSMAN      IF A E           K Disk    extfile('F.SMAN')
001000161003     FNPN       IF A E           K Disk
001100160726
001200160726     D S_SSN           s             12a   inz
001300160726     D Pos1            s              3s 0 inz
001400160726     D Pos2            s              3s 0 inz
001500160726     D Nine            s              9a   inz
001600160725
001700160725     D  relidlow       s              8a   inz
001800160725     D  x#             s              2s 0 inz
001900160725     D  z#             s              2s 0 inz
002000160725     D  v#             s              2s 0 inz
002100160725     D  w#             s              2s 0 inz
002200160725     D  pos            s              3s 0 inz
002300160726     D  pot            s              3s 0 inz
002400160726     D  pom            s              3s 0 inz
002500160725     D  wagy           s              3a   inz
002600160725     D  wscd           s              3a   inz
002700160725     D  wscflg         s              1a   inz
002800160725     D  wac            s              3a   inz
002900160725     D  wph            s              7a   inz
003000160725     D  wzp            s              9a   inz
003100160725     D  amw            s              3a   inz('AMW')
003200160725     D  w12            s             12a   inz
003300160725     D  wtx            s              9a   inz
003400160725     D #seq            S              8S 0
003500160725
003600000000      * Program status data structure
003700000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
003800160725
003900161003     C                   exsr      gensmancdV
004000161003     C                   exsr      gensmancdW
004100160725
004200160725     C                   eval      *inlr = *on
004300160725     C                   return
004400160725      *___________________________________________________________________
004500160725      * Generate a SMAN Code
004600160725      *___________________________________________________________________
004700160725     C     gensmancdV    BEGSR
004800161003     C                   eval      v# = 1
004900160725     C                   eval      wscd = 'V' + %editc(v#:'X')
005000161003     C                   dow       v# <= 98
005100160725     C     wscd          chain     SMAN
005200161003     C                   if        %found(SMAN)
005300161003     C     wscd          chain     NPN
005400161003     C                   if        not %found(NPN)
005500161003     C                   eval      SMANCD3  = wscd
005600161003     C                   eval      NPNUMBER = '1111111111'
005700161003     C                   write     npnr
005800161003     C                   end
005900161003     C                   end
006000161003     C                   eval      v# = v#+1
006100161003     C                   enddo
006200160725     C                   ENDSR
006300160725      *___________________________________________________________________
006400160725      * Generate a SMAN Code
006500160725      *___________________________________________________________________
006600160725     C     gensmancdW    BEGSR
006700161003     C                   eval      w# = 1
006800161003     C                   eval      wscd = 'W' + %editc(w#:'X')
006900161003     C                   dow       w# <= 98
007000161003     C     wscd          chain     SMAN
007100161003     C                   if        %found(SMAN)
007200161003     C     wscd          chain     NPN
007300161003     C                   if        not %found(NPN)
007400161003     C                   eval      SMANCD3  = wscd
007500161003     C                   eval      NPNUMBER = '1111111111'
007600161003     C                   write     npnr
007700161003     C                   end
007800161003     C                   end
007900161003     C                   eval      w# = w#+1
008000161003     C                   enddo
008100160725     C                   ENDSR
008200000000      *___________________________________________________________________
008300000000      * Program open
008400000000      *___________________________________________________________________
008500000000     C     *INZSR        BEGSR
008600000000     C                   ENDSR
