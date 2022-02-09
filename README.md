# Rails7Base

I created the Rails7Base as a scaffold application.

![Alt text](/app/assets/imagse/screenshots/rails7base_20220209_002.png?raw=true "You can access from localhost:3000/page/homepage")

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

To accelerate development, I use HAML, Simple_form and SCSS.

For the login system, I'm using Devise with Rollify and CanCanCan. Very standard implementation.

For social login, it's more complicated. Again, I'm using omniauth, but I had to customize it, and you will see it in the relevant sections in the code.

## Additional Screenshots

![Alt text](/app/assets/imagse/screenshots/rails7base_20220209_001.png?raw=true "You can access from localhost:3000/page/login2")

![Alt text](/app/assets/imagse/screenshots/rails7base_20220209_003.png?raw=true "You can access from localhost:3000/page/transactions")

You can use the classes in the html elements to customize your app.

## What have I not added to this base code?

- Deployment libraries and code

## How to use

If you are using Ruby 3.1.0, you must follow the instructions below. If you are using another Ruby version, please use rbenv or another ruby manager to version 3.1.0.

You should be able to run this code quickly.

Clone this repo.

    git clone https://github.com/designium/rails7base

Then do

    bundle install

Run the following commands to install esbuild and scss:

     ./bin/rails javascript:install:esbuild

Ignore all the errors. We have the files in place already.

     ./bin/rails css:install:bootstrap

Also ignore all errors, but it will ask you to overwrite, just say "n". Don't overwrite. We have the file setup correctly.

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

You will be routed to the login page. You can just create a dummy user to access the post class. Currently, it is the main routing path.

You need to customize the look and feel!

