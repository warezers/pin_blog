class PinsController < ApplicationController
  before_action :find_pin, only: [:edit, :show, :update, :destroy, :upvote]
  def index
  	@pins = Pin.all.order("created_at DESC")
  end

  def new
  	@pin = current_user.pins.build
  end

  def create
  	@pin = current_user.pins.build(pin_params)
  	if @pin.save
  		redirect_to @pin, notice: "successfully created"
  	else
  		render 'new'
  	end
  end

  def show
  end

  def edit
  end

  def update
  	if @pin.update(pin_params)
  	   redirect_to @pin, notice: "successfully updated"
  	else
  		render 'edit'
  	end
  end
  
  def upvote
    @pin.upvote_by current_user
    redirect_back fallback_location: root_path
  end
  
  def destroy
  	@pin.destroy
  	redirect_to root_path
  end

  private

  def pin_params
  	params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
  	@pin = Pin.find(params[:id])
  end
end
