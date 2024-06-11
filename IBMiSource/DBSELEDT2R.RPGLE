000100981030     F*------------------------------------------------------------------------------------------*
000200030522      * DBSELEDTR  GROUP BENIFIT SERVICES SOFTWARE           2003                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400030522      *            DATE - 05/2003                                                                *
000500030402      *  DESCRIPTION - Select members with group status pf A                                    *
000600981030      *------------------------------------------------------------------------------------------*
000700010620      *  Change Log
000800010620      * xxx  mm/dd/yyyy   description
000900000306      *------------------------------------------------------------------------------------------*
001000040721     Fdel2gxrl3 IP   E           K DISK
001100030522     Fdelball   IF   E           K DISK
001200030402     Fdelbilp   O    E             DISK
001300030401      *
001400030401     D                 DS
001500040715     D hlddta                  1     12A   inz(*blanks)
001600040715     D  hgrp                   1      8A
001700040715     D  hclas                  9     12A
001800030401      *
001900030401     D                 DS
002000040715     D curdta                  1     12A
002100040715     D  dggrid                 1      8A
002200040715     D  dgcsid                 9     12A
002300030401      *
002400030401     Idelbalr       01
002500030402     I              dbstts                      instts
002600030402     I              dbupdt                      inupdt
002700030402     I              dbfil3                      infil3
002800030401      *
002900030401      *          Member Key
003000030401     C     dmkey         klist
003100030402     C                   kfld                    kgrp              8
003200030402     C                   kfld                    dgcsid
003300030312      *
003400981030      *    MAINLINE
003500021204      *
003600030402     C                   IF        dgstat = 'A'
003700030402     C                   IF        curdta <> hlddta
003800030402      *
003900030402     C                   movel(P)  dggrid        kgrp
004000030402     C     dmkey         setll     delball                            21
004100030402     C                   dou       *in21 = '1'
004200030402     C     dmkey         reade     delball                                21
004300030402     C                   IF        *in21 = '0' and dbgrp = kgrp
004400030402     C                             and instts <> 'C'
004500030402     C                   movel     *blanks       dbfil3
004600030402     C                   movel     *blanks       dbfilh
004700030402     C                   write     delbilr
004800030402     C                   movel     'C'           instts
004900030402     C                   endif
005000030402     C                   enddo
005100030402      *
005200030402     C                   movel     curdta        hlddta
005300030401     C                   endif
005400030402     C                   endif
