# test

from nse.nse import nsedata

"""
type = ["history","incremental"]

duration is applicable for historical data only

duration = ["1Yr","3Yr","5Yr"]
"""

if __name__ == '__main__':
    nsedata(type="incremental",duration="3Yr")
