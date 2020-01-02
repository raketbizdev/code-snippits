# Gmail Security Blocking Rails Emails

First step to make sure that your app doesn’t crash if you have this type of email error is to set
`config.action_mailer.raise_delivery_errors = false`
in your `config/environments/production.rb`

2nd Turn on 2-factor authentication best if you use phone its faster that way

### Step 1: Set up 2-Step Verification
* Go to your Google Account.
* On the left navigation panel, click Security.
* On the Signing in to Google panel, click 2-Step Verification.
* Click Get started.
* Follow the steps on the screen.
