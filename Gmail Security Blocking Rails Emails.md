# Gmail Security Blocking Rails Emails

First step to make sure that your app doesn’t crash if you have this type of email error is to set
`config.action_mailer.raise_delivery_errors = false`
in your `config/environments/production.rb`

2nd Turn on 2-factor authentication best if you use phone its faster that way

### Step 1: Set up 2-Step Verification
* Go to your ***Google Account***.
* On the left navigation panel, ***click Security***.
* On the Signing in to Google panel, click ***2-Step Verification***.
* Click ***Get started***.
* Follow the steps on the screen.

### Add the App Password
* Go to https://myaccount.google.com/apppasswords
* Select the app and device you want to generate the app password for.
* Select ***custom name***
* then save the password

### Add it to the  `config/environments/production.rb`
its important you save all your credentials inside `master.key` or use `figaro gem.`

```ruby
config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               "#{Rails.application.credentials.production[:domain]}", # domain.com
    user_name:            "#{Rails.application.credentials.production[:mail_username]}", # your_email@gmai.com
    password:             "#{Rails.application.credentials.production[:app_mail_password]}",# app_mail_password
    authentication:       'plain',
    enable_starttls_auto: true }
```
