000100060228     FGRATE     IPE  E           K DISK
000200060228     FPLNMST    IF   E           K DISK
000300060228     FT2000     O  A F 2000        DISK
000400060228     D #F              S               D   DATFMT(*ISO)
000500060228     D #T              S               D   DATFMT(*ISO)
000600060228     D M               S              6S 0
000700060301     D #ISO            S               D   DATFMT(*ISO)
000800060301     D #TISO           S              8S 0
000900060301     C                   IF        TODAT > #TISO AND GRTRST <> 888
001000060228     C     KEY#PLAN      CHAIN     PLNMSR
001100060228     C                   IF        %FOUND(PLNMST) AND (PLNCAT = 'PMM' OR
001200060228     C                             PLNCAT = 'PMS' OR PLNCAT = 'PME' OR
001300060228     C                             PLNCAT = 'PCE' OR PLNCAT = 'PCS' OR
001400060228     C                             PLNCAT = 'PMC')
001500060228     C                   TEST(DE)                FRMDAT
001600060228     C                   IF        NOT %ERROR
001700060228     C                   TEST(DE)                TODAT
001800060228     C                   IF        NOT %ERROR
001900060228     C                   MOVE      FRMDAT        #F
002000060228     C                   MOVE      TODAT         #T
002100060228     C     #T            SUBDUR    #F            M:*M
002200060228     C                   IF        M > 14
002300060228     C                   MOVE      *BLANKS       @A             2000
002400060228     C     *USA          MOVE      #F            F#                8 0
002500060228     C                   MOVE      F#            F@                8
002600060228     C     *USA          MOVE      #T            T#                8 0
002700060228     C                   MOVE      T#            T@                8
002800060301     C                   EVAL      @A = %CHAR(GRTRST) + ',' + %CHAR(GRSUB#) +
002900060301     C                             ',"' + %TRIM(GRPLAN) + '","' + %TRIM(PDESCR)
003000060301     C                             + '",' + F@ + ',' + T@
003100060228     C                   EXCEPT    OUTF
003200060228     C                   ENDIF
003300060228     C                   ENDIF
003400060228     C                   ENDIF
003500060228     C                   ENDIF
003600060228     C                   ENDIF
003700060301     C     *INZSR        BEGSR
003800060301     C     KEY#SUB       KLIST
003900060301     C                   KFLD                    GRTRST
004000060301     C                   KFLD                    GRSUB#
004100060301     C     KEY#PLAN      KLIST
004200060301     C                   KFLD                    GRTRST
004300060301     C                   KFLD                    GRSUB#
004400060301     C                   KFLD                    GRPLAN
004500060301     C                   MOVE      *DATE         #ISO
004600060301     C                   MOVE      #ISO          #TISO
004700060301     C                   EVAL      @A = '"Trust Number","Subdivision Number",' +
004800060301     C                             '"Plan Number","Plan Description","From Da' +
004900060301     C                             'te","To Date"'
005000060301     C                   EXCEPT    OUTF
005100060301     C                   ENDSR
005200060228     OT2000     EADD         OUTF
005300060228     O                       @A             B  2000
