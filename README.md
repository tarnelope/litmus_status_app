# Litmus Status App

A couple of things to note:
* Uses port 4000 for the local server
* To update the status, enter the following into your terminal:
`curl -X POST 'http://localhost:4000/api/v1/status' -d 'current_status=UP’`
* To add a new message, enter the following into your terminal:
`curl -X POST 'http://localhost:4000/api/v1/status_messages' -d 'description=whatever you want here`
