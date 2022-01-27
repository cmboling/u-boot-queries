import cpp

from FunctionCall fc
where fc.getTarget().getName() = "memcpy"
select fc

// Question 1.0: Find all the calls to memcpy.
// Here we can take the solution from Q 0.1 and modify it by using the FunctionCall class instead