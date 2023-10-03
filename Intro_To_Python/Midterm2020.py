#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jan 16 18:47:56 2021

@author: rishigummakonda
"""
import random

def generateShot():
    columns = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    rows = [1,2,3,4,5,6,7,8,9,10]
    col = columns[random.randrange(len(columns))]
    row = rows[random.randrange(len(rows))]
    return f'Shot: {col}{row}'

print(generateShot())

while True:
        try:
            user_input =input('Enter N to generate another shot, or H to sink the battleship: ')
            if user_input == "N" or user_input == "H":
                 if user_input == "N":
                     print(generateShot())
                 else:
                     print("You sank their battleship!")
                     break;
            else:
                print("Error, please input H or N")
        except ValueError:
            print("Error, please input H or N")
            continue;
