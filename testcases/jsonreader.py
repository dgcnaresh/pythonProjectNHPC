import json
import os

CWD=os.getcwd()
JSON_CONFIG_FILE_PATH = '%s/%s' % (CWD, 'data.json')
CONFIG_PROPERTIES = {}

try:
    with open (JSON_CONFIG_FILE_PATH) as data_file:
        CONFIG_PROPERTIES= json.load(data_file)
except IOError as e:
    exit(1)


print(f"Total tax applicable at \
                    ₹{CONFIG_PROPERTIES} ")
print(f"Total tax applicable at \
                    ₹{CONFIG_PROPERTIES['birthday']} ")
