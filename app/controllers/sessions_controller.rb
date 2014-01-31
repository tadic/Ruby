class SessionsController < ApplicationController
    def new
      # render�i kirjautumissivun
    end

    def create
      user = User.find_by username: params[:username]
      if user.nil? or not user.authenticate params[:password]
        redirect_to :back, notice: "username and password do not match"
      else
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      end
    end

    def destroy
      # nollataan sessio
      session[:user_id] = nil
      # uudelleenohjataan sovellus p��sivulle 
      redirect_to :root
    end
end