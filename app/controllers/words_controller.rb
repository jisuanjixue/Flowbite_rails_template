class WordsController < ApplicationController
  before_action :check_editable, only: [:create, :destroy]
  before_action :set_word_book

  def create
    @word = @wordbook.words.create(word_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    redirect_to @wordbook
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to wordbook_path(@word.wordbook)
  end

  private

  def check_editable
    @wordbook = Word.find(params[:word_book_id])
    # unless @wordbook.editable
    #   redirect_to @wordbook, alert: 'This wordbook is not editable.'
    # end
  end

  def set_word_book
    @word_book = WordBook.find(params[:word_book_id])
  end

  def word_params
    params.require(:word).permit(:name, :pronunciation, :meaning, :example_sentence)
  end
end
