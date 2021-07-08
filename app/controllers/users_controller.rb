class UsersController < ApplicationController
  skip_before_action :authorized, only: [:index,:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if user_params[:password] != user_params[:password_confirmation]
      render json: {
        status: 422,
        errors: "Password and Password confirmation didn't match"
      }, status: :unprocessable_entity
    elsif @user.save
      @token = encode_token(user_id: @user.id)
      render json: {
        status: 201,
        user: @user,
        jwt: @token
      }, status: :created, location: @user
    else
      render json: {
        status: 422,
        errors: @user.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
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

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end
