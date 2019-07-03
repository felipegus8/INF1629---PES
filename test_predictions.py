import unittest
from crypto_predictions import *

class Test_Predictions(unittest.TestCase):

    def setUp(self):
        self.df= pd.read_csv('crypto-markets.csv', parse_dates=['date'], index_col='date')
        self.coin = 'BTC'


    def test_remove_columns(self):
        remove_columns(self.df)
        self.assertEqual(len(self.df.columns),4)
        self.assertTrue('close' in self.df)
        self.assertTrue('low' in self.df)
        self.assertTrue('open' in self.df)
        self.assertTrue('high' in self.df)


    def test_ARIMA_time_series_predicition(self):
        y = resample_df(self.df)
        pred_df = ARIMA_time_series_predicition(y,self.df)
        self.assertEqual(len(pred_df.columns),3)
        self.assertTrue('predicted_value' in pred_df)
        self.assertTrue('lower close' in pred_df)
        self.assertTrue('upper close' in pred_df)


    def test_get_predictions(self):
        response_json = get_predictions(self.coin)
        self.assertTrue('predicted_value' in response_json[0])
        self.assertTrue('lower close' in response_json[0])
        self.assertTrue('upper close' in response_json[0])

    def test_resample_df(self):    
        y = resample_df(self.df)
        self.assertTrue('close' in y)

    def test_predicted_to_json(self):
        response_json = predicted_to_json(self.df, self.coin)
        self.assertTrue('predicted_value' in response_json[0])
        self.assertTrue('lower close' in response_json[0])
        self.assertTrue('upper close' in response_json[0])

    def test_plot_current_df(self):
        plot_df = self.df
        self.assertTrue('lower close' in plot_df)
        self.assertTrue('upper close' in plot_df)


    
if __name__ == '__main__':
    unittest.main()
