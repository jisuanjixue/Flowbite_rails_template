class WordBooksController < ApplicationController
  before_action :set_wordbook, only: [:show]

  def index
    @word_books = WordBook.all.includes(:user).order(created_at: :desc)
  end

  def show
    @words = @word_book.words
  end

  private

  def set_wordbook
    @word_book = WordBook.find(params[:id])
  end
end
