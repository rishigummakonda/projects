#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 29 17:37:37 2021

@author: rishigummakonda
"""

import pandas as pd

# I thought it would be easier just to import them directly from the website instead of downloading them
june19 = pd.read_csv("https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2019-06.csv")
june20 = pd.read_csv("https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2020-06.csv")

#print(june19.head())
#print(june20.head())

#print("Columns:")
#for col in june19.columns: 
#    print(col)

# trip_distance <= 100
#print(june19['trip_distance'].describe())
june19 = june19[june19.trip_distance <= 100]
#print(june19['trip_distance'].describe())

june20 = june20[june20.trip_distance <= 100]

# delete any rows where passengers = 0 
june19 = june19[june19.passenger_count != 0]
june20 = june20[june20.passenger_count != 0]

#  delete trip distance = 0
june19 = june19[june19.trip_distance != 0]
june20 = june20[june20.trip_distance != 0]

# for total_amount, keep only rows where it is greater than zero but less than 1,000
june19 = june19[(june19.total_amount <1000) & (june19.total_amount >0)]
june20 = june20[(june20.total_amount <1000) & (june20.total_amount >0)]

# keep only rows where "extra" >= 0
june19 = june19[june19.extra >= 0]
june20 = june20[june20.extra >= 0]


#creating duration column for each dataframe
june19['pickup'] = pd.to_datetime(june19['tpep_pickup_datetime'],
                              infer_datetime_format=True)
june19['dropoff'] = pd.to_datetime(june19['tpep_dropoff_datetime'],
                              infer_datetime_format=True)
june19['duration'] = june19['dropoff'] - june19['pickup']
#print(june19[['pickup','dropoff','duration']].head())


june20['pickup'] = pd.to_datetime(june20['tpep_pickup_datetime'],
                              infer_datetime_format=True)
june20['dropoff'] = pd.to_datetime(june20['tpep_dropoff_datetime'],
                              infer_datetime_format=True)
june20['duration'] = june20['dropoff'] - june20['pickup']
#print(june20[['pickup','dropoff','duration']].head())

#then runs descriptive statistics on the trip distance, duration, and total_amount
main19 = june19[["trip_distance", "duration", "total_amount"]]
#print(main19.describe())

main20 = june20[["trip_distance", "duration", "total_amount"]]
#print(main20.describe())

#saving the means. 
distance19mean = main19.trip_distance.mean()
distance20mean = main20.trip_distance.mean()

duration19mean = main19.duration.mean()
duration20mean = main20.duration.mean()

total_amount19mean = main19.total_amount.mean()
total_amount20mean = main20.total_amount.mean()

#Also save the number of records.
count19 = main19.trip_distance.count()
count20 = main20.trip_distance.count()

# Print a comparison of the means for the four variables between 2019-06 and 2020-20 to the console.
print("\nMean Distance June 2019: ", "{:.2f}".format(distance19mean))
print("Mean Distance June 2020: ", "{:.2f}".format(distance20mean))

print("\nMean Duration June 2019: ", duration19mean)
print("Mean Duration June 2020: ", duration20mean)

print("\nMean Total_Amount June 2019: ", "{:.2f}".format(total_amount19mean))
print("Mean Total_Amount June 2020: ", "{:.2f}".format(total_amount20mean))

print("\n\nCount June 2019: ", "{:.2f}".format(count19))
print("Count June 2020: ", "{:.2f}".format(count20))
