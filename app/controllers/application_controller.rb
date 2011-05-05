class ApplicationController < ActionController::Base
  #before_filter :create_first_admin
  before_filter :authorize
  protect_from_forgery

private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

protected
  def authorize
    if User.count == 0 
      create_first_admin
      return
    end
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

  def create_first_admin
    #flash[:notice] = 'There are no users. Create one admin user' if User.count == 0
    ignore1 = (controller_name + action_name != "usersnew")
    ignore2 = !request.post? || controller_name != "users"
    if User.count == 0 && ignore1 && ignore2 
      session[:user_id] = nil
      #redirect_to :controller => :users, :action => :new, :notice => 'create the first user'
      redirect_to new_user_url, :notice => "create an admin user first"
    end
  end

end
