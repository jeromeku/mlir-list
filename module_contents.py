import importlib
import pkgutil

m = importlib.import_module("mlir_listproject._mlir_libs._listprojectDialectsNanobind")
print("module file:", m.__file__)

if hasattr(m, "__path__"):
    print("Has path")
    print([name for _, name, _ in pkgutil.iter_modules(m.__path__)])
else:
    print(dir(m)[:50])
    