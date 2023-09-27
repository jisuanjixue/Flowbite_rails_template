class WordBooksController < ApplicationController
  before_action :set_wordbook, only: [:show]

  def index
    @word_books = WordBook.all.includes(:user).order(created_at: :desc)
  end

  def show
    @words = @wordbook.words
  end

  private

  def set_wordbook
    @wordbook = current_user.wordbooks.find(params[:id])
  end
end
