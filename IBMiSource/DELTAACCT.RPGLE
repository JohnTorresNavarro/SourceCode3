000101211216      *================================================================================
000102211216     H option(*noDebugIo)
000103211216      *================================================================================
000104211218      * DELTACCT - Write records to CARACCP and CARPLNP
000105211216      *================================================================================
000106211216      * Date        Int   Description
000107211216      * ----------  ---   -------------------------------------------------------------
000108211216      * 12/16/2021  jt    Original creation
000109211216      *================================================================================
000111211216
001400211218     fcaraccp   if a e           k disk    rename(caraccr:setupFile)
001402211216
001403211218     fcarplnz   if a e           k disk    rename(carplnr:planFile)
001404211218
001405211218     fdelta     if   e             disk    rename(delta:deltaFile)
001503211216
001504211218      //=======================================================================
001505211218
001506211218     d unique          s             10
001507211218
002104211216      //=======================================================================
002105211216      // mainline
002106211216      //=======================================================================
002107211216
002108211216       exsr init;
002109211216       exsr main;
002110211216       exsr exit;
002111211216
002126211216       //=======================================================================
002127211216       // main2subr
002128211216       //=======================================================================
002129211216
002130211216       begsr main;
002131211216
002132211218        setll 1 deltaFile;
002133211218        read deltaFile;
002135211218         dow not %eof;
002136211218         if dwacct > 0;
004304211216
004305211218         chain (unique : dwtrst : dwsub# : dwacct) setupFile;
004306211218         if not %found;
004307211218          cauniq = unique;
004308211218           catrst = dwtrst;
004309211218            casub# = dwsub#;
004310211218             caacct = dwacct;
004311211218            cacid3 = dwgrp#;
004312211218           castatus = 'Y';
004313211218          write setupFile;
004314211218         endif;
004315211218         endif;
004316211218
004317211218        read deltaFile;
004601211216        enddo;
005700211216
005701211218        setll 1 deltaFile;
005702211218        read deltaFile;
005703211218         dow not %eof;
005704211218         if dwacct > 0;
005705211218
005706211218         chain (unique : dwtrst : dwsub# : dwacct : dwplan) planFile;
005707211218         if not %found;
005708211218          cpuniq = unique;
005709211218           cptrst = dwtrst;
005710211218            cpsub# = dwsub#;
005711211218            cpacct = dwacct;
005712211218           cpplan = dwplan;
005713211218          write planFile;
005714211218         endif;
005715211218         endif;
005716211218
005717211218        read deltaFile;
005718211218        enddo;
005719211218
005800211216       endsr;
005801211216
005904211216       //=======================================================================
005905211216       // exit
005906211216       //=======================================================================
005907211216
005908211216       begsr exit;
005909211216
005910211216        *inlr = '1';
005911211216        return;
005912211216
005913211216       endsr;
005914211216
005915211216       //=======================================================================
005916211216       // init subr
005917211216       //=======================================================================
005918211216
005919211216       begsr init;
005920211218
005921211218        unique = '0000000391';
005922211216
005923211216       endsr;
005924211216
005925211216       //=======================================================================
