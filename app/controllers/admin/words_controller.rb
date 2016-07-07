class Admin::WordsController < ApplicationController
  layout "admin"
  before_action :check_admin
  before_action :load_word, except: [:index, :create, :new]
  before_action :load_all_categories, except: :destroy
  before_action :authorize_destroy, only: :destroy
  def index
    @words = Word.includes(:category).paginate page: params[:page],
      per_page: Settings.per_page
    respond_to do |format|
      format.html
      format.json{render json: @words}
    end
  end

  def new
    @word = Word.new
    @word.word_answers.new
  end

  def create
    @word = Word.new word_params
    respond_to do |format|
      if @word.save
        format.html do
          flash[:success] = t "page.admin.words.add.success"
          redirect_to admin_words_path
        end
        format.json{render @word, status: :ok}
      else
        format.html do
          flash[:danger] = t "page.admin.words.add.danger"
          render :new
        end
        format.json{render json: @word.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @word.update_attributes word_params
        format.html do
          flash[:success] = t "page.admin.words.edit.success"
          redirect_to admin_words_path
        end
        format.json{render @word, status: :ok}
      else
        format.html do
          flash[:danger] = t "page.admin.words.edit.danger"
          render :edit
        end
        format.json{render @word.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t "page.admin.words.delete.success"
        redirect_to admin_categories_path
      end
      format.json{head :nocontent}
      format.js
    end
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
  end

  def load_all_categories
    @categories = Category.all
  end

  def authorize_destroy
    if @word.word_lessons.size > 0
      flash[:warning] = t "page.admin.words.delete.warning"
      redirect_to :back
    end
  end

  def word_params
    params.require(:word).permit(:id, :native_word, :meaning, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :word_id])
  end
end
