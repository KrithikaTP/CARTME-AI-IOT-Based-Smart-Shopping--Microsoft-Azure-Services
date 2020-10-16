from azure.cognitiveservices.speech import AudioDataStream, SpeechConfig, SpeechSynthesizer, SpeechSynthesisOutputFormat
from azure.cognitiveservices.speech.audio import AudioOutputConfig


speech_config = SpeechConfig(subscription="<YOUR SUBSCRIPTION>", region="<YOUR SPEECH API REGION>")


audio_config = AudioOutputConfig(use_default_speaker=True)

synthesizer = SpeechSynthesizer(speech_config=speech_config, audio_config=audio_config)

#This function is the major initializer part
def botSpeaks(outputSpeech):
    synthesizer.speak_text_async(outputSpeech)
