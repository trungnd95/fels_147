class Admin::WordsController < ApplicationController
  layout "admin"
  before_action :check_admin
  before_action :load_word, except: [:index, :create, :new]
  before_action :load_all_categories, except: :destroy

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
    2.times.each{@word.word_answers.new}
  end

  def create
    @word = Word.new word_params
    @word_answers = word_params[:word_answers_attributes]
    flag = false;
    if @word_answers.nil?
      flash[:danger] = "Word answer can not be blank !!!"
      render action: :new
    else
      @word_answers.each do |answer|
        if answer[1][:is_correct].to_i == 1
          flag = true; break
        end
      end
      if flag
        respond_to do |format|
          if @word.save
            format.html do
              flash[:success] = t "page.admin.words.add.success"
              redirect_to admin_words_path
            end
            format.json{render @word, status: :ok}
          else
            format.html do
              # flash[:warning] = @word.errors.full_messages
              # redirect_to :back
              flash[:danger] = t "page.admin.words.add.danger"
              render action: :new
            end
            format.json{render json: @word.errors, status: :unprocessable_entity}
          end
        end
      else
        flash[:danger] = "Let choose one answer is correct !!!"
        render action: :new
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
          render action: :edit
        end
        format.json{render @word.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @word.word_lessons.size > 0
        @message = t "page.admin.words.delete.warning"
      else
        @word.destroy
        format.html do
          flash[:success] = t "page.admin.words.delete.success"
          redirect_to admin_categories_path
        end
        format.json{head :nocontent}
      end
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

  def word_params
    params.require(:word).permit(:id, :native_word, :meaning, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :word_id])
  end
end
