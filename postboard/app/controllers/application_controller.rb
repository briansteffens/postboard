class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def set_board
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

end
