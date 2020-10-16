from picamera import PiCamera
from time import sleep
import qrtools


def scan:
    #wait until the user shows the QR code from the mobile
    while True:
        sleep(1)
        camera.capture('image.jpg')
        qr = qrtools.QR()
        qr.decode("image.jpg")
        if(qr.data != 'null'):
            return qr.data
