#!/usr/local/bin/python2.7
# encoding: utf-8

import logging
import argparse
import datetime
import time
import random
import subprocess
import os
import threading
import math
import csv
from collections import deque

command = ['git','add','-A']
subprocess.call(command)

command2 = ['git','commit','-m','"logs 07/03"']
subprocess.call(command2)

command3 = ['git','push','-u', 'origin','master']
subprocess.call(command3)


