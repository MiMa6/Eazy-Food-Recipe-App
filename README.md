# Device-Agnostic Design Course Project II - 5f0ebb15-71d8-4226-a71d-1cbecc948990



## Eazt Food Repices Application

## Website url
https://mima6.github.io/Food-Recipe-App-site/

## Repo url
https://github.com/MiMa6/Eazy-Food-Recipe-App

## Description

Eazy food app lets you find all of the most delicious repices for your preferences! You can search hot and featured recipies and follow step by step instructions how to make those delecious dices. If you want to influence others with you taste share your own favourite recipe for others!

### Home page

In the home page you can see Featured recipe as well as hot categories. By clicking featured recipe user navigates to Recipe page for detailed information. By clicking any of Hot categoies user are direted to categories page where list of recipes can be found (+ list of categories depending on size of screen).

### Categories page 

In this page you can see all of the categories. Choose one category and you get to the list of recipes for that category (Recipe list page). By clicking recipe you get to recipe page for detailed instructions including ingredients and how to make those delicious dices. 

### Recipe List Page

List all of recipes by category.

### Categories and Recipe List Page
Tablet and Desktop versions use page where the content of categories and recipe list pages are combined to one page. 

### Search Page

In any page By clicking app bar search field you can find recipe by name. E.g. writiing "pepperoni" you get list of recipes including pepperoni in the name.

### My Recipe Page

In this page you got forms for adding your own recipes. You can choose name that sounds great for you. Ingredients and steps are listed by "/" separator. E.g. Ingredients: 1 potato / 2 onion. Category can be selected by clicking the form and choosing from list of premade categories. Finally push submit

### Login Page
Here you can login anonymously to create, delete and see favorite recipes. When you login there comes actionable icons beside recipe names in list for adding favourite and deleting recipes. Default recipes cant be deleted, only recipes you made yourself

### Favorite Page
See recipes you have added to favourite and count how many have added some recipe as favorite

### App- & Bottom bar

These are common elements that are shown in every page of app. In app bar you see the name of application and search bar. In bottom bar there is three buttons for navigation purposes. First button directs you back to home page, second shows categories page and last directs you to Add recipe page

### Key challenges
1. Sizing of widgets inside expand
2. Adding recipes to firestore
3. Authenctication

### Key Learnings
1. Responsive design for different devices
2. Using Firstore with providers
3. Architecture of different functions and elements in flutter app


### Dependencies
  cupertino_icons: ^1.0.2
  flutter_riverpod: ^2.4.0
  go_router: ^10.1.2
  riverpod: ^2.4.0
  shared_preferences: ^2.2.1
  google_fonts: ^6.1.0
  firebase_core: ^2.23.0
  cloud_firestore: ^4.13.2
  firebase_auth: ^4.14.1
  firebase_ui_firestore: ^1.5.14
