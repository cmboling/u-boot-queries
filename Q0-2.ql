// Question 0.2: ntohl, ntohll, and ntohs can either be functions or macros (depending on the platform where the code is compiled).
// Two ways:
// Using Macro’s getName() 3 times to cover all macros/functions

import cpp

from Macro m
where m.getName() = "ntohl" or m.getName() = "ntohll" or m.getName() = "ntohs"
select m

// Using Macro’s regex matching
//import cpp

//from Macro m
//where m.getName().regexpMatch("ntoh(l|ll|s)")
//select m