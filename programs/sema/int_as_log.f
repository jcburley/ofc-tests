      program int_as_log
      integer i/2/
      print *, 'false on AIX (xlc fortran), true most everywhere else?'
      if (i) then
         print *, 'false on AIX (xlc fortran), true elsewhere?'
      end if
      end
