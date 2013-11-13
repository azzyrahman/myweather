
BEWD: FINAL PROJECT
-----------------------------
#DESCRIPTION

The 'Myweather' is a weather information website that provides it users the following weather information services

- Current condition
- Observation 
- 7 day forecasts and
- Local radar images


for a user selected location


#FEATURES

- Normal users can search their location and see current condition and observation
- Only signed in users can see the advanced features like 7 day forecast, local radar
- Logged user can save thier favorite location

#USER STORIES

1) Ms Public is a local resident living in Campbelltown. She works for the Campbelltown City Council (CCC) and monitors everyday's roadworks going on around all suburbs of CCC.

Ms Public visits myweather.com.au everyday several times to watch the current weather conditions of each suburbs of CCC and provide the necessary guidance to the construction contractors.

Ms Public is a gneral user of this site and does not need to sign in.  She just enters the postcode of each suburb to get the relevant weatther information.

2) Mr Citizen is working for Homeaway Travel as a tour organizer who organizes tours across Australia. He visits myweather.com.au to see the next 7 day forecasts for those locations he is going to send the tourists. He uses this information to guide the tour accordingly or reschedule the tour if emergency weather condition would occurs.

He maintains weather information for the list of locations of his next tour.

Mr Citizen is an advanced user of myweather.com.au and creates an account to see the 7 day forecasts and save his favourite locations.  

#ENTITY RELATIONAL MODEL

![ER Diagram](http://yuml.me/e0f78f9f "ER Diagram")


#USE-CASE DIAGRAM

![ER Diagram](http://yuml.me/022751a0 "USE-CASE Diagram")


#MODEL

- user
- location
- user_location / favorite_location
- current_condition
- observation 
- forecast
- radar

#CONTROLLER

#DESIGN
- HEADER
 - LOGO
 - MENU
  - HOME
  - ABOUT
  - SEARCH
  - OBSERVATION
  - FORECAST (If logged in)
  - RADAR (If logged in)
  - BONUS ?
 - USER INFO
   - LOGIN
   - LOGOUT
- BODY
- FOOTER
 - COPYRIGHT
 - TERM OF USE
 -  
