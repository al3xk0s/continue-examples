# Представим, что у нас есть некоторый объект, над которым проводятся действия.

# В данном примере, в качестве объекта выступает число.

# Реализуем операции над числами основные арифметические операции, а также вывод на экран.

def add(a, b):
    return a + b


def reduce(a, b):
    return a - b


def multiply(a, b):
    return a * b


def divide(a, b):
    return a / b


def out(num):
    print(num)
    return num


def get_continue(initial_number):
    def get_executable(foo, number=None):
        nonlocal initial_number

        if number is not None:          
            initial_number = foo(initial_number, number)
        else:
            initial_number = foo(initial_number)

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