import builtins
import functools
import itertools
import operator

_builtin_sum = builtins.sum

def sum(iterable, start=0):
    if isinstance(start, (int, float)):
        return _builtin_sum(iterable, start)
    iterable = iter(iterable)
    return functools.reduce(operator.iadd, iterable,
            _builtin_sum(itertools.islice(iterable, 1), start))

builtins.sum = sum
