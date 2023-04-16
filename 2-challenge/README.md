# Challenge-2

 This code is to query the metadata of an instance within Azure
 
 The following are needed to run this code: 

### Prerequisite: 

- [Python](https://www.python.org/downloads/) (version 3+)
- [pip](https://pip.pypa.io/en/stable/installing/)

- Install Python's Libraries and Run below mentioned command 
  
      pip install -r requirements.txt
 
## CFG File -- instance_imds.cfg

    [imds_api_settings]    #------> section header followed by key/value
    imds_base_url = http://169.254.169.254
    imds_api_version = 2021-02-01
    instance_uri = /metadata/instance?api-version=
    instance_compute_uri = /metadata/instance/compute?api-version=

    [serach_keys]         #------> section header followed by key/value
    keys = ["subscriptionId","storageAccountType","sku"]

## Test Script

    python challenge-2.py --config instance_imds.cfg
