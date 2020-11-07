class Api::UsersController < ApplicationController

  # GET api/users
  def index
    @users = User.all
    render json: @users.present? ? @users : 'No Users Found !'
  end

  # GET api/users/:id
  def show
    begin
      @user = User.find_by(_id: params[:id])

      raise "User Not Found With ID: #{params[:id]}" unless @user.present?

      render json: @user
    rescue StandardError => e
      render json: { error: e.message.to_json }
    end
  end

  # POST api/users
  def create
    begin
      @user = User.new(json_params)
      @user.save!
      render json: @user
    rescue StandardError => e
      render json: { error: e.message.to_json }
    end
  end

  # PUT api/users/:id
  def update
    begin
      @user = User.find_by(_id: params[:id])
      raise "User Not Found With ID: #{params[:id]}" unless @user.present?

      @user.update!(json_params)
      render json: @user
    rescue StandardError => e
      render json: { error: e.message.to_json }
    end
  end

  # DELETE api/users/:id
  def destroy
    begin
      @user = User.find_by(_id: params[:id])
      raise "User Not Found With ID: #{params[:id]}" unless @user.present?

      @user.destroy!
      render json: 'User Deleted Successfully !'
    rescue StandardError => e
      render json: { error: e.message.to_json }
    end
  end

  # GET api/typeahead/:input
  def typeahead
    search_options = params[:input].to_s.strip.downcase

    #TO-DO
    # @users = User.where("(LOWER(email) like :search_options OR LOWER(first_name) like :search_options OR LOWER(last_name) like :search_options)", search_options: search_options)

    render json: @users.present? ? @users : 'No Users Found !'
  end

  private

  def json_params
    JSON.parse(request.body.read)
  end
end
