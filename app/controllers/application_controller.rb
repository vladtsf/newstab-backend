class ApplicationController < ActionController::Base
  def welcome
    render :file => 'public/404.html', :status => 404
  end
end
