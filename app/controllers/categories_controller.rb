class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def new
    @category=Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.to_a.join('. ')
      redirect_to new_category_path
    end
  end

  def edit
    @category=Category.find(params[:id])
  end

  def update
    @category=Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.to_a.join
      redirect_to edit_category_path
    end
  end

  def index
    @categories=Category.paginate(page: params[:page], per_page: 9)
    @categories_stats=get_categories_stats
  end

  def destroy
    @category= Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def get_categories_stats
    CategoryStatsService.new(@categories).get_categories_stats_service
  end

  def category_params
    params.require(:category).permit(:kind)
  end

end
