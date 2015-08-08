class BoardsController < ApplicationController
  before_action :set_board, only: [:edit, :update, :destroy, :end_moderate]
  before_action :set_board_fragment, only: [:show, :post, :moderate,
                                            :moderate_form]
  before_action :set_is_mod, only: [:show, :edit, :update, :destroy]
  before_action :require_mod_access, only: [:edit, :update, :destroy]

  # POST /b/:url_fragment
  def post
    @post = Post.new(post_params)
    @post.board = @board

    respond_to do |format|
      if @post.save
        format.html { redirect_to :action => 'show',
                                  :url_fragment => @board.url_fragment }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /b/:url_fragment/moderate
  def moderate_form
  end

  # POST /b/:url_fragment/moderate
  def moderate
    if @board.authenticate(params['password'])
      session['moderates'] = [] if !session.has_key?('moderates')

      if !session['moderates'].include?(@board.id)
        session['moderates'] << @board.id
      end

      redirect_to :action => 'show', :url_fragment => @board.url_fragment
    end
  end

  # GET /boards/:id/end_moderate
  def end_moderate
    session['moderates'].delete(@board.id)

    redirect_to :action => 'show', :url_fragment => @board.url_fragment
  end

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.where(:is_listed => true).all
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @post = Post.new
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to :action => 'show',
                                  :url_fragment => @board.url_fragment,
                                  notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to :action => 'show',
                                  :url_fragment => @board.url_fragment,
                                  notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    def set_board_fragment
      @board = Board.where(:url_fragment => params[:url_fragment]).first
    end

    def set_is_mod
      # Determine if the user has moderation privileges on this board.
      begin
        @is_mod = session['moderates'].include?(@board.id)
      rescue
        @is_mod = false
      end
    end

    def require_mod_access
      throw "Enter a mod password first." if !@is_mod
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:url_fragment, :password, :is_listed,
                                    :password_confirmation, :description)
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
