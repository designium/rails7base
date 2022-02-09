class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except("extra") # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def microsoft_graph
    # You need to implement the method below in your model (e.g. app/models/user.rb)

    # Specific weird use case from Microsoft Graph, if the email is not found, we need to pull from another variable
    # request.env["omniauth.auth"].extra.raw_info["userPrincipalName"] has the email info for some reason, maybe old MSFT users
    if request.env["omniauth.auth"]["info"]["email"].blank?
      request.env["omniauth.auth"]["info"]["email"] = request.env["omniauth.auth"]["extra"]["raw_info"]["userPrincipalName"]
    end

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Microsoft") if is_navigational_format?
    else
      session["devise.microsoft_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def linkedin
    # There is no standard for each omniauth provider in regards about variable name I have to adjust for linkedin
    if request.env["omniauth.auth"]["info"]["image"].blank?
      request.env["omniauth.auth"]["info"]["image"] = request.env["omniauth.auth"]["info"]["picture_url"]
    end

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Linkedin") if is_navigational_format?
    else
      session["devise.linkedin_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def quickbooks_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      # session['params'] = params
      puts "CONCTROLLERCONTROLLER"
      puts request.env['omniauth.auth']
      puts params
      puts "COTNROLLERCONTROLLER"

      @user = User.from_omniauth(request.env['omniauth.auth'], params)

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Quickbooks'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.quickbooks_data'] = request.env['omniauth.auth'].except("extra").except("credentials") # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  end

  def failure
    redirect_to root_path
  end

end
