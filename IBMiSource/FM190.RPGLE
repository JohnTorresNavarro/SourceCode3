0001009408170002 F******************************************************************
0002001205090003 F* fm190      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004001205090005 F*            WRITTEN BY - RLJ
0005001205090006 F*            DATE - 05/04/12                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008001205090009 F*            invdnp FILE (invoice do not publish file).          *
0009009408170010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012001205090013 Ffm190D    CF   E             WORKSTN
001300120510     F                                     SFILE(SF01:RRN)
0014001205090015 Finvdnp    UF A E           K DISK
0015001310290015 Fhistaa    iF A E           K DISK
0016001205090015 Faccmst    IF   E           K DISK
0017001205100015 Fgbsecure  IF   E           K DISK
0018001206040015 Fhisttcd   IF   E           K DISK    PREFIX(T)
001900120604     F                                     RENAME(histr:thistr)
0020001205090012  *                                                                *
002100120604     d svcovt          S                   LIKE(covtdt)
002200120604     d hldrsn          S                   LIKE(INDREAS)
002300120510     d dateusa         S               D   DATFMT(*USA/)
002400120604     d dateiso         S               D   DATFMT(*ISO)
002500120510     dv                s              1    inz('V')
002600020705     dY                s              1    inz('Y')
002700020702     dleave            s              1    inz('N')
002800120604     dleavsf           s              1    inz('N')
002900020702     dleavescrn02      s              1
003000020702     dmsg1             s             60    inz('INVALID ACCOUNT NUMBER')
003100120509     dmsg1a            s             60    inz('INVOICE DOES NOT EXIST')
003200020702     dmsg2             s             60    inz('ACCOUNT EXISTS - PRESS F4 TO DE-
003300020702     d                                     LETE OR ENTER TO UPDATE')
003400120604     dtravi            s              3    inz('AVI')
003401131025     D thispgmname     S             10a   inz('FM190     ')
003500120510      *
003600120510     D                 DS
003700120510     D  KHIST                  1     30
003800120510     D   KHIST1                1      5    INZ('INV#-')
003900120510     D   KHIST2                6     12
004000120510     D   KHIST3               13     30    INZ(*BLANKS)
004100120510      *
004200950126     D COMPAN          DS
004300940921     D*  DATA AREA - COMPANY NAME
004400940921     D  COMP                   1     55
004500970401     D                 DS
004600970401     D  TSA                    1     10  0
004700120510     D  indtrust               1      3  0
004800120510     D  indsub                 4      6  0
004900120510     D  indacc                 7     10  0
005000120604     D   TSAA                  1     10
005100020702     D                uDS
005200020702     D  luser                  1     10
005300120509      *
005400120604     C     hisaky        KLIST
005500120604     C                   KFLD                    tsaa
005600120604     C                   KFLD                    travi
005700120604      *
005800120604     C     inpkey        KLIST
005900120604     C                   KFLD                    inptrust
006000120604     C                   KFLD                    inpsub
006100120509     C                   KFLD                    inpacc
006200120510      *
006300120510     C     acckey        KLIST
006400120510     C                   KFLD                    indtrust
006500120510     C                   KFLD                    indsub
006600120510     C                   KFLD                    indacc
006700120509      *
006800120509     C     dnpkey        KLIST
006900120509     C                   KFLD                    inptrust
007000120509     C                   KFLD                    inpsub
007100120509     C                   KFLD                    inpacc
007200120509     C                   KFLD                    inpinv#
007300120509      *
007400120604      *
007500120604      *
007600070514     C                   clear                   inptrust
007700070514     C                   clear                   inpsub
007800070514     C                   clear                   inpacc
007900120509     C                   clear                   inpinv#
008000120509      *
008100020702     c                   dou       leave = 'Y'
008200120509      *
008300020702     C                   eval      *in04 = *off
008400020702     C                   EXFMT     SCRN01
008500020702     c                   clear                   msg
0086001205090077  *  f7 END
0087000207020079 C                   if        *in07
0088009409210080 C                   SETON                                        LR
0089001205090080 C                   return
009000120509     C                   endif
0091001205090076  *
0092001205090077  *  f5 Display Subfile of Invoices
0093001205090078  *
0094000207020079 C                   if        *in05
0095001205090080 C                   exsr      listinv
0096000207020080 C                   iter
009700120509     C                   endif
0098001205090078  *
0099001205090077  *  f9 email list of accts to yourself
0100000207020079 C                   if        *in09
0101001205090080 C                   call      'FM191CL'
0102000207020080 C                   iter
010300120509     C                   endif
0104001205090076  *
010500070514     C     inpkey        CHAIN     ACCMST
010600020702     c                   if        not %found(accmst)
010700020702     c                   movel     msg1          msg
0108000207020168 C                   iter
010900120509     c                   endif
0110001206040076  *    See if HIST rec exists for INV# and is the right TSA
011100120510     C                   MOVEL     *BLANKS       KHIST
011200120510     C                   MOVEL     'INV#-'       KHIST1
011300120510     C                   EVAL      KHIST2 = %EDITC(inpinv# : '3')
011400120510     C     KHIST         CHAIN     HISTTCD
011500120510     c                   if        not %found(histtcd)
011600120510     c                   movel     msg1a         msg
0117001205100168 C                   iter
011800120510     c                   endif
011900120604     c                   if        inptrust <> thstrst or
012000120604     c                             inpsub <> thssub# or
012100120604     c                             inpacc <> thsacct
012200120510     c                   movel     msg1a         msg
0123001205100168 C                   iter
012400120604     c                   endif
012500120604     c                   movel     tcovtdt       svcovt
0126001205090076  *
012700120509     c                   eval      dspnam1 = acnam1
0128001205090076  *
012900120509     C     dnpkey        CHAIN     invdnp
013000120509     c                   if        not %found(invdnp)
013100120509     c                   exsr      adddnp
013200020702     c                   else
013300120509     c                   exsr      chgdnp
013400120509     c                   endif
013500120509      *
013600120509     C                   clear                   inptrust
013700120509     C                   clear                   inpsub
013800120509     C                   clear                   inpacc
013900120509     C                   clear                   inpinv#
014000120509      *
014100120509     c                   enddo
014200120509      *
014300120509      **************************************************************
014400120509      *
014500120509      *        Add new INVDNP record
014600120509      *
014700120509      **************************************************************
014800120509     C     adddnp        BEGSR
014900120509      *
015000120509     c                   clear                   inprsn
015100120604      *      See in Invoice is Voided
015200120604     C                   EVAL      KHIST2 = %EDITC(inpinv# : '3')
015300120604     C                   EVAL      voidyn = 'N'
015400120604     C     hisaky        SETLL     histaa
015500120604     C                   dou       *in61 = '1'
015600120604     C     hisaky        reade     histaa                                 61
015700120604     C                   if        *in61 = *off
015800120604     C                   if        khist = ck#not
015900120604     C                   eval      voidyn = 'Y'
016000120604     C                   leave
016100120604     C                   endif
016200120604     C                   endif
016300120604     C                   enddo
016400120509      *
016500120509     c                   dou       leave = 'Y'
016600120509      *
016700120509     c                   exfmt     scrnadd
016800020702     c                   clear                   msg
016900120509      *
017000120509      *      f1 - return to 1st screen - do not add
017100020702     c                   if        *in01
017200120509     c                   leavesr
017300120509     c                   endif
017400120509      *
0175001205090076  *      must enter reason
017600120509     C                   if        inprsn = *blanks
017700070529     C                   eval      msg = '* PLEASE ENTER A REASON *'
017800070529     c                   iter
017900120509     C                   endif
018000120509      *
0181001205090076  *      Write new record
018200120509     C                   clear                   invdnpr
018300120509     C                   eval      indtrust = inptrust
018400120509     C                   eval      indsub = inpsub
018500120509     C                   eval      indacc = inpacc
018600120509     C                   eval      indinv# = inpinv#
018700120509     C                   movel(P)  inprsn        indreas
018800120605     C                   move      *date         inddate
018900120604     C                   time                    indtime
019000120604     C                   move      luser         induser
019100120604     C                   write     invdnpr
0192001206040076  *      Write HIST record for add DNP rec
019300120604     C                   clear                   histr
019400120604     C                   movel     TSA           hkey
019500120604     C                   eval      trcode = 'U79'
019600120605     C                   eval      note2 = khist
019700131025     C                   movel     thispgmname   hprgnm
019800120604     C                   eval      hstrst = inptrust
019900120604     C                   eval      hssub# = inpsub
020000120604     C                   eval      hsacct = inpacc
020100120604     C                   movel(P)  luser         hoper
020200120604     C                   eval      hsdltd = 'A'
020300120605     C                   move      *date         inddate
020400120604     C                   move      inddate       trdate
020500120604     c                   movel     svcovt        covtdt
020501131029     c                   eval      hstrtime = %time
020600120604     c                   write     histr
020700120604      *
020800120509     C                   leavesr
020900120509      *
021000120509     C                   enddo
021100120509      *
021200120509     C                   endsr
021300120509      **************************************************************
021400120509      *
021500120509      *        Change/Delete existing INVDNP record
021600120509      *
021700120509      **************************************************************
021800120509     C     chgdnp        begsr
021900120510      *
022000120510     c                   eval      msg = 'INVOICE EXISTS - Enter to Change'
022100120510     c                   dou       leave = 'Y'
022200120510      *
022300120510     c                   eval      hldrsn = indreas
022400120510     c                   eval      chgrsn = indreas
022500120510     c                   eval      chguser = induser
022600120510     c                   eval      dateusa = inddate
022700120510     c                   movel     dateusa       chgdate
022800120604      *      See in Invoice is Voided
022900120604     C                   EVAL      KHIST2 = %EDITC(inpinv# : '3')
023000120604     C                   EVAL      voidyn = 'N'
023100120604     C     hisaky        SETLL     histaa
023200120604     C                   dou       *in61 = '1'
023300120604     C     hisaky        reade     histaa                                 61
023400120604     C                   if        *in61 = *off
023500120604     C                   if        khist = ck#not
023600120604     C                   eval      voidyn = 'Y'
023700120604     C                   leave
023800120604     C                   endif
023900120604     C                   endif
024000120604     C                   enddo
024100120604      *
024200120510     c                   exfmt     scrnchg
024300120510     c                   clear                   msg
024400120510      *
024500120510      *      f1 - return to 1st screen - do not chg
024600120510     c                   if        *in01
024700120510     c                   leavesr
024800120510     c                   endif
024900120510      *
025000120510      *      f4 - Delete record
025100120510     c                   if        *in04
0252001206040076  *      Write HIST record for remove DNP rec
025300120604     C                   clear                   histr
025400120604     C                   movel     TSA           hkey
025500120604     C                   eval      trcode = 'U80'
025600120605     C                   eval      note2 = khist
025700131025     C                   movel     thispgmname   hprgnm
025800120604     C                   eval      hstrst = inptrust
025900120604     C                   eval      hssub# = inpsub
026000120604     C                   eval      hsacct = inpacc
026100120604     C                   movel(P)  luser         hoper
026200120604     C                   eval      hsdltd = 'A'
026300120605     C                   move      *date         inddate
026400120604     C                   move      inddate       trdate
026500120604     c                   movel     svcovt        covtdt
026501131029     c                   eval      hstrtime = %time
026600120604     c                   write     histr
026700120604      *
026800120510     c                   delete    invdnpr
026900120510     c                   leavesr
027000120510     c                   endif
027100120510      *
0272001205100076  *      must enter reason
027300120510     C                   if        chgrsn = *blanks
027400120510     C                   eval      msg = '* PLEASE ENTER A REASON *'
027500120510     c                   iter
027600120510     C                   endif
027700120510      *
0278001205100076  *      did reason change
027900120510     C                   if        chgrsn = hldrsn
028000120510     C                   eval      msg = '* REASON DID NOT CHANGE *'
028100120510     c                   iter
028200120510     C                   endif
028300120510      *
0284001205100076  *      Update record
028500120510     C                   movel(P)  chgrsn        indreas
028600120510     c                   move      *date         inddate
028700120510     c                   time                    indtime
028800120510     c                   move      luser         induser
028900120510     c                   update    invdnpr
029000120510     C                   leavesr
029100120510      *
029200120510     C                   enddo
029300120510      *
029400120510     C                   endsr
029500120509      **************************************************************
029600120509      *
029700120509      *        Display subfile of existing Invoices in INVDNP
029800120509      *
029900120509      **************************************************************
030000120509     C     listinv       begsr
030100120510      *
030200120604     C                   MOVE      '0'           *IN53
030300120604     C                   eval      leavsf = 'N'
030400120604      *
030500120604     C                   dou       leavsf = 'Y'
030600120510      * CLEAR SUBFILE
030700120510      *
030800120510     C                   MOVEA     '001'         *IN(90)
030900120510     C                   WRITE     SF01CTL
031000120510     C                   MOVE      '0'           *IN92
031100120510      *
031200120510      * BUILD SUBFILE
031300120510      *
031400120510     C                   MOVE      *ZEROS        RRN               5 0
031500120510     C     *LOVAL        SETLL     invdnp
031600120510      *
031700120510     C                   dou       %eof(invdnp)
031800120510      *
031900120510     C                   READ(n)   invdnp                                 91
032000120510     C                   if        *in91 = *off
032100120510     C     acckey        CHAIN     ACCMST                             50
032200120510     c                   if        %found(accmst)
032300120510     C                   MOVEL     ACNAM1        NAME
032400120510     c                   else
032500120510     C                   clear                   NAME
032600120510     c                   end
032700120510      *
032800120510     c     induser       chain     gbsecure
032900120510     c                   if        %found(gbsecure)
033000120510     c                   movel     scname        user
033100120510     c                   else
033200120510     c                   clear                   user
033300120510     c                   end
033400120510      *
033500120510     c                   movel     indinv#       sfinv#
033600120604     c                   movel     indreas       reason17
033700120510     c                   extrct    inddate:*d    da                2
033800120510     c                   extrct    inddate:*m    mo                2
033900120510     c                   extrct    indtime:*h    ho                2
034000120510     c                   extrct    indtime:*mn   mi                2
034100120510     c                   movel     mo            date
034200120510     c                   move      da            date
034300120510     c                   movel     ho            time
034400120510     c                   move      mi            time
034500120604      *      See in Invoice is Voided
034600120604     C                   EVAL      KHIST2 = %EDITC(indinv# : '3')
034700120604     C                   EVAL      vdyn = 'N'
034800120604     C     hisaky        SETLL     histaa
034900120604     C                   dou       *in61 = '1'
035000120604     C     hisaky        reade     histaa                                 61
035100120604     C                   if        *in61 = *off
035200120604     C                   if        khist = ck#not
035300120604     C                   eval      vdyn = 'Y'
035400120604     C                   leave
035500120604     C                   endif
035600120604     C                   endif
035700120604     C                   enddo
035800120604      *
035900120604     C                   if        vdyn = 'Y' and *in53 = '1'
036000120604     C                   iter
036100120604     C                   endif
036200120510      *
036300120510     C                   ADD       1             RRN
036400120510     C                   WRITE     SF01
036500120510     C                   END
036600120510      *
036700120510     c                   enddo
036800120510      *
036900120510      * DISPLAY SUBFILE IN WINDOW
037000120510      *
037100120510     C                   if        rrn > 0
037200120510     C                   eval      *in90 = *on
037300120510     C                   end
037400120510      *
037500120510     C                   WRITE     WINDOW
037600120510     C                   EXFMT     SF01CTL
0377001205100077  *  f9 email list of accts to yourself
0378001205100079 C                   if        *in09
0379001205100080 C                   call      'FM191CL'
038000120604     C                   eval      leavsf = 'Y'
038100120604     C                   END
0382001206040077  *  f13 toggle between show/hide voided invoices
0383001206040079 C                   if        *in13
0384001206040079 C                   if        *in53 = '1'
0385001206040080 C                   eval      *in53 = '0'
038600120604     C                   else
0387001206040080 C                   eval      *in53 = '1'
038800120604     C                   END
038900120604     C                   Else
039000120604     C                   eval      leavsf = 'Y'
039100120604     C                   END
0392001205100076  *
039300120604     C                   ENDDO
0394001206040076  *
039500120510     C                   MOVE      *ZEROS        TSA
039600120509      *
039700120509     C                   endsr
039800120509      **************************************************************
039900120509      *
040000120509      *        Initial subroutine
040100120509      *
040200120509      **************************************************************
040300020701     C     *inzsr        BEGSR
040400020701     C*
040500020701     C* GET DATA AREA AND IMMEDIATELY RELEASE
040600020701     C*
040700020701     C     *DTAARA       DEFINE                  COMPAN
040800020701     C                   IN        COMPAN
040900020701     C                   MOVEL     COMP          COMPNY
041000020701     C                   ENDSR
