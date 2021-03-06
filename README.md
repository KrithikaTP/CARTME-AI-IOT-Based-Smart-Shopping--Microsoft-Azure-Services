# CARTME- AI-IOT Based Smart Shopping Microsoft Azure Services

<!-- TABLE OF CONTENTS -->
## Table of Contents
* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Set Up the Azure Backend](#set-up-the-azure-backend)
* [Connecting the sensors with Raspberry Pi](#connecting-the-sensors-with-raspberry-Pi)
* [How to Run Smart Trolley Using Raspberry Pi](#how-to-run-smart-trolley-using-raspberry-pi)
* [Run the Flutter App](#run-the-flutter-app)


<!-- ABOUT THE PROJECT -->
## About The Project
We all have had shopping experience in supermarkets. Supermarkets, are the same in most of the places and have made no development since they were introduced(concept of Supermarkets).

It's still a fact that people are waiting in queues for long time in Supermarkets to bill their Cart.   

Customers hardly get assistance for their shopping and it seems not to be personalized.

People require more recommendations and pleasing experience to make their buying happy.

### Solution
A Cross platform Mobile App is created where customers can Log In. Before going to the supermarket ,the user can add the list of items that he/she is going to purchase.

So all these products will be added into the TOBUY list(in the APP). Once it's done, the users can happily go to the Supermarket and take a trolley/shopping basket.

The user must open the App and scan the QR code( in his mobile) in front of the camera (attached to the trolley). This is to identify the user.

Once done, the user can go to the home page (of the App) and fix his mobile in the phone stand(attached to the trolley). Now, the user can keep adding the products(by scanning the bar code in front of the camera attached to the trolley) as present in their TOBUY list(home page of the APP). 

Now, the user can also talk to the trolley. A smart Voice Assistant (two way communication) is present which supports the user throughout his/her shopping. 

Customers can ask any doubts or support regarding shopping to the voice assistant bot.
The bot takes some autonomous actions like warning/notifying people when they take an expired product, suggests some offers/ discounts, helps in some recommendations, like the gender recommendations(Eg: When a man takes a deodorant that is meant for girls, the voice assistant warns him).  Also, customers can ask the voice assistant like, where a particular product is present in the shop, some suggestions on dresses and many more.

More importantly, when users have a doubt on what the product is , they can simply take the product in front of the Camera(attached to the trolley) and ask "What is this ?" to the smart assistant. It captures the Image and recognizes it (using Bing Visual Search) and replies.

Security Issues – Shop Exit detectors will detect if any unscanned products leave the shop. Similarly a high sensitive weight sensor is present below the cart which detects if any unscanned products overweigh. So, no means of forgery can be made.

Now after the shopping is done, the user just needs to go to the cart section in his App. All his products added in his trolley will be present in the Cart Section. The customer can just make the payment via the App.

Also, the Supermarket's management can view the statistical analysis of the products on a Dashboard(using azure IOT services). This would help the management to know more about customer's preferences and mostly liked products and the products at peak sale.

## Built With
* Speech to Text – to convert user Speech into text

* Text to Speech – to convert the bot's text into speech 

* QnA Maker – entire bot's intelligence 

* Azure Cosmos DB – backed with customer data and products data

* Azure Bing Visual Search – visual search for products and support customers.

* Azure IOT Hub – receive data regarding products sale

* Stream Analytics Job – Input/Query/Output data to Power Bi

* Power BI Dashboard – to visualize the statistical analysis on products


## Set Up the Azure Backend
### 1) Register Raspberry Pi with Azure IOT Hub
Go through this link to register the raspberry pi [How to register a new device in IOT Hub](https://docs.microsoft.com/en-us/azure/iot-edge/how-to-register-device)

### 2) Create a Cosmos DB Container
This has to be setup in order to read and write data of the customer. Also a mock data of the products are needed to be entered.Similarly when a user does log in via the Flutter App, the data is fetched from Cosmos DB and it is read. 
* Go to the Azure Portal
* Create a database named 'ShopAsAi'
* Create a container name 'customers'
* Create a container name 'products'
To get more idea on how to create a container in Cosmos DB refer the link [Quickstart with Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/create-cosmosdb-resources-portal)
Add a mock data(for customers) as in the follwing prescribed format
```
{

    "id": "CUS087",
    "userId": "CUS087",
    "Name": "Alex",
    "Age": 41,
    "Sex": "M",
    "Address": "No.09,Greams Road,Egmore, Chennai-08",
    "checkList": [],
    "cart": []
}
```
Add a mock data(for products) as in the follwing prescribed format
```
{
    "id": "2345601",
    "productId": "2345601",
    "name": "Aqua Fresh Perfume",
    "price": 150,
    "month": "05",
    "day": "02",
    "year": "2021",
    "sex": "F",
    "consumable": false,
}
```
### 3) Create resources for Text to Speech / Speech to Text in Azure Portal
Resources for Text to Speech / Speech to Text has to be created in Azure Portal in order to use the the subscription Keys in our code. 
Go through this link to create resources for our Speech Api [Create a Speech to Text / Text to Speech Resource via Azure Portal](https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/overview#try-the-speech-service-for-free)

### 4) Create the bot using QnA Maker 
Download the 'dataset.txt' file inside the 'Smart_Trolley_Raspberry_Pi' folder which contains some mock data of the Questions and Answers. 
Using the following link upload the file, train and publish the AI model [Create, train, and publish your QnA Maker knowledge base](https://docs.microsoft.com/en-us/azure/cognitive-services/qnamaker/quickstarts/create-publish-knowledge-base)
This will work for a nice shopping experience. But this can be much more improved by adding more questions-answers.

### 5) Setup the Steam Analytics and Power BI Dashboard
* Create a stream analytics resource in the Azure Portal. 
* Create an input resource (it is from IOT Hub)
* Create an output resource (choose the Power BI option)
* Setup the query as follows
```
SELECT
    CAST(iothub.EnqueuedTime AS datetime) AS event_date,
    CAST(productCount AS float) AS productCount
   
INTO
    outputbi
FROM
    inputiothub
```
Go to the Power BI dashboard and set up a simple Line Graph Chart and Card with this dataset available in the options while setting up.

## Connecting the sensors with Raspberry Pi
### 1) Connect the HX711 Weight Sensor to Raspberry Pi as shown in the circuit diagram below
![](https://tutorials-raspberrypi.de/wp-content/uploads/Raspberry-Pi-HX711-Steckplatine-600x342.png)
### 2) Connect the V2 Camera in the Camera port of Raspberry Pi as shown below
![](https://www.allaboutcircuits.com/uploads/articles/raspberry-pi-camera-2.png?v=1470886330073)

## How to Run Smart Trolley Using Raspberry Pi
### Prerequisite
* Clone the 'Smart_Trolley_Raspberry_Pi' folder in Raspberry Pi
* Install the following packages in Raspberry Pi.
* Launch the terminal and install 
```sh
pip install -r requirements.txt
```
### Set your AZURE Credentials 
* Open the config.py file and change the following details from your Azure Portal for Cosmos DB.
```sh
settings = {
    'host': os.environ.get('ACCOUNT_HOST', '<YOUR HOST NAME>'),
    'master_key': os.environ.get('ACCOUNT_KEY', 'YOUR ACCOUNT MASTER KEY'),
    'database_id': os.environ.get('COSMOS_DATABASE', '<YOUR DATABASE ID>'),
    'container_id': os.environ.get('COSMOS_CONTAINER', '<YOUR CONTAINER ID>'),
}
```
* Open the powerBiStats.py file and change the following details from your Azure IOT HUB Portal.
```sh
CONNECTION_STRING = "<YOUR CONNECTION STRING>"
```
* Open the azureBot.py file and change the following details from your Azure Portal for QnA Maker.
```
subscription_key = '<YOUR SUBSCRIPTION KEY>'

endpoint = '<YOUR END POINT>'
runtime_endpoint = '<YOUR RUNTIME ENDPOINT>'
kb_id = '<YOUR KB ID>'
queryRuntimeKey = '<QUERY RUNTIME KEY>'
```
* Open the speechToText.py, textToSpeech.py files and change the following details from your Azure Portal for Azure Speech API.
```
speech_key, service_region = "<YOUR KEY>", "<YOUR SPEECH API REGION>"
speech_config = SpeechConfig(subscription="<YOUR SUBSCRIPTION>", region="<YOUR SPEECH API REGION>")
```
* Open the visualSearch.py, textToSpeech.py files and change the following details from your Azure Portal for Bing Visual Search.
```
BASE_URI = "YOUR BASE URI"
SUBSCRIPTION_KEY = '<YOUR SUBSCRIPTION KEY>'
```
Run the shopAsAI.py file to perform the Trolley's Function
```
python shopAsAI.py
```
Run the powerBiStats.py to visualize the product sales and the highly saled product as a graph in your POWER BI dashboard  (Send some random values as mock data in the main function of the python file)
```
python powerBiStats.py
```
**Check out the video demo for more clarity**

## Run the Flutter App
### Set your AZURE Credentials 
* Open the generate_auth_token.dart and change the following details from your Azure Cosmos DB Portal.
```sh
String masterKey = '<YOUR MASTER KEY(Cosmos DB)>';
```
* Open the azure_cosmos.dart and change the following details from your Azure Cosmos DB Portal for each function inside the file.
```
<YOUR COSMOS DB URI> 
GenerateAuthToken authToken = GenerateAuthToken(resourceId: '<Your RESOURCE ID>',resourceType: '<YOUR RESOURCE TYPE>',verb: '<GET/POST/PUT>');
```
Eg: 
For a resource Id 'https://<YOUR COSMOS DB URI>/dbs/ShopAsAI/colls/products/docs', the verb is 'GET', resourceType is 'docs'.

* Clone the folder except the 'Smart_Trolley_Raspberry_Pi'.
* Pub Get the dependencies.
* Setup Visiual Studio Code for App Development and run the app.
