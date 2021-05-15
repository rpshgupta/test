# test

from nse.nse import nsedata

"""
type = ["history","incremental"]

duration is applicable for historical data only

duration = ["1Yr","3Yr","5Yr"]
"""
# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    nsedata(type="incremental",duration="3Yr")
