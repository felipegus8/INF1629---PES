#Let's do the usual imports
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import statsmodels.api as sm
import itertools
import sys
from scipy.stats import boxcox
import simplejson as json
np.set_printoptions(threshold=sys.maxsize)

def get_predictions(coin):
    df= pd.read_csv('crypto-markets.csv', parse_dates=['date'], index_col='date')
    df=df[df['symbol']==coin]
    remove_columns(df)
    box_cox_transform(df)
    y = resample_df(df)
    pred_df = ARIMA_time_series_predicition(y,df)
    predicted_to_csv(pred_df,coin)
    return predicted_to_json(pred_df, coin)


def remove_columns(df):
    df.drop(['volume','symbol','name','ranknow','market','close_ratio','spread','slug'],axis=1,inplace=True)#Just dropping columns here!


def box_cox_transform(df):
    df['close'] = boxcox(df['close'], lmbda=0.0)

def plot_current_df(df):
    sns.set()
    sns.set_style('whitegrid')
    df['close'].plot(figsize=(12,6),label='Close')
    df['close'].rolling(window=30).mean().plot(label='30 Day Avg')# Plotting the
    #rolling 30 day average against the Close Price
    plt.legend()

def resample_df(df):
    return df['close'].resample('MS').mean()

def ARIMA_time_series_predicition(y,df):
    p = d = q = range(0, 2)
    pdq = list(itertools.product(p, d, q))
    seasonal_pdq = [(x[0], x[1], x[2], 12) for x in list(itertools.product(p, d, q))]

    #ARIMA parameter tuning
    # for param in pdq:
    #     for param_seasonal in seasonal_pdq:
    #         try:
    #             mod = sm.tsa.statespace.SARIMAX(y,order=param,seasonal_order=param_seasonal,enforce_stationarity=False,enforce_invertibility=False)
    #             results = mod.fit()
    #             print('ARIMA{}x{}12 - AIC:{}'.format(param, param_seasonal, results.aic))
    #         except:
    #             continue

    mod = sm.tsa.statespace.SARIMAX(y,order=(0, 1, 1),seasonal_order=(1, 1, 1, 12),enforce_stationarity=False,enforce_invertibility=False)
    results = mod.fit()
    # print(results.summary().tables[1])
    pred_uc = results.get_forecast(steps=100)
    pred_ci = pred_uc.conf_int()
    pred_ci['predicted_value'] = (pred_ci['lower close'] + pred_ci['upper close']) / 2  # assigned to a column
    return pred_ci

def predicted_to_csv(df,coin):
    df.to_csv('Predictions_'+ coin +'.csv')

def predicted_to_json(df, coin):
    d = df.to_dict(orient='records')
    return d

def plot_forecast(y,pred_uc,pred_ci):
    ax = y.plot(label='observed', figsize=(14, 7))
    pred_uc.predicted_mean.plot(ax=ax, label='Forecast')
    ax.fill_between(pred_ci.index,pred_ci.iloc[:, 0],pred_ci.iloc[:, 1], color='k', alpha=.25)
    ax.set_xlabel('Date')
    ax.set_ylabel('Price')
    plt.legend()
    plt.show()

get_predictions('BTC')
get_predictions('XRP')
get_predictions('LTC')
