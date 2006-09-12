****************************************
********** FastCode Libraries **********
****************************************

.. What is does ..
 
  The following library will replace the current RTL
  code used by your application(s) with faster and 
  optimized for the latest processors.

  Currently the following functions are supported:

  CompareText, LowerCase, UpperCase, Pos, StrComp and StrCopy.
  (and more to come ...)

.. Usage ..
  
  To use it must include the "Fastcode" unit in the first order
  of your uses clauses of your delphi project. If you're using
  and alternative memory manager and/or FastMove the order should
  be like:

  FastMM4,
  FastCode,
  FastMove,
  ... etc ... 

  You may also take a look at "FastCode.inc" for custom modifications.

Charalabos Michael <chmichael@creationpower.com>
