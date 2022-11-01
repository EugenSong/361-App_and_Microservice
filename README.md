# Microservice: How to request and receive data + UML

## Request
To request data, listen to real-time changes from the collection located in Firebase's Cloud Firestore from the app. 
    
Example call:
<img src= "https://i.imgur.com/KkK1jK7.png)"><br>


## Receive
To receive data into the mobile app, simply access the new fields in the database using proper object notation.
In summary, accessing the data fields following the format: 
collection --> document --> field (key + value)

Example to access a document: 
<img src= "https://i.imgur.com/Eyz1ujQ.png)"><br>

## UML
UML Diagram that shows communication between app, microservice and database.

<img src= "https://i.imgur.com/JG09Ult.png)"><br>
