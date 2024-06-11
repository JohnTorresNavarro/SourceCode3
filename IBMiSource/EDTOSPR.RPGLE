000100160811     H ALWNULL(*USRCTL)
000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *_________________________________________________________________________
000500160811     FEDTIN     IF   E           K Disk
000600160811     FACCOSP    IF A E           K Disk
000700160811     FOEUSER    IF A E           K Disk
000800160809
000900160811     D  trs            s              3s 0 inz
001000160725     D  pos            s              3s 0 inz
001100160809     D w80date         S              8S 0
001200160809
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001500160810
001600160811     C     trs           setll     EDTIN
001700160811     C                   read      EDTIN
001800160811     C                   dow       not %eof(EDTIN)
001900160810
002000160811     C                   exsr      gbsaccess
002100160810
002200160811     C                   read      EDTIN
002300160810     C                   enddo
002400160725
002500160725     C                   eval      *inlr = *on
002600160725     C                   return
002700160809      *___________________________________________________________________
002800160811      * load gbsaccess
002900160809      *___________________________________________________________________
003000160811     C     gbsaccess     BEGSR
003100160811
003200160811     C     edtkey        chain     ACCOSP
003300160811     C                   if        not %found(ACCOSP)
003400160811     C                   clear                   accospr
003500160811     C                   eval      AOTRST = XTRUST
003600160811     C                   eval      AOSUB# = XSUB
003700160811     C                   eval      AOACCT = XACCT
003800160812     C                   eval      AOBEDT = 20160813
003900160811     C                   eval      AOENDT = 0
004000160811     C                   eval      AOCODE = 1
004100160812     C                   eval      AOCHDT = 20160813
004200160811     C                   eval      AOCHGU = 'SHELLY'
004300160811     C                   eval      AOPERF = 'N'
004400160811     C                   write     ACCOSPR
004500160811     C                   end
004600160811
004700160811     C                   eval      OUUSER = 'EDTSHELLY'
004800160811     C     usrkey        chain     OEUSER
004900160811     C                   if        not %found(OEUSER)
005000160811     C                   clear                   OEUSERR
005100160811     C                   eval      OUTRST = XTRUST
005200160811     C                   eval      OUSUB# = XSUB
005300160811     C                   eval      OUACCT = XACCT
005400160812     C                   eval      OUUSER = %editc(XTRUST:'X') +
005500160812     C                                      %editc(XSUB:'X') +
005600160812     C                                      %editc(XACCT:'X')
005700160811     C                   eval      OUEMAL = 'SRAPSKI@GBSIO.NET'
005800160811     C                   eval      OULNAM = 'RAPSKI'
005900160811     C                   eval      OUFNAM = 'SHELLY'
006000160812     C                   eval      OUBEDT = 20160813
006100160811     C                   eval      OUEMEX = 'Y'
006200160811     C                   eval      OUENDT = 0
006300160812     C                   eval      OUADDT = 20160813
006400160811     C                   eval      OUADGU = 'SHELLY'
006500160811     C                   eval      OUUSPW = 'GOEDT'
006600160811     C                   write     OEUSERR
006700160811     C                   end
006800160811
006900160809     C                   ENDSR
007000000000      *___________________________________________________________________
007100000000      * Program open
007200000000      *___________________________________________________________________
007300000000     C     *INZSR        BEGSR
007400160811     C     edtkey        klist
007500160811     C                   kfld                    XTRUST
007600160811     C                   kfld                    XSUB
007700160811     C                   kfld                    XACCT
007800160811     C     usrkey        klist
007900160811     C                   kfld                    XTRUST
008000160811     C                   kfld                    XSUB
008100160811     C                   kfld                    XACCT
008200160811     C                   kfld                    OUUSER
008300000000     C                   ENDSR
008400000000      *___________________________________________________________________
008500000000      * Program error handler
008600000000      *___________________________________________________________________
008700000000     C     *PSSR         BEGSR
008800000000     C                   CALL      'SNDRPGM'                            50
008900000000     C                   PARM                    WQPGMN
009000000000     C                   PARM                    WQSTSC
009100000000     C                   PARM                    WQRPGS
009200000000     C                   PARM                    WQMSG
009300000000     C                   ENDSR     '*CANCL'
