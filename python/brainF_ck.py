trueorfalse = True, True, True == (True, True, True)
print(trueorfalse)

# results in (True, True, False)

# So the expression evaluates to a 3-tuple with the arguments:
# True
# True
# True == (True, True, True)
# Or (True, True, False), as the third item evaluates to False since True does not equal a 3-tuple of True.
