class OwnersController < ApplicationController
  def index
    @owners = Owner.all.sort_by{|onr| onr.first_name }
  end

  def show
    @onr = nil
    @onr = Owner.find(params[:id])
    return @onr if @onr
  end

  def update
    @owner = Owner.find_by(id: params[:id])
    if @owner.update(owner_params)
      # redirect_to owners_path, success: "Owner with name #{params[:owner][:first_name]} #{params[:owner][:last_name]} was updated successfully"
    else
      flash[:error] = "Owner with name #{params[:owner][:first_name]} #{params[:owner][:last_name]} was not created successfully"
      # render 'edit'
    end
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to owners_path, success: "Owner with name #{params[:owner][:first_name]} #{params[:owner][:last_name]} was created successfully"
    else
      redirect_to owners_path, success: "Owner with name #{params[:owner][:first_neme]} #{params[:owner][:last_name]} was not created successfully"
    end
  end

  def edit
    @owner = Owner.find_by(name: params[:name])
  end

  def destroy
    p = params[:id]
    message = nil
    success_message = ""
    error_message = ''
    @onr = Owner.find(r)
    if @onr && @onr.persisted? && p
      #destroy all my cats
      @onr.cats.each do |cat|
        cat.destroy
      end
      if @onr.destroy
        success_message = "owner destroyed"
        flash[:success] = success_message
        redirect_to owners_path
      end
    else
      error_message = "owner not destroyed because something happened with #{params[:id]}"
      flash[:error] = error_message
      # redirect_to owners_path
    end
  end

  # this method takes in an owner and sets its first cats age to 23
  def some_method_that_does_something(owner)
    cats = owner.cats
    cat = owner.cats.first
    cat.age = 22
    cat.save
  end

  def create_a_cat(owner, cat_name, a, cat_fur_color, ec, food_type)
    cat = Cat.new(name: cat_name, age: a, fur_color: cat_fur_color, eye_color: ec, food_type: food_type)
    if cat && cat.valid?
      owner.cats << cat
    else
      puts "cat not valid"
    end
  end

  private
    def owner_params
      if params[:owner]
        params.require(:owner).permit(:first_name, :last_name, :age, :race, :location)
      end
    end
end
