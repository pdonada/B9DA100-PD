import datetime
import pandas as pd


dateStr = '2009-01-01'

cazzo = str(datetime.date(dateStr, '%Y-%m-%d').day)

print(cazzo)
    
