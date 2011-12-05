class UserAnswersController < ApplicationController
  def index
    @user_answers = UserAnswer.all
  end

  def show
    @user_answer = UserAnswer.find(params[:id])
  end

  def new
    @user_answer = UserAnswer.new
  end

  def create
    @user_answer = UserAnswer.new(params[:user_answer])
    if @user_answer.save
      redirect_to @user_answer, :notice => "Successfully created user answer."
    else
      render :action => 'new'
    end
  end

  def edit
    @user_answer = UserAnswer.find(params[:id])
  end

  def update
    @user_answer = UserAnswer.find(params[:id])
    if @user_answer.update_attributes(params[:user_answer])
      redirect_to @user_answer, :notice  => "Successfully updated user answer."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user_answer = UserAnswer.find(params[:id])
    @user_answer.destroy
    redirect_to user_answers_url, :notice => "Successfully destroyed user answer."
  end
end
