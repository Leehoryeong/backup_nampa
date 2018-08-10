class CustomController < ApplicationController
  before_action :authenticate_user!

  def info
    @userspec = current_user.userspec
  end

  def index
  end
end
