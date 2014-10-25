class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    if user_signed_in? 
      if data = request.env["omniauth.auth"]
        # add this authentication object to current user
        if current_user.authentications.where(provider: data["provider"],
                                                 uid: data["uid"]).empty?
          current_user.authentications.create(provider: data["provider"],
                                               uid: data["uid"])
        end
      end
      redirect_to root_path and return
    else
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    
      if @user
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        return
      else
        # automatic cleanup of devise.* after sign in
        session["devise.facebook_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_registration_url and return
      end
    end
  end
  
  def google_oauth2
    if user_signed_in? 
      if data = request.env["omniauth.auth"]
        if current_user.authentications.where(provider: data["provider"],
                                                 uid: data["uid"]).empty?
          current_user.authentications.create(provider: data["provider"],
                                               uid: data["uid"])
        end
      end
      redirect_to root_path
    else
      @user = User.find_for_google_oauth2_oauth(request.env["omniauth.auth"], current_user)
      
      if @user
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Google_OAuth2") if is_navigational_format?
      else
        # automatic cleanup of devise.* after sign in
        session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_registration_url
      end
    end
  end
  
  def shibboleth
    if user_signed_in? 
      if data = request.env["omniauth.auth"]
        if current_user.authentications.where(provider: "CMU-Shibboleth",
                                                 uid: data["uid"]).empty?
          current_user.authentications.create(provider: "CMU-Shibboleth",
                                               uid: data["uid"])
        end
      end
      redirect_to root_path
    else
      @user = User.find_for_shibboleth_oauth(request.env["omniauth.auth"], current_user)
      
      if @user
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Shibboleth") if is_navigational_format?
      else
        # automatic cleanup of devise.* after sign in
        session["devise.shibboleth_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
  
end