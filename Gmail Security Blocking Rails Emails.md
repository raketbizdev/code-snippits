# Gmail Security Blocking Rails Emails

First step to make sure that your app doesn’t crash if you have this type of email error is to set 
`config.action_mailer.raise_delivery_errors = false`
in your `production.rb`
