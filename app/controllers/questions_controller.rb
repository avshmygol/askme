class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit]
  before_action :set_question_for_current_user, only: %i[update toggle_hide destroy edit]

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(author: current_user, user: @user)
  end

  def create
    question_params = params.require(:question).permit(:author_id, :body, :user_id)

    @question = Question.new(question_params)

    # Если вопрос не анонимный игнорируем id автора из формы (противодействие html инъекции)
    @question.author = current_user unless @question.author.nil?

    if @question.save
      redirect_to user_path(@question.user), notice: 'Новый вопрос добавлен'
    else
      flash[:alert] = 'Допущены ошибки в вопросе'

      if @question.author.nil?
        redirect_to user_path(@question.user)
      else
        redirect_to new_question_path(user_id: @question.user)
      end
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    @question.assign_attributes(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос сохранён'
    else
      flash[:alert] = 'Допущены ошибки в вопросе'

      redirect_to edit_question_path(@question)
    end
  end

  def toggle_hide
    @question.toggle(:hidden).save

    redirect_to user_path(@question.user), notice: @question.hidden? ? 'Вопрос скрыт!' : 'Вопрос отображён!'
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@user), notice: 'Вопрос удалён!'
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @question = Question.new
    @questions = Question.all
  end

  def edit
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
