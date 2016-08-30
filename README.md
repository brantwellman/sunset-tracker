# Sunset-Tracker

[Live application on Heroku](https://sunset-tracker.herokuapp.com/)  
[Github Repo](https://github.com/brantwellman/sunset-tracker)


This is the personal project of [Brant Wellman](https://github.com/brantwellman) created as a part of the curriculum for the [Turing School of Software & Design](http://turing.io).

[Gif of the live production site](http://recordit.co/I0EUGiEKAF)


Application requires an active Twitter account to login. If you would like to use a generic twitter account:  
* username: Brant_test, password: password5.


## Overview
This application is for those who who frequently seek out sunsets (and sunrises) wherever they may be heading. The user provides a date and address for when and where they would like to view a sunset, and the application provides them with sunrise/sunset times for that date along with the weather forecast information for that hour of the day.  

Users can save recent search results in a favorites section and also view data for the most frequently searched for locations by all users of the application.

## Tools
  * Rails 4.2, PostgreSQL, Geocoder, Twitter OAuth,  MaterializeCSS
  * [Dark Sky Forecast API](https://developer.forecast.io/), Faraday
  * Testing / Monitoring- RSpec, VCR, Skylight Performance Monitoring
