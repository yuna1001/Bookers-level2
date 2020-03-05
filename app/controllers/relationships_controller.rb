class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:follower_id])
    current_user.follow(user)
    @url = request.referer
    redirect_to @url
  end

  def destroy
    user = Relationship.find(params[:id]).follower
    current_user.unfollow(user)
    @url = request.referer
    redirect_to @url
  end

end





