import json
import requests
import logging
import configparser
import argparse
import time
import ast

# Logging
log_month = time.strftime("%Y%m")
logDir = './'
logfile = logDir + 'imdsLog' + log_month  # Log File Name: agent_monitoring_log.201911
logging.basicConfig(filename=logfile, format="%(asctime)-15s [%(levelname)s]: %(message)s", level=logging.DEBUG)

# Proxies must be bypassed when calling Azure IMDS
proxies = {
    "http": None,
    "https": None
}


def config_reader(cfg_file):
    # Reading cfg file
    try:
        logging.info("Reading cfg file")
        cfg_parser = configparser.ConfigParser()
        cfg_parser.read(cfg_file)
    except configparser.Error as err:
        logging.error("There is issue with CFG File", err)
        raise ValueError('CFG File is not a valid', err)
    return cfg_parser


def get_instance_metadata(endpoint):
    try:
        headers = {'Metadata': 'True'}
        metadata_json = requests.get(endpoint, headers=headers, proxies=proxies).json()
    except requests.exceptions.RequestException as e:
        logging.error("Exception occured at the time of imds endpoint get call:", e)
    return metadata_json


def pretty_print_json_obj_to_terminal(json_object):
    print(json.dumps(json_object, sort_keys=True, indent=2, separators=(',', ': ')))


def get_data_key(obj, searchkey):
    obj_array = []

    def traces_json_tree(obj, obj_array, searchkey):
        if isinstance(obj, dict):
            for key, value in obj.items():
                if isinstance(value, (dict, list)):
                    traces_json_tree(value, obj_array, searchkey)
                elif key == searchkey:
                    obj_array.append(value)
        elif isinstance(obj, list):
            for item in obj:
                traces_json_tree(item, obj_array, searchkey)
        return obj_array

    values = traces_json_tree(obj, obj_array, searchkey)
    return values


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Get Meta Data")
    parser.add_argument('-c', '--config', required=True, help='config file path')
    options = parser.parse_args()
    if options.config:
        parser = config_reader(options.config)

    # Call Instance IMDS API and get instance Meta Data
    if parser.has_option('imds_api_settings', 'imds_base_url'):
        base_url = parser.get('imds_api_settings', 'imds_base_url')
    else:
        logging.error("No imds_base_url found in cfg file")
        exit(1)
    if parser.has_option('imds_api_settings', 'imds_api_version'):
        api_version = parser.get('imds_api_settings', 'imds_api_version')
    else:
        logging.error("No imds_base_url found in cfg file")
        exit(1)
    if parser.has_option('imds_api_settings', 'instance_uri'):
        instance_uri = parser.get('imds_api_settings', 'instance_uri')
    else:
        logging.error("No instance_compute_uri found in cfg file")
        exit(1)
    logging.info("Calling instance endpoint to get metadata")
    instance_endpoint = base_url + instance_uri + api_version
    instance_meta_data_json = get_instance_metadata(instance_endpoint)
    #pretty_print_json_obj_to_terminal(instance_meta_data_json)

    # Call Instance IMDS API and get compute Meta Data
    if parser.has_option('imds_api_settings', 'instance_compute_uri'):
        instance_compute_uri = parser.get('imds_api_settings', 'instance_compute_uri')
    else:
        logging.error("No instance_compute_uri found in cfg file")
        exit(1)
    logging.info("Calling instance compute endpoint to get metadata")
    instance_compute_endpoint = base_url + instance_compute_uri + api_version
    compute_meta_data_json = get_instance_metadata(instance_compute_endpoint)
    #pretty_print_json_obj_to_terminal(compute_meta_data_json)

    # The code allows for a particular data keys to be retrieved individually
    if parser.has_option('serach_keys','keys'):
        keys = ast.literal_eval(parser.get('serach_keys', 'keys'))
    else:
        logging.error("No serach_keys found in cfg file")
        exit(1)

    logging.info("Calling function to data key to be retrieved individually")
    for key in keys:
        value = get_data_key(compute_meta_data_json, key)
        print(key, "----->", value)
