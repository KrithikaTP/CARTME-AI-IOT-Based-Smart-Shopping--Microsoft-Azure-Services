
import RPi.GPIO as GPIO  # import GPIO
from hx711 import HX711  # import the class HX711
import random

def calculateWeight():
  GPIO.setmode(GPIO.BCM)  # set GPIO pin mode to BCM numbering
  hx = HX711(dout_pin=21, pd_sck_pin=20)  # create an object
  # print(hx.get_raw_data_mean())
  GPIO.cleanup()
  #return the weight in KG
  return (hx.get_raw_data_mean()/1000)
