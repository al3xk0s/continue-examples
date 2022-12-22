def get_reverse_enum_map(values: tuple):
    result = dict()
    for enum_obj in values:
        result[enum_obj.value] = enum_obj
    return result
