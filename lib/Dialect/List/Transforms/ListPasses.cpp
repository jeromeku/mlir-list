//===- ListPasses.cpp - List passes -------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Rewrite/FrozenRewritePatternSet.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#include "ListProject/Dialect/List/Transforms/ListPasses.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/Debug.h"

#define DEBUG_TYPE "list-pass"

using llvm::dbgs;

namespace mlir::list {
#define GEN_PASS_DEF_LISTREMOVESOMEFOO
#include "ListProject/Dialect/List/Transforms/ListPasses.h.inc"

namespace {
class ListRemoveSomeFoo
    : public impl::ListRemoveSomeFooBase<ListRemoveSomeFoo> {
public:
  using impl::ListRemoveSomeFooBase<
      ListRemoveSomeFoo>::ListRemoveSomeFooBase;
  void runOnOperation() final {
    // Your pass code here
    // ======================================================
    ModuleOp moduleOp = getOperation();
    LLVM_DEBUG(dbgs() << __FILE_NAME__ << ":" << __LINE__ << " " << moduleOp->getName() << "\n");
    llvm::SmallVector<Operation*> dead_ops;

    moduleOp->walk([&](list::FooOp op) {
      if(op->hasAttrOfType<UnitAttr>("useless")){
        op->getResult(0).replaceAllUsesWith(op.getInput());
        dead_ops.push_back(op);
      }
    });
    for(Operation *op : dead_ops){
      op->erase();
    }

  }
};
} // namespace
} // namespace mlir::list
      // 2. TODO check if the op as a "useless" attribute
      // for(auto indexedVal : llvm::enumerate(fooOp->getAttrs())){
      //   int i = indexedVal.index();
      //   auto val = indexedVal.value();
      //   LLVM_DEBUG(dbgs() << "attr " << i << ": " << val.getName() << " " << val.getValue() << "\n");
      //   if(val.getName() == "useless"){
      //     auto result = fooOp->getResult(0);
      //     LLVM_DEBUG(dbgs() << "Replacing result with input\n");
      //     result.replaceAllUsesWith(fooOp.getInput());
      //     LLVM_DEBUG(dbgs() << "Erasing op: " << fooOp->getName() << "\n");
      //     fooOp.erase();
      //   }
      // }
