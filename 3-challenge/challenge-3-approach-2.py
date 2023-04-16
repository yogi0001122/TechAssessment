import pandas as pd
import re
import string


def remove_special_chars_regex(pattern):
    chars = re.escape(string.punctuation)
    new_pattern = re.sub(r'['+chars+']', '', pattern)
    return new_pattern


def get_key_value(obj, key):
    df = pd.json_normalize(obj)
    df.columns = df.columns.str.replace(r'.','', regex=True)
    return df[key].to_string(index=False)


if __name__ == "__main__":
    obj = {"x":{"y":{"z":"a"}}}
    key = "x/y/z"
    # Pass object and a key and get back the value.
    newkey = remove_special_chars_regex(key)
    val = get_key_value(obj, newkey)
    print("Key: ", key, " ---> Vaue: ", val)
