import nsepy
import datetime
from dateutil import relativedelta
import pandas
import os
import nsetools

def nsedata(type="history",duration="1Yr"):
    print(datetime.datetime.now())
    nse = nsetools.Nse()
    # stock_dict = ["INFY"]
    stock_dict = nse.get_stock_codes()
    del stock_dict['SYMBOL']
    pandas.set_option('display.max_rows', None)
    end_dt = datetime.date.today()

    for key in stock_dict:
        stock = key
        print(stock)
        if type == "history":
            print(type)
            if os.path.exists("{}.csv".format(stock)):
                os.remove("{}.csv".format(stock))
            else:
                print("target file is not present")

                if duration == "1Yr":
                    start_dt = end_dt - relativedelta.relativedelta(days=365)
                    data = nsepy.get_history(symbol=key, start=start_dt, end=end_dt)
                    data.to_csv("{}.csv".format(stock), header=True)

                if duration == "3Yr":
                    start_dt = end_dt - relativedelta.relativedelta(days=1095)
                    data = nsepy.get_history(symbol=key, start=start_dt, end=end_dt)
                    data.to_csv("{}.csv".format(stock), header=True)

                if duration == "5Yr":
                    start_dt = end_dt - relativedelta.relativedelta(days=1825)
                    data = nsepy.get_history(symbol=key, start=start_dt, end=end_dt)
                    data.to_csv("{}.csv".format(stock), header=True)

        if type == "incremental":
            print(type)
            start_dt = end_dt - relativedelta.relativedelta(days=0)
            data = nsepy.get_history(symbol=key, start=start_dt, end=end_dt)
            data.to_csv("{}.csv".format(stock), mode='a', header=True)

        print(datetime.datetime.now())

