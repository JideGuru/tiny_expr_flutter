#include "tiny_expr_flutter.h"
#include "tinyexpr/tinyexpr.c"

double evaluate_expression(const char* expression) {
    return te_interp(expression, 0);
}