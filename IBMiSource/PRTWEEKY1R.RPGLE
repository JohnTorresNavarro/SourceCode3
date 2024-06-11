000100160520     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBDIR')
000200160406      *-------------------------------------------------------------------------
000300160406      *
000400210831      *  Description: Online Enrollment Weekly Summary Report
000500191015      *  Programmer.: Jon Allen
000600210831      *  Date.......: 08/31/2021
000700160406      *
000800160406      *-------------------------------------------------------------------------
000900160406      * Modifications
001000160406      *
001100160406      * Date         Programmer    Mod      Description
001200160406      *-------------------------------------------------------------------------
001300181121      *
001400181121      *
001500181121      *
001600160406      *-------------------------------------------------------------------------
001700210831     FPRTWEEKYP UF   E           K Disk
001800210831     FWEBTRANL41IF   E           K Disk
001900191015
002000160406      *?Program status data structure
002100160406     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200160406     D  @pgmq            *proc
002300160406
002400210831     D wwfr            s              8s 0 inz
002500210831     D wwto            s              8s 0 inz
002600210831
002700160406      *?Variables
002800210831     D SVTRN#          s              9s 0 inz
002900191016
003000191016      *-------------------------------------------------------------------------
003100191016      *?Mainline Program
003200191016      *-------------------------------------------------------------------------
003300210831
003400210831     C     *entry        Plist
003500210831     C                   Parm                    wifr              8
003600210831     C                   Parm                    wito              8
003700210831
003800210831     C                   move      wifr          wwfr
003900210831     C                   move      wito          wwto
004000191016
004100210831     C     *loval        setll     prtweekyp
004200210831     C                   read      prtweekyp
004300210831     C                   dow       not %eof(prtweekyp)
004400210903     C                   if        wkcount = 0
004500191016     C                   exsr      trncount
004600210831     C                   update    prtweekyr
004700210903     C                   end
004800210831     C                   read      prtweekyp
004900191016     C                   enddo
005000191016
005100191016     C                   eval      *inlr = *on
005200191016     C                   return
005300160406      *-------------------------------------------------------------------------
005400210831      *?Count weekly trans
005500160406      *-------------------------------------------------------------------------
005600191016     C     trncount      begsr
005700210831     C                   clear                   WKCOUNT
005800210831     C                   clear                   SVTRN#
005900210831
006000210831     C     oekey         klist
006100210831     C                   kfld                    WKTRST
006200210831     C                   kfld                    WKSUB#
006300210831     C                   kfld                    WKACCT
006400210831     C                   kfld                    WKGRPV
006500191016
006600210831     C     oekey         setll     webtranl41
006700210831     C     oekey         reade     webtranl41
006800210831     C                   dow       not %eof(webtranl41)
006900210831     C                   if        oeaddd >= wwfr and oeaddd <= wwto
007000210831     C                   if        OETRN# <> SVTRN#
007100210831     C                   eval      wkcount = wkcount + 1
007200210831     C                   eval      SVTRN# = OETRN#
007300210831     C                   end
007400191016     C                   end
007500210831     C     oekey         reade     webtranl41
007600191016     C                   enddo
007700191016
007800191016     C                   endsr
