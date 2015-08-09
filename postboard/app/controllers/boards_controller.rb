class BoardsController < ApplicationController
  before_action :set_board
  # TODO: Remove this. Github issue #1
  before_action :set_board_from_id, only: [:update]
  before_action :set_is_mod, only: [:show, :edit, :update, :destroy]
  before_action :require_mod_access, only: [:edit, :update, :destroy]

  def index
    @boards = Board.where(:is_listed => true).all
  end

  def show
    @post = Post.new
  end

  def new
    @board = Board.new
  end

  def edit
  end

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

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def moderate_form
  end

  def moderate
    if @board.authenticate(params['password'])
      session['moderates'] = [] if !session.has_key?('moderates')

      if !session['moderates'].include?(@board.id)
        session['moderates'] << @board.id
      end

      redirect_to :action => 'show', :url_fragment => @board.url_fragment
    end
  end

  def end_moderate
    session['moderates'].delete(@board.id)

    redirect_to :action => 'show', :url_fragment => @board.url_fragment
  end

  private
    def board_params
      params.require(:board).permit(:url_fragment, :password, :is_listed,
                                    :password_confirmation, :description)
    end

    # TODO: Remove this. Github issue #1
    def set_board_from_id
      @board = Board.find(params[:id])
    end

end
