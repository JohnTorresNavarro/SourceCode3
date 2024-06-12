      *=========================================================================
     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
      *=========================================================================
      * MOO932R - MOO - Account Mapping
      *=========================================================================
      * Date         Int  Description
      * ----------   ---  ------------------------------------------------------
      * 11/21/2023   jt   Original Creation
      * 06/11/2024   jt   Test topic branch
      * 06/11/2024   jt   Test #2 for topic branch
      * 06/11/2024   jt   Done my part.
      * 06/11/2024   ja   Begin work
      * 06/12/2024   jt   Demo for DK
      *=========================================================================

     Fmoo932d   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
     F                                     SFile(SFL1 : RRN)

     Ftrsmst    if   e           k disk    ExtFile('F.TRSMST')
     F                                     rename(trsmsr:trustFile)

     Fsubml1    if   e           k disk    ExtFile('F.SUBML1')
     F                                     rename(submsr:subFile)

     Faccmst    if   e           k disk    ExtFile('F.ACCMST')
     F                                     rename(accmsr:acctFile)

     Fcaraccp   uf a e           k disk    rename(caraccr:setupFile)

     fcarplnq   if a e           k disk    rename(carplnr:setup2File)

     fplnmst    if   e           k disk    extfile('F.PLNMST')
     f                                     rename(plnmsr:planFile)

     fgrate     if   e           k disk    extfile('F.GRATE')
     f                                     rename(grater:rateFile)

     fplnauxl   if   e           k disk    rename(plnauxr:auxFile)

     Fhist      if a e           k disk    ExtFile('F.HIST')
     F                                     rename(histr:histFile)

     Fdiaryhd0  if a e           k disk    ExtFile('F.DIARYHD0')
     F                                     rename(rdiaryhd:diaryFile)

      *=========================================================================

     d psds           sds
     d proc_name         *proc
     d user                  254    263

     d rrn             s              5i 0
     d trstk           s              3  0
     d sub#k           s              3  0
     d acctk           s              4  0
     d valid           s              1
     d option          s              1
     d incarrier       s              2  0
     d unique          s             10
     d trstz           s              3s 0
     d sub#z           s              3s 0
     d acctz           s              4s 0
     d subject         s             27
     d trst            s              3
     d sub             s              3
     d acct            s              4
     d cacid3d         s              8  0
     d continue        s              1
     d function        s             20
     d dspErrMsg       s              1
     d pgmName         s             10

     d showAcct        pr                  ExtPgm('INQ008R')
     d  trstz                         3s 0 const
     d  sub#z                         3s 0 const
     d  acctz                         4s 0 const

     d plans           pr                  ExtPgm('MOO933R')
     d  htrst                         3  0 const
     d  hsub#                         3  0 const
     d  hacct                         4  0 const

     d dltadd          pr                  ExtPgm('TROFF3')
     d  catrst                        3  0
     d  casub#                        3  0
     d  caacct                        4  0
     d  incarrier                     2  0
     d  option                        1

     d e1envir         s             15
     d e1libl          s             10
     d e1Lib2          s             10
     d envColor        s             10
     d e1Acnm          s             40

     d getEnv          pr                  ExtPgm('GETENVR')
     d  e1envir                      15
     d  e1libl                       10
     d  e1Lib2                       10
     d  envColor                     10
     d  e1Acnm                       40

     d ChkPgmAuth      pr                  extpgm('CHKPGMAUTH')
     d  pgmname                      10
     d  continue                      1

     d chkFncAuth      pr                  ExtPgm('CHKFNCAUTH')
     d  pgmname                      10
     d  function                     20
     d  dspErrMsg                     1
     d  continue                      1

     d createEDI       pr                  extpgm('MOO010CT')
     d  sgroup#                       8

     d*pgmTo_call      pr                  extpgm(pgmName)

     d transmitTest    pr                  extpgm('FT_072CT')

      //========================================================================
      // includes
      //========================================================================

      /include GBSPGM/QMODSRC,#GettokPR
      /include GBSPGM/QMODSRC,#zFillpr

      //========================================================================
      // mainline
      //========================================================================

       exsr init;
       exsr main;
       exsr exit;

      //========================================================================
      // main
      //========================================================================

       begsr main;

        dow btnEXIT = '0';

         // Clear the subfile...
         sflclr = '1';

         write sflctl1;
         sflclr = '0';
         rrn = 0;

         // Load the subfile...
         exsr loadSubfile;
         unlock caraccp;

         // Display the subfile.
         sfldsp = '1';
         exfmt sflctl1;

         exsr checkButton;

         sfldsp = '1';

         // Check for icon click.
         readc sfl1;
         if not %eof;

          //Lock record for update, if in change mode.
          if buttonEdit ='1';
           exsr editRecord;
          endif;

          if buttonPlan = '1';
           exsr planRcd;
          endif;

          if buttonTest = '1';
           exsr sendTest;
          endif;

          if seltsa = '1';
           exsr showAccount;
          endif;

         endif;

        enddo;

       endsr;

      //========================================================================
      // load subfile
      //========================================================================

       begsr loadSubfile;

        if s1ActNbr > ' ';
         split();
         trstk = %dec(trst:3:0);
         sub#k = %dec(sub:3:0);
         acctk = %dec(acct:4:0);
        endif;

        if s1ActNbr > ' ';
         setll (unique: trstk : sub#k : acctk) setupFile;
        else;
         setll (unique) setupFile;
        endif;

        reade unique setupFile;

        dow not %eof;
         if transmitCk = 'Y';
          if castatus = 'Y';
           rrn += 1;
            exsr moveFields;
           write sfl1;
          endif;
         endif;

         if transmitCk  = ' ';
          rrn += 1;
           exsr moveFields;
          write sfl1;
         endif;

        reade unique setupFile;
        enddo;

       endsr;

      //========================================================================
      // move fields
      //========================================================================

       begsr moveFields;

        htrst = catrst;
        hsub# = casub#;
        hacct = caacct;
        tsa = %editc(catrst:'X') + '-' + %editc(casub#:'X') + '-' +
              %editc(caacct:'X');

        grnames = ' ';
        chain (catrst : casub# : caacct) acctFile;
        if %found;
         grnames = acnam1;

         canceled = ' ';
         if atrmdt > 0;
          canceled = '#ff0000';
         endif;

        endif;

        sgroup# = cacid2;
        if cacid2 = ' ';
         //exsr getGroup;
         //update setupFile;
        endif;

        transmit = castatus;

       endsr;

      //========================================================================
      // checkButton
      //========================================================================

       begsr checkButton;

        if buttonEdit = '1';
         exsr editRecord;
        endif;

        if buttonAdd  = '1';
         exsr addRcd;
        endif;

        if btnRefresh  = '1';
         s1ActNbr = ' ';
         btnRefresh = '0';
        endif;

        if buttonPlan = '1';
        endif;

       endsr;

      //========================================================================
      // add record
      //========================================================================

       begsr addRcd;

        addRecord = '0';
        btnExtAdd = '0';
        strst = 0;
        ssub# = 0;
        sacct = 0;
        stransmit = 'N';
        errTrust = '0';
        errSub = '0';
        errAcct = '0';

        dow btnExtAdd = '0';

         exfmt adddtl;

         if btnExtAdd = '1';
          leavesr;
         endif;

         exsr validAdd;

         if valid  = '1';
          btnExtAdd = '0';
         else;
          btnExtAdd = '1';
         endif;

        enddo;

       endsr;

      //========================================================================
      // plan record
      //========================================================================

       begsr planRcd;

        plans(htrst : hsub# : hacct);

        s1ActNbr = %editc(htrst:'X') + '-' + %editc(hsub#:'X') +
                   '-' + %editc(hacct:'X');

        buttonPlan = '0';

       endsr;

      //========================================================================
      // send test
      //========================================================================

       begsr sendTest;

        pgmName = 'MO' + sgroup#;
        createEDI(sgroup#);
        //pgmTo_call();
        transmitTest();

       endsr;

      //========================================================================
      // valid record
      //========================================================================

        begsr validAdd;

         valid = '0';
         errTrust = '0';
         errSub = '0';
         errAcct = '0';
         errGroup# = '0';
         errBGrpID = '0';
         errDate = '0';

         chain strst trustFile;
         if not %found;
          errTrust = '1';
          valid = '1';
         endif;

         chain ssub# subFile;
         if not %found;
          errSub = '1';
          valid = '1';
         endif;

         chain (strst : ssub# : sacct) acctFile;
         if not %found;
          errAcct = '1';
          valid = '1';
         endif;

         if sgroup = ' ';
          errGRoup# = '1';
           valid = '1';
          leavesr;
         endif;

         if sbilgrpid = ' ';
          errBGrpID = '1';
           valid = '1';
          leavesr;
         endif;

         if sstartdate = d'0001-01-01';
          errDate = '1';
           valid = '1';
          leavesr;

         endif;
         if valid = '0';
          exsr addRecd;

          s1ActNbr = %editc(strst:'X') + '-' + %editc(ssub#:'X') +
                     '-' + %editc(sacct:'X');
         endif;

        endsr;

      //========================================================================
      // valid add
      //========================================================================

        begsr addRecd;

         cauniq = unique;
         catrst = strst;
         casub# = ssub#;
         caacct = sacct;
         castatus = stransmit;
         castatus = stransmit;

         chain (catrst : casub# : caacct) acctFile;
         if %found;
          cacid1 = acnam1;
         endif;

         cacid2 = sgroup;
         cacid3 = %char(%dec(sstartdate));
         cacid4 = sbilgrpid;

         //exsr getGroup;

         exsr add_toTransfile;

         write setupFile;

        endsr;

      //========================================================================
      // get group
      //========================================================================

       begsr getGroup;

        setll (strst : ssub# : sacct) auxFile;
        reade (strst : ssub# : sacct) auxFile;
        dow not %eof;

         chain (strst : ssub# : pxplan) planFile;
         if pcarr = 'HAR' or pcarr = 'SBS';

          chain (strst : ssub# : pxplan) rateFile;
          if %found;
           cacid2 = group#;
           leavesr;
          endif;

         endif;

        reade (strst : ssub# : sacct) auxFile;
        enddo;

       endsr;

      //========================================================================
      // add plans
      //========================================================================

       //begsr addPlans;

       // setll (strst : ssub# : sacct) auxFile;
       // reade (strst : ssub# : sacct) auxFile;
       // dow not %eof;

       //  chain (strst : ssub# : pxplan) planFile;
       //  if pcarr = 'HAR' or pcarr = 'SBS';

       //  chain (unique : strst : ssub# : pxplan : sacct) setup2File;
       //   if %found;
       //    leavesr;
       //   endif;

       //   chain ('9000000003' : strst : ssub# : pxplan : sacct) setup2File;
       //   if not %found;
       //    cpuniq = '9000000003';
       //    cptrst = strst;
       //    cpsub# = ssub#;
       //    cpacct = sacct;

       //    if plncat = 'PHI';
       //     cpcctr = 'HIP';
       //    endif;

       //    if plncat = 'PO6';
       //     cpcctr = 'VAC';
       //    endif;

       //    cpplan = pxplan;

       //    chain (strst : ssub# : pxplan) rateFile;
       //    if %found;
       //     cpcid1 = %subst(group#:1:6);
       //     cptxt1 = 'GROUP #';
       //    endif;

       //    cptxt2 = 'PLAN OPTION';
       //    cptxt3 = 'GROUP ID';
       //    cptxt4 = 'PLAN #';
       //    cptxt5 = 'CLASS CODE';

       //    write setup2File;
       //   endif;

       //  endif;

       // reade (strst : ssub# : sacct) auxFile;
       // enddo;

       //endsr;

      //========================================================================
      // edit record
      //========================================================================

       begsr editRecord;

        btnUpdRcd = '0';
        btnExtEdt = '0';
        strst = htrst;
        ssub# = hsub#;
        sacct = hacct;
        stransmit = transmit;

        sgroup = cacid2;
        cacid3d = %dec(cacid3:8:0);
        sstartdate = %date(cacid3d:*iso);
        sbilgrpid = cacid4;


        chain(n) (unique : strst : ssub# : sacct) setupFile;

        errTrust = '0';
        errSub = '0';
        errAcct = '0';

        dow btnExtEdt = '0';

         exfmt maintdtl;

         if btnUpdRcd = '1';
          exsr validEdit;
         endif;

        enddo;

        s1ActNbr = %editc(htrst:'X') + '-' + %editc(hsub#:'X') +
                   '-' + %editc(hacct:'X');

        buttonEdit = '0';

       endsr;

      //========================================================================
      // valid record
      //========================================================================

        begsr validEdit;

         valid = '0';
         errTrust = '0';
         errSub = '0';
         errAcct = '0';
         errGroup# = '0';
         errBGrpID = '0';
         errDate = '0';

         chain strst trustFile;
         if not %found;
          errTrust = '1';
           valid = '1';
          leavesr;
         endif;

         chain ssub# subFile;
         if not %found;
          errSub = '1';
           valid = '1';
          leavesr;
         endif;

         chain (strst : ssub# : sacct) acctFile;
         if not %found;
          errAcct = '1';
           valid = '1';
          leavesr;
         endif;

         if sgroup = ' ';
          errGRoup# = '1';
           valid = '1';
          leavesr;
         endif;

         if sbilgrpid = ' ';
          errBGrpID = '1';
           valid = '1';
          leavesr;
         endif;

         if sstartdate = d'0001-01-01';
          errDate = '1';
           valid = '1';
          leavesr;
         endif;

         if valid = '0';
          exsr edtRecord;
          btnExtEdt = '1';
         endif;

        endsr;

      //========================================================================
      // edit record
      //========================================================================

        begsr edtRecord;

         chain (unique : htrst : hsub# : hacct) setupFile;
         catrst = strst;
         casub# = ssub#;
         caacct = sacct;
         castatus = stransmit;

         cacid2 = sgroup;
         cacid3 = %char(%dec(sstartdate));
         cacid4 = sbilgrpid;

         exsr add_toTransfile;

         update setupFile;

        endsr;

       //===========================================================================================
       // Add to Transmission file
       //===========================================================================================

       begsr add_toTransfile;

        select;
         when castatus = 'Y';
          option = 'D';
          incarrier = 22;
          dltadd(catrst : casub# : caacct : incarrier : option);

         when castatus = 'N';
          option = 'A';
          incarrier = 22;
          dltadd(catrst : casub# : caacct : incarrier : option);

         other;
          option = 'X';
          incarrier = 22;
          dltadd(catrst : casub# : caacct : incarrier : option);
        endsl;

        exsr history;

       endsr;

      //========================================================================
      // show account
      //========================================================================

       begsr showAccount;

       trstz= htrst;
       sub#z= hsub#;
       acctz= hacct;

       showAcct(trstz : sub#z: acctz);

       seltsa = ' ';

       endsr;

      //===========================================================================
      // history
      //===========================================================================

       begsr history;

        select;
         when castatus = 'Y';
          subject = 'MOO-TRANSMISSION TURNED ON';

         when castatus = 'N';
          subject = 'MOO-TRANSMISSION TURNED OFF';

         other;
          subject = 'MOO-TRANSMISSION IN TESTING';
        endsl;

        clear diaryFile;
        nhkey = %editc(catrst:'X') + %editc(casub#:'X') + %editc(caacct:'X');
        nhcode = 'WFT';
        nhaddt = %dec(%date);
        nhadti = %dec(%time);
        nhadus = user;
        nhsubj = subject;

        write diaryFile;

        clear histFile;
        hkey = %editc(catrst:'X') + %editc(casub#:'X') + %editc(caacct:'X');
        trcode = 'UHM';
        hprgnm = proc_name;
        hstrst = catrst;
        hssub# = casub#;
        hsacct = caacct;
        hsdltd = 'A';
        trdate = %dec(%date);
        hstrtime = %time;
        hoper = user;
        ck#not = subject;

        write histFile;

       endsr;

      //========================================================================
      // exit
      //========================================================================

       begsr exit;

        *inlr = '1';
        return;

       endsr;

      //========================================================================
      // init
      //========================================================================

       begsr init;

        btnREFRESH = '0';
        btnEXIT = '0';
        btnUpdRcd = '0';
        buttonPlan = '0';
        buttonEdit = '0';
        buttonAdd = '0';

        sfldsp = '0';
        sflclr = '0';

        pgmname = proc_name;

        ChkPgmAuth(pgmname : continue);
        if continue = 'N';
         exsr exit;
        endif;

        unique = '0000000319';

        getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);

        function = 'SENDTEST';
        dspErrMsg = 'N';

        ChkFncAuth(pgmname : function : dspErrMsg : continue);
        if continue = 'Y';
         showTest = '1' and e1libl = 'QS36F';
        else;
         showTest = '0';
        endif;

       endsr;

      //========================================================================
      // Split out the account number
      //========================================================================

       Dcl-Proc Split;

         dcl-s x int(10);
         dcl-s tokens varchar(100) dim(50);

         tokens(*) = #Gettok( s1ActNbr : '-' : x );

         x = %lookup( '' : tokens ) ;
         if x = 2;
           Trst = #zFill( 3 : %Trim( Tokens(1) ));
           Sub  = '000';
           Acct = '0000';

           s1ActNbr = trst + '-' + Sub + '-' + Acct;
         EndIf;

         if x = 3;
           Trst = #zFill( 3 : %Trim( Tokens(1) ));
           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
           Acct = '0000';

           s1ActNbr = trst + '-' + Sub + '-' + Acct;
         EndIf;

         if x = 4;
           Trst = #zFill( 3 : %Trim( Tokens(1) ));
           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
           Acct = #zFill( 4 : %Trim( Tokens(3) ));

           s1ActNbr = trst + '-' + Sub + '-' + Acct;
         EndIf;

       End-Proc;

      //========================================================================
