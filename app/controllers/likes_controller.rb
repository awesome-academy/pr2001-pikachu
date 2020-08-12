class LikesController < ApplicationController
  before_action :load_likeable

  def create
    @like = @likeable.likes.build(like_params)
    @like.save
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
  end

  private

  def load_likeable
    resource, id = request.path.split('/')[1,2]
    @likeable = resource.singularize.classify.constantize.find(id)
  end

  def like_params
    params.require(:like).permit(:user_id)
  end
end