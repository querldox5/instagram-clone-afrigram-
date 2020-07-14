class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
  
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url
      end
    end

    def create
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    end
  
    def failure
      redirect_to root_path
    end
  end