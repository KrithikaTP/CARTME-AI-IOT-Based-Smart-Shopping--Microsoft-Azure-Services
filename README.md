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
