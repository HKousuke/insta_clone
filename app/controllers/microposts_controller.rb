class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  @micropost = current_user.microposts.build(micropost_params)
  re = /@([0-9a-z_]{5,15})/i
  @micropost.content.match(re)
  if $1
    reply_user = User.find_by(unique_name: $1.downcase)
    @micropost.in_reply_to = reply_user.id if reply_user
  end

  
  
  def show 
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @micropost.user_id)

  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :img)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
  end
  
  def destroy
   @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
end
