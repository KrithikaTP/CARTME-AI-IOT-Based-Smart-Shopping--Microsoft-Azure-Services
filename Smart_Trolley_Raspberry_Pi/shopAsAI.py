import cosmos
import speechToText
import qrCode
import barCode
import weight
from multiprocessing import Process
import sys
from picamera import PiCamera

camera = PiCamera()
camera.start_preview()
rocket = 0
customerId = ''
initialWeight = 0.0
def func1():
    #ininializing the smart voice assistant
    speechToText.initializerSpeech()
def func2():
    #add each time a product is scanned
    while True:
        currentWeight = weight.calculateWeight()
        if(initialWeight == currentWeight):
            scanedId = barCode.barScan()
            if(scanedId !=None):
                initialWeight = weight.calculateWeight()
                #when scanned , the new weight needs to be updated. As only scanned items add to cart
                #and customer cannot forge
                cosmos.azureCosmos(customerId,scanedId)
        else:
            #ensures only scanned items add to cart. Unscanned items added would lead to forgery.
            print("Unscanned items added to cart. Please scan and add them.")
            break


if __name__=='__main__':
    #Scanning the QR code of the customer
    customerId = qrCode.scan()

    #initializing the initial weight
    initialWeight = weight.calculateWeight()
    #enabling the scanning and smart assistant to work simultaneously
    p1 = Process(target = func1)
    p1.start()
    p2 = Process(target = func2)
    p2.start()
