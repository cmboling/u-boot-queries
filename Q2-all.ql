/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

// question 2.1: write the class
class NtohsMacroInvocation extends Expr {
  NtohsMacroInvocation() {
    exists(MacroInvocation m | m.getMacro().getName().regexpMatch("ntoh(l|ll|s)") |
      this = m.getExpr()
    )
  }
}

// question 2.2: create the config for source + sink
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NtohsMacroInvocation
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall fc |
      sink.asExpr() = fc.getArgument(2) and
      fc.getTarget().getName() = "memcpy"
    )
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "ntoh flows to memcpy"
