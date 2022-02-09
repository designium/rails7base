# Rails7Base

I created the Rails7Base as a scaffold application.

Countless times, I had to create apps that must have the following features:

1. Login system
2. Social login
3. Nested objects - recursive comments
4. File uploads
5. Forms
6. Home page
7. Custom look and feel

My main work is to develop MVPs for business ideas in my work. Being able to iterate apps ideas quickly is key to my work.

The current stack uses standard gems and libraries. For example, I'm using Bootstrap 5 for CSS templates. I tried using Tailwind - it's excellent, but it would require more time to customize. The advantage of Bootstrap 5 is that there are many examples and themes that I can build on top.

For the login system, I'm using Devise with Rollify and CanCanCan. Very standard implementation.

For social login, it's more complicated. Again, I'm using omniauth, but I had to customize it, and you will see it in the relevant sections in the code.

## What have I not added to this base code?

- Deployment libraries and code

## How to use

If you are using Ruby 3.1.0, you must follow the instructions below. If you are using another Ruby version, please use rbenv or another ruby manager to version 3.1.0.

You should be able to run this code quickly.

Clone this repo.

Then do
    bundle install

To send an email and use social logins, you have to provide the credentials for each social login, and you must provide the callback URL for each provider. Please follow the instructions for each omniauth library. Check the Gemfile.

You have to provide your credentials to run the social login part.

    EDITOR="nano" bin/rails credentials:edit

Add the following template into your credentials file (change the brackets for your value - no quotes):

    # Email stuff
    emailserver:
      user_name: [add the user name of your email SMTP account]
      password: [enter your password]
      stmp_address: [your smtp server]

    # Omniauth related
    google:
      client_id: [add you value]
      client_secret: [add you value]
    facebook:
      app_id: [add you value]
      secret: [add you value]
    microsoft:
      application_client_id: [add you value]
      secret: [add you value]
    linkedin:
      client_id: [add you value]
      client_secret: [add you value]
    twitter:
      api_key: [add you value]
      api_key_secret: [add you value]
      bearer_token: [add you value]
      client_id: [add you value]
      client_secret: [add you value]
    github:
      client_id: [add you value]
      client_secret: [add you value]
    quickbooks:
      client_id: [add you value]
      client_secret: [add you value]


After all of this, please do

     rails db:create db:migrate

Finally

     ./bin/dev



