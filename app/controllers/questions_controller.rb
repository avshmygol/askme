class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[edit update destroy]
  before_action :set_question_for_current_user, only: %i[edit update toggle_hide destroy]

  def index
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)

    @tags = Tag.order("name").all.map{ |tag| "#" + tag.name }.join(", ")
  end

  def toggle_hide
    @question.toggle(:hidden).save

    redirect_to user_path(@question.user), notice: @question.hidden? ? 'Вопрос скрыт!' : 'Вопрос отображён!'
  end

  def hashtags
    @question = Question.new

    @tag = Tag.find_by(name: params[:name].downcase)
    @questions = @tag.questions
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)

    # Если пользователь не залогинен, то запишется nil (анонимный автор)
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: 'Новый вопрос добавлен'
    else
      flash[:alert] = 'Допущены ошибки в вопросе'

      render :new, status: 422
    end
  end

  def edit
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    @question.assign_attributes(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос сохранён'
    else
      # debugger
      flash[:alert] = "Допущены ошибки в вопросе"

      render :edit, status: 422
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: 'Вопрос удалён!'
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
