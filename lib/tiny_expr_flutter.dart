import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart' as ffi;

import 'tiny_expr_flutter_bindings_generated.dart';

const String _libName = 'tiny_expr_flutter';

/// The dynamic library in which the symbols for [TinyExprFlutterBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final TinyExprFlutterBindings _bindings = TinyExprFlutterBindings(_dylib);

/// The `TinyExpr` class allows us to handle evaluation of mathematical
/// expressions using the TinyExpr C library.
class TinyExpr {
  /// This is the constructor of the `TinyExpr` class.
  TinyExpr();

  /// This helper object `_allocator` provides a way to allocate and deallocate
  /// memory in the native C heap. It uses the `malloc` function from the `ffi`
  /// package to allocate memory.
  final _allocator = ffi.malloc;

  /// This method `evaluateExpression` takes a mathematical expression as a string,
  /// evaluates it using the TinyExpr library, and returns the result as a double.
  double evaluateExpression(String expression) {
    /// The `expression` string is converted to a null-terminated C-style string
    /// using `toNativeUtf8()` and then cast to a `Pointer<Char>` to make it
    /// compatible with the C function.
    Pointer<Char> expressionPointer = expression.toNativeUtf8().cast<Char>();

    /// The `_bindings.evaluate_expression(expressionPointer)` function call passes
    /// the C-style string to the TinyExpr library and receives the result of the
    /// evaluation as a double.
    double result = _bindings.evaluate_expression(expressionPointer);

    /// Finally, the `expressionPointer` is freed using `_allocator.free(expressionPointer)`,
    /// releasing the memory it was using on the C heap to prevent memory leaks.
    _allocator.free(expressionPointer);

    return result;
  }
}
