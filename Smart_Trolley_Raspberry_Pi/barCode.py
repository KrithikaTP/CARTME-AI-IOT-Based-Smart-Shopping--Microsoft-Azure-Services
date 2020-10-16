import cv2
from pyzbar.pyzbar import decode
from picamera import PiCamera


def barScan():
	for barcode in detectedBarcodes:
		camera.capture('barCode.jpg')
		image = cv2.imread('barCode.jng')
		detectedBarcodes = decode(image)
		(x, y, w, h) = barcode.rect
		cv2.rectangle(image, (x, y), (x + w, y + h), (255, 0, 0), 5)
		if(barcode.data != 'null'):
			print(barcode.data)
		else:
			return None
