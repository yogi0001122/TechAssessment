# Challenge-3

 This code is to get the key value from nested object 
 
 The following are needed to run this code: 

### Prerequisite: 

- [Python](https://www.python.org/downloads/) (version 3+)
- [pip](https://pip.pypa.io/en/stable/installing/)

- Install Python's Libraries and Run below mentioned command
  
      pip install -r requirements.txt
      
## Test Script

- Approach 1: Using for loop and covert key to tuple

    python  challenge-3-approach-1.py
    
    Input:
    
      obj = {"a":{"b":{"c":"d"}}}
      key = "a/b/c"  
    
    Output:
    
      Key:  a/b/c  ---> Vaue:  d
    
- Approach 2: Using pandas's json_normalize method and Replacing special characters in pandas dataframe and key


    python  challenge-3-approach-2.py
    
    Input:
    
      obj = {"x":{"y":{"z":"a"}}}
      key = "x/y/z"
    
    Output:
    
      Key:  x/y/z  ---> Vaue:  a
