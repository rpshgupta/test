
import datetime
from dateutil import relativedelta
import pandas as pd
import os
import glob

def SMA(filename = "SMA.csv",readloc="C:\\Users\\171575\\PycharmProjects\\pythonProject\\hist_data\\*.csv"):
    """
    This function is to generate simple moving average. It read the data from readloc and
    create filename with 5, 20, 50,200 simple moving average columns along with close diff column
    to give insight.

    :param filename: SMA.csv
    :param readloc: C:\\Users\\171575\\PycharmProjects\\pythonProject\\hist_data\\*.csv
    :return: None
    """

    print(datetime.datetime.now())
    end_dt = datetime.date.today()
    # start_dt = end_dt - relativedelta.relativedelta(days=365)

    filename = filename
    if os.path.exists(filename):
        os.remove(filename)
    else:
        print("target file is not present")

    files = glob.glob(readloc)
    df = pd.DataFrame()
    for f in files:
        print(f)
        data = pd.read_csv(f)
        data = data[['Date','Symbol', 'High', 'Low', 'Close','Prev Close', 'Volume', 'Trades']]
        data["sma-5"] = data["Close"].rolling(5).mean()
        data["sma-20"] = data["Close"].rolling(20).mean()
        data["sma-50"] = data["Close"].rolling(50).mean()
        data["sma-200"] = data["Close"].rolling(200).mean()
        data["sma5-cross"] = data["Close"] - data["sma-5"]
        data["sma20-cross"] = data["Close"] - data["sma-20"]
        data["sma50-cross"] = data["Close"] - data["sma-50"]
        data["sma200-cross"] = data["Close"] - data["sma-200"]

        data = data[['Date','Symbol', 'Close','sma-5','sma5-cross', 'sma-20','sma20-cross'
            , 'sma-50','sma50-cross' ,'sma-200','sma200-cross']]
        df = df.append(data)

    df.to_csv(filename,index=False)
    print(datetime.datetime.now())
