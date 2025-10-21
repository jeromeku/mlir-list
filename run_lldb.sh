# Project-local init:
lldb-22 --local-lldbinit -s ./.lldbinit -- ./build/bin/listproject-opt \
  --mlir-disable-threading \
  test/List/ops.mlir -o /dev/null
 #b 'mlir::list::MapOp::verify
# breakpoint set -n sblp::StrengthReductionPass::runOnOperation
# breakpoint set -n sblp::SimplifyPowerOp::matchAndRewrite
# run

# frame variable                 # pretty locals (uses the formatters)
# expr -l C++ -- op->dump()      # evaluate C++ expressions with clang
# thread backtrace all           # all thread stacks
# settings set target.run-args --mlir-disable-threading --pass-pipeline='builtin.module(strength-reduction)' input.mlir -o /dev/null
# process launch                 # (re)launch with the new args

# # Home init (~/.lldbinit) loads automatically:
# lldb -- ./bin/sblp-opt --mlir-disable-threading --pass-pipeline='builtin.module(strength-reduction)' input.mlir -o /dev/null
