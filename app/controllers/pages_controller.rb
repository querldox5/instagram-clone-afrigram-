class PagesController < ApplicationController
  def home
    redirect_to(:new_user_session) unless user_signed_in?
  end
end
