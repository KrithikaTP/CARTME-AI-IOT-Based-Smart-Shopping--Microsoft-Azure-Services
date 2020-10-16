# CARTME- AI-IOT Based Smart Shopping Microsoft Azure Services


<!-- TABLE OF CONTENTS -->
## Table of Contents
* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Set Up the Azure Backend](#set-up-the-azure-backend)
* [Connecting the sensors with Raspberry Pi](#connecting-the-sensors-with-raspberry-Pi)
* [How to Run Bin Part Using Raspberry Pi](#how-to-run-bin-part-using-raspberry-pi)
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
    "id": "PROD01",
    "productId": "PROD01",
    "name": "Aqua Fresh Perfume",
    "price": 150,
    "month": "05",
    "day": "02",
    "year": "2021",
    "sex": "F",
    "consumable": false,
}
```
