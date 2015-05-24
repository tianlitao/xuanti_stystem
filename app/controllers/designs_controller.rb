class DesignsController < ApplicationController
  def create
    @user = Design.new(design_params)
    @user.teacher = current_user.id
    if @user.save
      redirect_to '/teacher/index'
    else
      render :back
    end
  end



  private
  def design_params
    params.require(:design).permit!
  end
end
