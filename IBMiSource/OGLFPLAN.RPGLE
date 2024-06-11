000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Add OGLF to the Plan File
000500000000      *
000600000000      *  (c)Copyright 2008 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - March 17, 2008
000900000000      *_________________________________________________________________________
000901080317     FOGLFTRNP  IP   E             DISK
000902080317     FOGLFPLNP  UF A E           K DISK
000903080317     FGRATEL1   IF   E           K DISK
000904080324     FCLASS     IF   E           K DISK
000905080317     FCMCTL2    IF   E           K DISK
000906080317      *
000907080317     D  OOISO          s               D   datfmt(*iso)
000908080429     D  FOUR           s              4A   inz
000909080429     D  A              s            500A   inz
000910080429     D  Q              s              1A   inz('"')
000911080429     D  pos            s              3s 0 inz
000912080317      *
001200080317      * Build key
001201080317     C                   Clear                   OGLFPLNR
001202080317     C                   Movel     OGPEFF        OOISO
001203080317     C                   eval      OPPEDT = %int(%char(OOISO : *iso0))
001204080317      *
001205080317      * Check OGLF
001206080317     C     OGLFKEY       CHAIN     OGLFPLNP
001207080317     C                   If        %found
001208080317     C                   EXSR      CVTDATES
001209080317     C                   EXSR      GETTSAP
001210080317     C                   EXSR      LOADOGLF
001211080317     C                   Update    OGLFPLNR
001212080317     C                   Else
001213080317     C                   EXSR      CVTDATES
001214080317     C                   EXSR      GETTSAP
001215080317     C                   EXSR      LOADOGLF
001216080317     C                   Write     OGLFPLNR
001217080317     C                   End
001218080317      *___________________________________________________________________
001219080317      * Convert Dates
001220080317      *___________________________________________________________________
001221080317     C     CVTDATES      BEGSR
001222080317     C                   Movel     OGADD         OOISO
001223080317     C                   eval      OPADT = %int(%char(OOISO : *iso0))
001224080501     C                   If        OPADT = 19000101
001225080501     C                   Eval      OPADT = 0
001226080501     C                   End
001227080317     C                   Movel     OGNHEF        OOISO
001228080317     C                   eval      OPNEDT = %int(%char(OOISO : *iso0))
001229080501     C                   If        OPNEDT = 19000101
001230080501     C                   Eval      OPNEDT = 0
001231080501     C                   End
001232080317     C                   Movel     OGPEFF        OOISO
001233080317     C                   eval      OPPEDT = %int(%char(OOISO : *iso0))
001234080501     C                   If        OPPEDT = 19000101
001235080501     C                   Eval      OPPEDT = 0
001236080501     C                   End
001237080317     C                   Movel     OGPTRM        OOISO
001238080317     C                   eval      OPPTDT = %int(%char(OOISO : *iso0))
001239080501     C                   If        OPPTDT = 19000101
001240080501     C                   Eval      OPPTDT = 0
001241080501     C                   End
001242080317     C                   ENDSR
001243080317      *___________________________________________________________________
001244080317      * Get Trust, Sub, Account, Plan
001245080317      *___________________________________________________________________
001246080317     C     GETTSAP       BEGSR
001247080317
001248080317      * TSP
001249080324     C                   Eval      GROUP# = %trim(OGGRP)
001250080317     C     GROUP#        Setll     GRATEL1
001251080324     C                   Read      GRATEL1
001252080317     C                   Dow       not %eof(GRATEL1)
001253080325      *
001254080325     C                   If        %trim(OGGRP) <> %trim(%subst(GROUP#:1:4))
001255080325     C                   Leave
001256080325     C                   End
001257080325      *
001258080324     C                   If        FRMDAT = OPPEDT  and
001259080324     C                             %trim(OGGRP) = %trim(%subst(GROUP#:1:4))
001260080324     C     CLSKEY        setll     CLASS
001261080324     C     CLSKEY        reade     CLASS
001262080324     C                   Dow       not %eof(CLASS)
001263080324     C                   If        %trim(CLCLASS) = %trim(OGCLAS)
001264080324     C                   Eval      OPTRS = GRTRST
001265080324     C                   Eval      OPSUB = GRSUB#
001266080324     C                   Eval      OPPLN = GRPLAN
001267080325     C                   EXSR      CHKACCT
001268080325     C                   If        OPACC <> 0
001269080324     C                   Leave
001270080325     C                   End
001271080325     C                   Eval      OPTRS = 0
001272080325     C                   Eval      OPSUB = 0
001273080325     C                   Eval      OPPLN = *blanks
001274080324     C                   End
001275080324     C     CLSKEY        reade     CLASS
001276080324     C                   enddo
001277080324     C                   If        OPTRS <> 0
001278080324     C                   Leave
001279080324     C                   End
001280080317     C                   End
001281080325     C                   Read      GRATEL1
001282080317     C                   Enddo
001283080317
001284080317      * A
001285080324     C     CLSKEY        KLIST
001286080324     C                   KFLD                    GRTRST
001287080324     C                   KFLD                    GRSUB#
001288080324     C                   KFLD                    GRPLAN
001289080325
001290080325     C                   ENDSR
001291080325      *___________________________________________________________________
001292080325      * Check ACCT
001293080325      *___________________________________________________________________
001294080325     C     CHKACCT       BEGSR
001295080324      * A
001296080324     C     CKEY          KLIST
001297080324     C                   KFLD                    OPTRS
001298080324     C                   KFLD                    OPSUB
001299080317
001300080317     C     CKEY          Setll     CMCTL2
001301080317     C     CKEY          Reade     CMCTL2
001302080317     C                   Dow       not %eof(CMCTL2)
001303080325     C***                If        OPPEDT >= EFFDAT and
001304080325     C***                          CMCAN  = 0       and
001305080325     C***                          CMPLAN = OPPLN   or
001306080325     C***                          OPPEDT >= EFFDAT and
001307080325     C***                          OPPEDT <= CMCAN  and
001308080325     C***                          CMPLAN = OPPLN
001309080325     C                   If        CMCAN  = 0       and
001310080325     C                             CMPLAN = OPPLN   or
001311080325     C                             OPPEDT >= EFFDAT and
001312080325     C                             OPPEDT <= CMCAN  and
001313080325     C                             CMPLAN = OPPLN
001314080317     C                   Eval      OPACC = CMACCT
001315080317     C                   Leave
001316080317     C                   End
001317080317     C     CKEY          Reade     CMCTL2
001318080317     C                   Enddo
001319080317
001320080317     C                   ENDSR
001321080317      *___________________________________________________________________
001322080317      * Load OGLF
001323080317      *___________________________________________________________________
001324080317     C     LOADOGLF      BEGSR
001325080317     C                   Eval      OPID = OGID
001326080317     C                   Eval      OPGRP = OGGRP
001327080317     C                   Eval      OPTYP = OGTYP
001328080429
001329080429     C                   Eval      pos = %scan('&quot;':OGDMIN)
001330080429     C                   If        pos > 0
001331080429     C                   Dow       pos > 0
001332080429     C                   Eval      OGDMIN = %replace(Q:OGDMIN:Pos:6)
001333080429     C                   Eval      pos = %scan('&quot;':OGDMIN)
001334080429     C                   Enddo
001335080429     C                   End
001336080429     C                   Eval      OPDMIN = OGDMIN
001337080429
001338080429     C                   Eval      pos = %scan('&quot;':OGNAME)
001339080429     C                   If        pos > 0
001340080429     C                   Dow       pos > 0
001341080429     C                   Eval      OGNAME = %replace(Q:OGNAME:Pos:6)
001342080429     C                   Eval      pos = %scan('&quot;':OGNAME)
001343080429     C                   Enddo
001344080429     C                   End
001345080429     C                   Eval      OPNAME = OGNAME
001346080429
001347080429     C                   Eval      pos = %scan('&quot;':OGADR1)
001348080429     C                   If        pos > 0
001349080429     C                   Dow       pos > 0
001350080429     C                   Eval      OGADR1 = %replace(Q:OGADR1:Pos:6)
001351080429     C                   Eval      pos = %scan('&quot;':OGADR1)
001352080429     C                   Enddo
001353080429     C                   End
001354080317     C                   Eval      OPADR1 = OGADR1
001355080429
001356080429     C                   Eval      pos = %scan('&quot;':OGADR2)
001357080429     C                   If        pos > 0
001358080429     C                   Dow       pos > 0
001359080429     C                   Eval      OGADR2 = %replace(Q:OGADR2:Pos:6)
001360080429     C                   Eval      pos = %scan('&quot;':OGADR2)
001361080429     C                   Enddo
001362080429     C                   End
001363080429     C                   Eval      OPADR2 = OGADR2
001364080429
001365080429     C                   Eval      pos = %scan('&quot;':OGCITY)
001366080429     C                   If        pos > 0
001367080429     C                   Dow       pos > 0
001368080429     C                   Eval      OGCITY = %replace(Q:OGCITY:Pos:6)
001369080429     C                   Eval      pos = %scan('&quot;':OGCITY)
001370080429     C                   Enddo
001371080429     C                   End
001372080317     C                   Eval      OPCITY = OGCITY
001373080429
001374080429     C                   Eval      pos = %scan('&quot;':OGSTAT)
001375080429     C                   If        pos > 0
001376080429     C                   Dow       pos > 0
001377080429     C                   Eval      OGSTAT = %replace(Q:OGSTAT:Pos:6)
001378080429     C                   Eval      pos = %scan('&quot;':OGSTAT)
001379080429     C                   Enddo
001380080429     C                   End
001381080317     C                   Eval      OPSTAT = OGSTAT
001382080429
001383080317     C                   Eval      OPZIP  = OGZIP
001384080317     C                   Eval      OPNHID = OGNHID
001385080317     C                   Eval      OPNHTP = OGNHTP
001386080317     C                   Eval      OPNHFT = OGNHFT
001387080317     C                   Eval      OPNHPT = OGNHPT
001388080317     C                   Eval      OPNHDA = OGNHDA
001389080317     C                   Eval      OPNHMO = OGNHMO
001390080317     C                   Eval      OPSUBG = OGSUBG
001391080317     C                   Eval      OPCLAS = OGCLAS
001392080429
001393080429     C                   Eval      pos = %scan('&quot;':OGCLDS)
001394080429     C                   If        pos > 0
001395080429     C                   Dow       pos > 0
001396080429     C                   Eval      OGCLDS = %replace(Q:OGCLDS:Pos:6)
001397080429     C                   Eval      pos = %scan('&quot;':OGCLDS)
001398080429     C                   Enddo
001399080429     C                   End
001400080317     C                   Eval      OPCLDS = OGCLDS
001401080429
001402080317     C                   Eval      OPPCAT = OGPCAT
001403080429
001404080429     C                   Eval      pos = %scan('&quot;':OGPDSC)
001405080429     C                   If        pos > 0
001406080429     C                   Dow       pos > 0
001407080429     C                   Eval      OGPDSC = %replace(Q:OGPDSC:Pos:6)
001408080429     C                   Eval      pos = %scan('&quot;':OGPDSC)
001409080429     C                   Enddo
001410080429     C                   End
001411080317     C                   Eval      OPPDSC = OGPDSC
001412080429
001413080317     C                   Eval      OPPTIR = OGPTIR
001414080317     C                   Eval      OPPSAD = OGPSAD
001415080317     C                   Eval      OPPSAS = OGPSAS
001416080317     C                   Eval      OPRAT1 = OGRAT1
001417080317     C                   Eval      OPRAT2 = OGRAT2
001418080317     C                   Eval      OPRAT3 = OGRAT3
001419080317     C                   Eval      OPRAT4 = OGRAT4
001420080317     C                   Eval      OPRAT5 = OGRAT5
001421080317     C                   ENDSR
001800000000      *___________________________________________________________________
001900000000      * Program open
002000000000      *___________________________________________________________________
002100000000     C     *INZSR        BEGSR
002101080317     C     OGLFKEY       KLIST
002102080317     C                   KFLD                    OGGRP
002103080317     C                   KFLD                    OGSUBG
002104080317     C                   KFLD                    OGCLAS
002105080317     C                   KFLD                    OPPEDT
002200000000     C                   ENDSR
