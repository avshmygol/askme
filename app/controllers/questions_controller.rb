class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit]
  before_action :set_question_for_current_user, only: %i[update toggle_hide destroy edit]

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Новый вопрос создан!'
    else
      flash[:alert] = 'Вы неправильно заполнили поле с текстом вопроса (максимум 280 символов)'

      redirect_to user_path(@question.user)
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    @question.update(question_params)

    redirect_to user_path(@question.user), notice: 'Сохранили вопрос!'
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
