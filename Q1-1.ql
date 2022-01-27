import cpp

from Macro m
where m.getName().regexpMatch("ntoh(l|ll|s)")
select m.getAnInvocation()

// Question 1.1: Find all the calls to ntohl, ntohll, and ntohs.
// Here we can take the solution from Q 0.2 and modify it

// There’s also the MacroInvocation class that we can use too:
//import cpp

//from MacroInvocation m
//where m.getMacro().getName().regexpMatch("ntoh(l|ll|s)")
//select m
