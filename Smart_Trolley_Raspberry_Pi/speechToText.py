import azure.cognitiveservices.speech as speechsdk
import azureBot
import time
import visualSearch
speech_key, service_region = "<YOUR KEY>", "<YOUR SPEECH API REGION>"
speech_config = speechsdk.SpeechConfig(subscription=speech_key, region=service_region)
speech_recognizer = speechsdk.SpeechRecognizer(speech_config=speech_config)


def initializerSpeech():
    result = speech_recognizer.recognize_once()
    if result.reason == speechsdk.ResultReason.RecognizedSpeech:
        print("Recognized: {}".format(result.text))
        azureBot.callBot(str(result.text))
        initializerSpeech()#once again make the speech work after one reply.
    elif result.reason == speechsdk.ResultReason.NoMatch:
        initializerSpeech()#to make the speech work all time even when no speech is detected
    elif result.reason == speechsdk.ResultReason.Canceled:
        cancellation_details = result.cancellation_details
        print("Speech Recognition canceled: {}".format(cancellation_details.reason))
        if cancellation_details.reason == speechsdk.CancellationReason.Error:
            print("Error details: {}".format(cancellation_details.error_details))
