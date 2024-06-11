000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Add OGLF to the Plan File
000500000000      *
000600000000      *  (c)Copyright 2008 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - March 17, 2008
000900000000      *_________________________________________________________________________
000902080325     FOGLFPLNP  UP   E           K DISK
000903080317     FGRATEL1   IF   E           K DISK
000904080324     FCLASS     IF   E           K DISK
000905080317     FCMCTL2    IF   E           K DISK
000906080317      *
000907080317     D  OOISO          s               D   datfmt(*iso)
000908080317     D  FOUR           s              4A   inz
000910080317      *
001200080325      * Only = 0
001201080325     C                   If        OPTRS = 0
001214080317     C                   EXSR      GETTSAP
001216080325     C                   If        OPTRS <> 0
001217080325     C                   Update    OGLFPLNR
001218080325     C                   End
001219080317     C                   End
001231080317      *___________________________________________________________________
001232080317      * Get Trust, Sub, Account, Plan
001233080317      *___________________________________________________________________
001234080317     C     GETTSAP       BEGSR
001235080317
001236080317      * TSP
001237080325     C                   Eval      GROUP# = %trim(OPGRP)
001238080317     C     GROUP#        Setll     GRATEL1
001239080324     C                   Read      GRATEL1
001240080317     C                   Dow       not %eof(GRATEL1)
001241080325      *
001242080325     C                   If        %trim(OPGRP) <> %trim(%subst(GROUP#:1:4))
001243080325     C                   Leave
001244080325     C                   End
001245080325      *
001246080324     C                   If        FRMDAT = OPPEDT  and
001247080325     C                             %trim(OPGRP) = %trim(%subst(GROUP#:1:4))
001248080324     C     CLSKEY        setll     CLASS
001249080324     C     CLSKEY        reade     CLASS
001250080324     C                   Dow       not %eof(CLASS)
001251080325     C                   If        %trim(CLCLASS) = %trim(OPCLAS)
001252080324     C                   Eval      OPTRS = GRTRST
001253080324     C                   Eval      OPSUB = GRSUB#
001254080324     C                   Eval      OPPLN = GRPLAN
001255080325     C                   EXSR      CHKACCT
001256080325     C                   If        OPACC <> 0
001257080324     C                   Leave
001258080325     C                   End
001259080325     C                   Eval      OPTRS = 0
001260080325     C                   Eval      OPSUB = 0
001261080325     C                   Eval      OPPLN = *blanks
001262080324     C                   End
001263080324     C     CLSKEY        reade     CLASS
001264080324     C                   enddo
001265080324     C                   If        OPTRS <> 0
001266080324     C                   Leave
001267080324     C                   End
001268080317     C                   End
001269080325     C                   Read      GRATEL1
001270080317     C                   Enddo
001271080317
001272080317      * A
001273080324     C     CLSKEY        KLIST
001274080324     C                   KFLD                    GRTRST
001275080324     C                   KFLD                    GRSUB#
001276080324     C                   KFLD                    GRPLAN
001277080325
001278080325     C                   ENDSR
001279080325      *___________________________________________________________________
001280080325      * Check ACCT
001281080325      *___________________________________________________________________
001282080325     C     CHKACCT       BEGSR
001283080324      * A
001284080324     C     CKEY          KLIST
001285080324     C                   KFLD                    OPTRS
001286080324     C                   KFLD                    OPSUB
001287080317
001288080317     C     CKEY          Setll     CMCTL2
001289080317     C     CKEY          Reade     CMCTL2
001290080317     C                   Dow       not %eof(CMCTL2)
001297080325     C                   If        CMCAN  = 0       and
001298080325     C                             CMPLAN = OPPLN   or
001299080325     C                             OPPEDT >= EFFDAT and
001300080325     C                             OPPEDT <= CMCAN  and
001301080325     C                             CMPLAN = OPPLN
001302080317     C                   Eval      OPACC = CMACCT
001303080317     C                   Leave
001304080317     C                   End
001305080317     C     CKEY          Reade     CMCTL2
001306080317     C                   Enddo
001307080317
001308080317     C                   ENDSR
001800000000      *___________________________________________________________________
001900000000      * Program open
002000000000      *___________________________________________________________________
002100000000     C     *INZSR        BEGSR
002200000000     C                   ENDSR
