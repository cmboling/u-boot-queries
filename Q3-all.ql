/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NtohsMacroInvocation extends Expr {
  NtohsMacroInvocation() {
    exists(MacroInvocation m | m.getMacro().getName().regexpMatch("ntoh(l|ll|s)") |
      this = m.getExpr()
    )
  }
}

// 3 turn it into a class
class Ext4FsCalls extends Expr {
  Ext4FsCalls() {
    exists(FunctionCall fc | fc.getTarget().getName().regexpMatch("ext4fs_[a-zA-Z]+") |
      fc.getArgument(2) = this
    )
  }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "MemcpyThings" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NtohsMacroInvocation
    or
    source.asExpr() instanceof Ext4FsCalls
  }
  // 2 write the predicate for ext4fs
  //   override predicate isSource(DataFlow::Node source) {
  //     exists(FunctionCall fc |
  //       source.asExpr() = fc.getArgument(2) and
  //       fc.getTarget().getName().regexpMatch("ext4fs_[a-zA-Z]+")
  //     )
  //   }
  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall fc |
      sink.asExpr() = fc.getArgument(2) and
      fc.getTarget().getName() = "memcpy"
    )
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "flows to memcpy"

// 1 start here: pre-req work
//import cpp
// find ext4f2 functions
// from Function m
// where m.getName().regexpMatch("ext4fs_[a-zA-Z]+")
// select m
// find the function calls
// from FunctionCall fc
// where fc.getTarget().getName().regexpMatch("ext4fs_[a-zA-Z]+")
// select fc
