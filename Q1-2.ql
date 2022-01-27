import cpp

from MacroInvocation m
where m.getMacro().getName().regexpMatch("ntoh(l|ll|s)")
select m.getExpr()

// Question 1.2: Find the expressions that resulted in these macro invocations.
