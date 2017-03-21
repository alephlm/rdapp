class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user.to_json( :include => [:pages] )
  end

  # POST /users
  def create

    @user = User.find_by(email: user_params[:email])
    if !@user
      @user = User.new(user_params)
    end
    
    @user.pages.map(&:destroy)

    if @user.save
      params[:pages].each do |page|
        @page = Page.new(user_id: @user.id, url: page[:url], date: page[:date])
        @page.save
      end
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email)
    end
end
