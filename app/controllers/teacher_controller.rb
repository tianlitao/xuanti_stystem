class TeacherController < ApplicationController
  before_action :judge_role
  # skip_before_action :judge_role, only: [:login, :logout ,:signup,:create_login_session]
  def judge_role
    if current_user.role == '学生'
      redirect_to :root
    end
  end
  def score
  @score = Design.find_by_id(params[:id])
  end
  def modify_score
    @score = Design.find_by_id(params[:id])
    @score.score = params[:score]
    @score.save
    redirect_to '/teacher/score_eva'
  end
  def score_eva
    @all_title = Design.where(:teacher => current_user.id)
  end
  def index
    @all_title = Design.where(:teacher => current_user.id)
  end

  def modify
  @title = Design.find_by_id(params[:id])
  end

  def design_update
    @title = Design.find_by_id(params[:format])
    @title.title = params['design']['title']
    @title.demand = params['design']['demand']
    @title.save
    redirect_to '/teacher/index'
  end

  def delete
    Design.find_by_id(params[:id]).delete
    redirect_to :back
  end

  def add_title
    @title = Design.new
  end

  def message
    @message = Message.where(:to => current_user.id)
  end

  def send_message
    @message = Message.new
  end

  def check
    list = []
    if (File.exist?('public/upload/'+ Design.find_by_id(params[:id]).user_id.to_s))
    else
      Dir.mkdir('public/upload/'+ Design.find_by_id(params[:id]).user_id.to_s)
    end
    Find.find('public/upload/'+ Design.find_by_id(params[:id]).user_id.to_s) do |path|
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

  def teacher_upload
    if (File.exist?('public/upload/'+ Design.find_by_id(params[:id]).user_id.to_s))
    else
      Dir.mkdir('public/upload/'+ Design.find_by_id(params[:id]).user_id.to_s)
    end
    uploaded_io = params[:upload]
    File.open(Rails.root.join('public', 'upload', Design.find_by_id(params[:id]).user_id.to_s, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    redirect_to :back

  end
end
