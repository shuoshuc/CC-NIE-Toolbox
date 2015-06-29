#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""@package recvLogParser_test
Copyright (C) 2015 University of Virginia. All rights reserved.

file      recvLogParser_test.py
author    Shawn Chen <sc7cq@virginia.edu>
version   1.0
date      June 29, 2015

LICENSE

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or（at your option）
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
more details at http://www.gnu.org/copyleft/gpl.html

brief     Unit test for recvLogParser
"""


import time
import datetime
import unittest


def checkTimeElapse(start, end):
    """Checks if the elapsed time is longer than 1 minute.

    Takes the start time and end time, checks if the elapsed time is longer
    than one minute. If so, returns True. Otherwise, returns False.

    Args:
        start: Start of the time, should be a time struct
        end  : End of the time, should be a time struct

    Returns:
        True : Elapsed time is longer than 1 minute.
        False: Elapsed time is shorter than 1 minute.
    """
    s = datetime.datetime.fromtimestamp(time.mktime(start))
    e = datetime.datetime.fromtimestamp(time.mktime(end))
    over_one_min = (e - s) > datetime.timedelta(minutes = 1)
    return over_one_min


class MyTest(unittest.TestCase):
    def test(self):
        start  = time.strptime("2015-06-26 09:23:05", "%Y-%m-%d %H:%M:%S")
        end    = time.strptime("2015-06-26 09:24:28", "%Y-%m-%d %H:%M:%S")
        self.assertEqual(checkTimeElapse(start, end), True)
        start  = time.strptime("2015-06-26 09:24:05", "%Y-%m-%d %H:%M:%S")
        end    = time.strptime("2015-06-26 09:24:28", "%Y-%m-%d %H:%M:%S")
        self.assertEqual(checkTimeElapse(start, end), False)


if __name__ == "__main__":
    unittest.main()
