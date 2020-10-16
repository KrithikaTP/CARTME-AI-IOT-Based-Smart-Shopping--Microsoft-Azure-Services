import os
import time
import textToSpeech
from visualSearch import searchProduct

from azure.cognitiveservices.knowledge.qnamaker.authoring import QnAMakerClient
from azure.cognitiveservices.knowledge.qnamaker.runtime import QnAMakerRuntimeClient
from azure.cognitiveservices.knowledge.qnamaker.authoring.models import QnADTO, MetadataDTO, CreateKbDTO, OperationStateType, UpdateKbOperationDTO, UpdateKbOperationDTOAdd, EndpointKeysDTO, QnADTOContext, PromptDTO
from azure.cognitiveservices.knowledge.qnamaker.runtime.models import QueryDTO
from msrest.authentication import CognitiveServicesCredentials

def generate_answer(client, kb_id, runtimeKey,questionChat):
    print ("Querying knowledge base...")

    authHeaderValue = "EndpointKey " + runtimeKey

    listSearchResults = client.runtime.generate_answer(kb_id, QueryDTO(question = questionChat), dict(Authorization=authHeaderValue))
    for i in listSearchResults.answers:
        #to undertand by the bot if the user is asking 'what a product is?'
        #If it is asked, go to bing visual search by capturing the photoof the product in
        #front of the camera
        if(str(i.answer) == 'Search Bing'):
            searchProduct()
        #else the bot would speak with its intelligence
        else:
            textToSpeech.botSpeaks(str(i.answer))
        print(i.answer)

subscription_key = '<YOUR SUBSCRIPTION KEY>'

endpoint = '<YOUR END POINT>'
runtime_endpoint = '<YOUR RUNTIME ENDPOINT>'
kb_id = '<YOUR KB ID>'
queryRuntimeKey = '<QUERY RUNTIME KEY>'

runtimeClient = QnAMakerRuntimeClient(runtime_endpoint=runtime_endpoint, credentials=CognitiveServicesCredentials(queryRuntimeKey))
def callBot(chat):
    generate_answer(client=runtimeClient,kb_id=kb_id,runtimeKey=queryRuntimeKey,questionChat = chat)
