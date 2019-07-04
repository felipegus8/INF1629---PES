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
    #This function calls all others in this module to obtain a json with the predicted values for the desidered cryptocurrency.
    # Pre: coin must be a valid cryptocurrency string. This string must be present in the symbol column of the crypto-markets.csv. No prediction will be obtained if this isn't the case.
    #Post : This function returns a json with the predictions for the coin passed to it as a parameter if the call functions perform correctly.
    df= pd.read_csv('crypto-markets.csv', parse_dates=['date'], index_col='date')
    df=df[df['symbol']==coin]
    if(!df.empty):
        remove_columns(df)
        box_cox_transform(df)
        y = resample_df(df)
        pred_df = ARIMA_time_series_predicition(y,df)
        predicted_to_csv(pred_df,coin)
        return predicted_to_json(pred_df, coin)
    return None


def remove_columns(df):
    #This function removes the following columns from the dataframe passed to it as a parameter: "volume,symbol,name,ranknow,market,close_ratio,spread,slug"
    # Pre: None
    #Post : This function removes the 'volume','symbol','name','ranknow','market','close_ratio','spread','slug' columns from the dataframe passed to it.
    df.drop(['volume','symbol','name','ranknow','market','close_ratio','spread','slug'],axis=1,inplace=True)#Just dropping columns here!


def box_cox_transform(df):
    #This function performs the box cox transformation in the column close of the dataframe passed to it.
    # Pre: The dataframe passed to it must have the column "close"
    #Post : This function replaces the values in the column close of the dataframe with the box cox transformed values for that column.
    if(df['close'] != None):
        df['close'] = boxcox(df['close'], lmbda=0.0)

def plot_current_df(df):
    #This function plots the monthly values of the column close in the dataframe passed to it.
    # Pre: The dataframe passed to it must have the column "close"
    #Post : This function plots a graph with the values of the column "close" distributed by the mean of the last 30 days.
    sns.set()
    sns.set_style('whitegrid')
    df['close'].plot(figsize=(12,6),label='Close')
    df['close'].rolling(window=30).mean().plot(label='30 Day Avg')# Plotting the
    #rolling 30 day average against the Close Price
    plt.legend()

def resample_df(df):
    #This function resamples the column close of the dataframe with the mean of that column
    # Pre: The dataframe passed to it must have the column "close"
    #Post : This function returns the values of the column "close" resampled by its mean
    return df['close'].resample('MS').mean()

def ARIMA_time_series_predicition(y,df):
    #This function makes the prediction of the future values for the cryptocurrency based on an ARIMA time series model. This model takes into consideration all the previous values of that coin avalaible on the dataframe to make the prediction. The part of the code that is commented corresponds to the parameter tuning of the ARIMA model. It has been run once to find out the best values for the ARIMA parameters for the bitcoin prediction. It has been commented because the values of the dataframe don't change, so this parameter tuning doesn't have to be run every time. These found parameters are used in the SARIMAX function that actually makes the predictions. The returned values are in the form of a dataframe with the columns "lower close" and "upper close". A third column( "predicted value") is added to the dataframe by doing the mean of the values from the 2 previoues columns.
    # Pre: y must be a series of values that have already been resampled by its mean. df must be a dataframe that has already had the box cox transformation applied to its values in the "close" column.
    #Post : This function returns a dataframe with the columns "lower close", "upper close" and "predicted value".
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
    #This function creates a csv from a dataframe. The name of the csv is based on the coin name passed to it.
    # Pre: None
    #Post : This function creates a CSV file and saves it to the current directory. The csv will have the same columns as the df passed to it as a parameter.
    df.to_csv('Predictions_'+ coin +'.csv')

def predicted_to_json(df, coin):
    #This function creates a json from a dataframe.
    # Pre: None
    #Post : This function returns a JSON with the same columns as the df passed to it as a parameter.
    d = df.to_dict(orient='records')
    return d

def plot_forecast(y,pred_uc,pred_ci):
    #This function plots the forecast for the crypto currency of the class.
    # Pre: y must be a dataframe that has been resampled to fit its mean, pred_uc must be a dataframe that has the results of the Forecast
    # pred_ci must be a dataframe that has the results of the predictions as integers
    #Post : This function plots a graph with the prediction results

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
