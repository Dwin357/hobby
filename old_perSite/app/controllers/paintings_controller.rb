class PaintingsController < ApplicationController
  def new
    @painting = Painting.new
  end

  def create
    @painting = Painting.new(painting_params)
    @painting.owner = current_user
    if @painting.save
      redirect_to painting_path(@painting)
    else
      render "new"
    end
  end

  def show
    @painting = Painting.find_by_id(params[:id])
  end

  def edit
    @painting = current_user.paintings.find_by_id(params[:id])
  end

  def destroy
    painting = current_user.paintings.find_by_id(params[:id])
    painting.destroy if painting
    redirect_to paintings_path
  end

  def index
    @paintings = Painting.all
  end

  private
  def painting_params
    params.require(:painting).permit(:artist_name, :description, :aquisition_date, :image, :title)
  end
end