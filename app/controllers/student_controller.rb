class StudentController < ApplicationController
  before_action :judge_role , except: [:delete_upload]
  require 'find'
  def judge_role
    if current_user.role == '老师'
      redirect_to :root
    end
  end

  def get_score
  @score = Design.find_by_user_id(current_user.id)
  end
  def index
    if Design.find_by_user_id(current_user.id)
      redirect_to '/student/upload_design'
    else
      @all_title = Design.all
    end

  end

  def message_student
      @user = Message.new(message_params)
      @user.from = current_user.id
      if @user.save
        redirect_to '/student/index'
      else
        render :back
      end
  end

  def message

      @message = Message.where(:to => current_user.id)

  end

  def choice_title
    @title = Design.find_by_id(params[:id])
  end

  def send_teacher
    @message = Message.new
    @teacher = Design.find_by_user_id(current_user.id).teacher
  end

  def confirm_title
    title = Design.find_by_id(params[:id])
    title.user_id = current_user.id
    title.save
    redirect_to '/student/index'
  end

  def upload_design
    list = []
    if (File.exist?('public/upload/'+ current_user.id.to_s))
    else
      Dir.mkdir('public/upload/'+ current_user.id.to_s)
    end
    Find.find('public/upload/'+ current_user.id.to_s) do |path|
      if File.file?(path)
        yield path if block_given?
        files = {}
        files['name'] = File.basename(path)
        files['path'] = path
        list << files
      end
    end
    @picture_list = list
  end

  def upload
    if (File.exist?('public/upload/'+ current_user.id.to_s))
    else
      Dir.mkdir('public/upload/'+ current_user.id.to_s)
    end
    uploaded_io = params[:upload]
    File.open(Rails.root.join('public', 'upload', current_user.id.to_s, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    redirect_to :back
  end

  def delete_upload
    path_file = File.join(params[:path])
    object_file=File.new(path_file, "w+")
    object_file.close # 缺少这一步，会报“in `delete': Permission denied - f:/ruby/Test.txt (Errno::EACCES)”
    File.delete(path_file)
    redirect_to :back
  end



  private
  def message_params
    params.require(:message).permit!
  end

end
