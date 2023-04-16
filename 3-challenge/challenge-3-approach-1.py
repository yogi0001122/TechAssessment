def get_nested_value(d, keys):
    for k in keys:
        d = d[k]
    return d

obj = {"a":{"b":{"c":"d"}}}
key = "a/b/c"
path = tuple(map(str, key.split('/')))
val = get_nested_value(obj, path)
print("Key: ", key, " ---> Vaue: ", val)
