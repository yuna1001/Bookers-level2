class CommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.comments.new(comment_params)
    comment.book_id = book.id
    comment.save
    @url = request.referer
    redirect_to @url
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = current_user.comments.find_by(book_id: book.id)
    comment.destroy
    @url = request.referer
    redirect_to @url
  end

  private
  def comment_params
      params.require(:comment).permit(:comment)
  end
    
end
