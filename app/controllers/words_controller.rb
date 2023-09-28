class WordsController < ApplicationController
  before_action :set_book, only: [:create, :destroy, :new, :show, :unmastered, :mastered ]
  before_action :set_word, only: [ :destroy, :show, :mastered, :unmastered ]

  def show
  end

  def new
  end

  def create
    @word = @word_book.words.create!(word_params)
    respond_to do |format|
      if @word.save
        format.html { redirect_to  word_book_path(@word_book), notice: '新单词添加成功' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @word.destroy!
    redirect_to word_book_path(@word_book)
  end

  def mastered
    @word.update!(status: 1)
    redirect_to word_book_path(@word_book), notice: '单词标记已掌握'
  end

  def unmastered
    @word.update!(status: 0)
    redirect_to word_book_path(@word_book), notice: '单词标记未掌握.'
  end

  private

  def set_book
    @word_book = WordBook.find(params[:word_book_id])
  end

  def set_word
    @word = @word_book.words.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:name, :pronunciation, :definition, :example_sentence)
  end

end
