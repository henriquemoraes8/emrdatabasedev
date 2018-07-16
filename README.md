# README

<h1>EMeRge database project</h1>

<h3>To check the database on Heroku: <h3>

* log in on https://dashboard.heroku.com/apps/emr-database-api
with the EMeRge credentials

* on the top right corner, there is a "more" button, click on it and 
choose "run console"

* run "rails c" on the console

* now you are in the database, you can run commands like:
 
     * User.all -> gets all users
     
     * Clinic.find(id) -> finds a clinic by id
     
     * Insurance.find_by_email('email') -> finds an insurance by email
     
     
<h3>To check text message quota</h3>

Open the Terminal app and input

curl https://textbelt.com/quota/API_KEY

where API_KEY is the text belt key



