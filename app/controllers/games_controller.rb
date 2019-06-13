class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.user = current_user
    @game.save

    @game.game_provinces.create( provinces_for_new_game )
    @game.game_players.create( players_for_new_game )
    @game.game_players.create( user_id: current_user.id, game_id: @game.id, pending: false, confirmed: true )

    respond_to do |format|
      if @game.id
        @provinces = Province.all
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :user_id, :started_at, :ended_at, :game_players => [])
    end

    def provinces_for_new_game
      Province.all.map do |province|
        { province_code: province.province_code, game_id: @game.id, owner: province.home_of }
      end
    end

    def players_for_new_game
      users = User
        .all_except( current_user.id )
        .where( username: params[ :invites ] )
        .or( User.where( email: params[ :invites ] ) )

      users.map do |user|
        { game_id: @game.id, pending: true, user_id: user.id  }
      end
    end
end
