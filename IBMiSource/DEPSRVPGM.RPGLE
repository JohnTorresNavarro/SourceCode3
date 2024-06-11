000100130909     Hnomain option(*nodebugio) debug copyright('GBS - GroupBenefitServices')
000200130909
000300130909      *------------------------------------------------------------------
000400140102      * Module Name...DEPSRVPGM
000500130909      * Written by...:Debora Bond
000600140102      * Date Written.:01/02/2014
000700140102      * Description..:Module within service program DEPSRVPGM....functions
000800140811      *               related to DEPEND
000900130909      * Called From..:Any program
001000130909      *
001100130909      *------------------------------------------------------------------
001200130909      * Modification History:
001300130909      *
001400130909      *    Date    Description                                       By
001500130909      *  --------  -----------------------------------------        ----
001600130909      *------------------------------------------------------------------
001700130909
001800140104     Fdepndc    if   e           k disk    extfile('F.DEPNDC') usropn
001900130909
002000140104      *---------------------------------------------------------------------
002100140105      * Function to retrieve dependent name and optionally have the name
002200140105      * formatted.  The 3rd parm to this function is optional...if not
002300140105      * passed at all then the caller will have to substring out the pieces
002400140811      * (bytes 1-18 last name, bytes 19-30 first name, byte 31 MI).
002500140811      * If the 3rd parm is:
002600140811      *  'LFM' - return "Last, First Initial"
002700140811      *  'LFI' - return "First MI Last"
002800140811      *  'FML' - return "First MI Last"
002900140104      *---------------------------------------------------------------------
003000140104     P #get_dep_name   b                   export
003100140104
003200140104      /define get_dep_name_pi
003300140104      /define get_dep_name_fields
003400140104      /copy qcpysrc,depsrvpgmp
003500140104      /undefine get_dep_name_fields
003600140104      /undefine get_dep_name_pi
003700140104
003800140104       #dep_openfiles('DEPNDC') ;
003900140104
004000140104       chain (p_mbrssn:p_depseq) depndc ;
004100140104       if not %found(depndc) ;
004200140104        return *blanks ;
004300140105       elseif %parms() = 2 or (p_fmtname <> 'L' and p_fmtname <> 'F') ;
004400140104        return dlname + dfname + dmi ;
004500140105       elseif p_fmtname = 'L' ;
004600140104        return %trim(dlname) + ', ' + %trim(dfname) + ' ' + %trim(dmi) ;
004700140105       else ;
004800140105        return %trim(dfname) + ' ' + %trim(dlname) + ' ' + %trim(dmi) ;
004900140104       endif ;
005000140104
005100140104     P #get_dep_name   e
005200140104
005300140105      *---------------------------------------------------------------------
005400140105      * Function to retrieve dependent ssn and optionally the format of the
005500140105      * ssn:  if the 3rd parm (format) is not passed at all then the SSN
005600140105      * will be returned as a 9A unformatted value (999999999).  If the
005700140105      * format parm is 'F' then the SSN wil be retured as 999-99-999.  If
005800140105      * the format parm is 'M' then the SSN will be returnes as xxx-xx-xxxx.
005900140105      *---------------------------------------------------------------------
006000140105     P #get_dep_ssn    b                   export
006100140105
006200140105      /define get_dep_ssn_pi
006300140105      /define get_dep_ssn_fields
006400140105      /copy qcpysrc,depsrvpgmp
006500140105      /undefine get_dep_ssn_fields
006600140105      /undefine get_dep_ssn_pi
006700140105
006800140105       #dep_openfiles('DEPNDC') ;
006900140105
007000140105       chain (p_mbrssn:p_depseq) depndc ;
007100140105       if not %found(depndc) ;
007200140105        return *blanks ;
007300140105       elseif (%parms() < 3) or (p_ssn_fmt <> 'M' and p_ssn_fmt <> 'F') ;
007400140105        return %editc(depss#:'X') ;
007500140105       elseif p_ssn_fmt = 'F' ;
007600140105        return %subst(%editc(depss#:'X'):1:3) + '-' +
007700140105               %subst(%editc(depss#:'X'):4:2) + '-' +
007800140105               %subst(%editc(depss#:'X'):6:4) ;
007900140105        return %editw(depss#:'0   -  -    ') ;
008000140105       else ;
008100140105        return 'XXX-XX-' + %subst(%editc(depss#:'X'):6:4) ;
008200140105       endif ;
008300140105
008400140105     P #get_dep_ssn    e
008500140105
008600140124      *---------------------------------------------------------------------
008700140124      * Function to retrieve dependent 2-char relationship code
008800140124      *---------------------------------------------------------------------
008900140124     P #get_dep_relcode...
009000140124     P                 b                   export
009100140124
009200140124      /define get_dep_relcode_pi
009300140124      /define get_dep_relcode_fields
009400140124      /copy qcpysrc,depsrvpgmp
009500140124      /undefine get_dep_relcode_pi
009600140124      /undefine get_dep_relcode_fields
009700140124
009800140124       #dep_openfiles('DEPNDC') ;
009900140124
010000140124       chain (p_mbrssn:p_depseq) depndc ;
010100140124       if not %found(depndc) ;
010200140124        return *blanks ;
010300140124       else ;
010400140124        return %subst(drelcd:2) ;
010500140124       endif ;
010600140124
010700140124     P #get_dep_relcode...
010800140124     P                 e
010900140124
011000130909      *---------------------------------------------------------------------
011100130909      *
011200130909      *---------------------------------------------------------------------
011300140102     P #dep_openfiles  b
011400130909
011500140102     d #dep_openfiles  pi
011600130909     D  file                         10    value
011700130909
011800140104       if file = 'DEPNDC' ;
011900140104        if not %open(depndc) ;
012000140104         open depndc ;
012100130909        endif ;
012200130909       endif ;
012300130909
012400140102     P #dep_openfiles  e
012500130909      *---------------------------------------------------------------------
012600130909      *
012700130909      *---------------------------------------------------------------------
012800140102     P #dep_closesrv   b                   export
012900130909
013000140102      /define dep_closesrv_pi
013100140102      /copy qcpysrc,depsrvpgmp
013200140102      /undefine dep_closesrv_pi
013300130909
013400130909       close *all ;
013500130909
013600140102     P #dep_closesrv   e
