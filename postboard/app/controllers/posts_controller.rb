class PostsController < ApplicationController
  before_action :set_board
  before_action :set_post, only: [:destroy]
  before_action :set_is_mod, only: [:destroy]
  before_action :require_mod_access, only: [:destroy]

  # POST /b/:url_fragment/posts
  def create
    @post = Post.new(post_params)
    @post.board = @board

    respond_to do |format|
      if @post.save
        format.html { redirect_to :controller => 'boards', :action => 'show',
                                  :url_fragment => @board.url_fragment }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /b/:url_fragment/posts/:id
  def destroy
    board_fragment = @post.board.url_fragment
    @post.destroy
    respond_to do |format|
      format.html { redirect_to({:controller => 'boards', :action => 'show',
                                :url_fragment => board_fragment},
                                notice: 'Post was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:board_id, :body, :timestamps)
    end
end
