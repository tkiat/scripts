def prepend_zero_to_int(num, digit):
    return str(10 ** digit + num)[-digit:]
