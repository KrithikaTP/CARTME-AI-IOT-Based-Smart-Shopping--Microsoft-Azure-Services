import requests, json
import textToSpeech
from picamera import PiCamera
BASE_URI = "YOUR BASE URI"
SUBSCRIPTION_KEY = '<YOUR SUBSCRIPTION KEY>'
HEADERS = {'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY}


def print_json(obj):
    """Print the object as json"""
    print(json.dumps(obj, sort_keys=True, indent=2, separators=(',', ': ')))

def searchProduct():
    camera.capture('temp.jpg')
    imagePath = 'temp.jpg'
    file = {'image' : ('myfile', open(imagePath, 'rb'))}
    try:
        response = requests.post(BASE_URI, headers=HEADERS, files=file)
        response.raise_for_status()
        textToSpeech.botSpeaks(str(response.json()['tags'][2]['displayName']))

    except Exception as ex:
        raise ex
