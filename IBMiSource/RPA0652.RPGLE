000100030414   X***X SSK 04/19/2003
000200030414   X***X ASSIGN SUPER AGENCY BASED OFF RELATIONSHIP ID
000300030414   X***X FOR REPORTING PURPOSES
000400030414   X***X
000500030414   X***X
000600030414   X***X
000700030414     FRPA065RPT UPEA E             DISK
000800030414     FSPRAGXR2  IF   E           K DISK
000900030414     FSMANRLT   IF   E           K DISK
001000030414   X***X
001100030414     C     RPRELID       CHAIN     SRF
001200030414     C                   IF        %FOUND(SMANRLT)
001300030414     C     SRASID        CHAIN     SXF
001400030414     C                   IF        %FOUND(SPRAGXR2)
001500030414     C                   EVAL      RPSUPER = SXSUPER
001600030414     C                   UPDATE    RPA65W
001700030414     C                   ENDIF
001800030414     C                   ENDIF
