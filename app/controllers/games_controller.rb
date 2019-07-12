class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :create_invites, :destroy]

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
    @game.build_game_setting
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.user = current_user

    @game.game_players.build( players_for_new_game )
    @game.game_players.build( user_id: current_user.id, pending: false, confirmed: true )

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_invites
    @game.game_players.build( players_for_new_game )

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Players sucessfully invited' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { redirect_to @game, notice: 'Unable to invite players' }
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
      params.require(:game).permit(
        :name,
        :user_id,
        :started_at,
        :ended_at,
        :game_players => [],
        :game_setting_attributes => [ :turn_length, :weekend_skip, :allow_illegal_moves ]
      )
    end

    def players_for_new_game
      users = User
        .all_except( current_user.id )
        .where( username: params[ :invites ] )
        .or( User.where( email: params[ :invites ] ) )

      users.map do |user|
        { pending: true, user_id: user.id  }
      end
    end
end
