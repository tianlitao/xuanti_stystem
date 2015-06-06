class AdminController < ApplicationController
  def index
    @all_title = Design.all
  end
end
