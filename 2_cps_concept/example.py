from functools import partial

add = lambda a, b: a + b
reduce = lambda a, b: a - b
divide = lambda a, b: a / b
multiply = lambda a, b: a * b

def out(a):
    print(a)
    return a
    
def get_continue(initial_number):
    def get_executable(foo, number=None):
        nonlocal initial_number
        foo = partial(foo, initial_number)
        if number is not None:          
            initial_number = foo(number)
        else:
            initial_number = foo()

        return get_continue(initial_number)
    return get_executable



def main():
    get_continue \
    (30) \
    (add, 5) \
    (divide, 2) \
    (out) \
    (multiply, 3) \
    (out)
    


main()

# Вывод:
#
# 17.5
# 52.5