#!/usr/bin/env python3

# for use with my own spendings format
from decimal import Decimal
import json
import os
import sys

def read_json_file(path):
	if not os.path.exists(path):
		f = open(path, 'w+')
		f.close()
	with open(path, 'r') as f:
		my_json = f.read()
	try:
		my_json = json.loads(my_json)
	except ValueError:
		if not my_json:
			my_json = {}
		else:
			print("Log file must be either in JSON format or absolutely empty")
			sys.exit()
	return my_json

total = {}
record = read_json_file("spending.json")
num_month = len(record['overall']) - 2
# record["overall"]["total"] = Decimal(str(record["overall"]["total"]))
for key in record["overall"]:
	record["overall"][key] = Decimal("0")
for category in record:
	if category == "overall":
		continue
	record[category]["total"] = Decimal("0")
	for month in record[category]:
		if not month.isdigit():
			continue
		record[category]["total"] += Decimal(str(record[category][month]))
		record["overall"][month] += Decimal(float(record[category][month]))
	record[category]["avg"] = round(float(record[category]["total"])/num_month, 2)
	record[category]["total"] = float(record[category]["total"])
for key in record["overall"]:
	if key.isdigit():
		record["overall"]["total"] += record["overall"][key]
record["overall"]["avg"] = record["overall"]["total"]/num_month
for key in record["overall"]:
	record["overall"][key] = round(float(record["overall"][key]), 2)
print(json.dumps(record, indent=2))
