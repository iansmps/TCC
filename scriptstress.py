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

command = ['./bin/cassandra-stress', 'mixed','duration=30m','-rate','threads=10','-log','file=~/TCC/load_30301035.log','-node','192.168.0.108']
subprocess.call(command)

command2 = ['./bin/cassandra-stress', 'mixed','duration=30m','-rate','threads=10','-log','file=~/TCC/load_30300535.log','-node','192.168.0.108']
subprocess.call(command2)

command3 = ['./bin/cassandra-stress', 'mixed','duration=30m','-rate','threads=10','-log','file=~/TCC/load_30300540.log','-node','192.168.0.108']
subprocess.call(command3)

command4 = ['./bin/cassandra-stress', 'mixed','duration=30m','-rate','threads=10','-log','file=load_30300530.log','-node','192.168.0.108']
subprocess.call(command4)


