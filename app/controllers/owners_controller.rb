class OwnersController < ApplicationController
  def index
    @owners = Owner.all.sort_by{:first_name}
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update(owner_params)
      flash[:success] = "Owner with name #{@owner.first_name} #{@owner.last_name} was updated successfully"
      redirect_to owners_path
    else
      flash[:error] = "Owner with name #{@owner.first_name} #{@owner.last_name} was not created successfully"
      render 'edit'
    end
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      flash[:success] = "Owner with name #{@owner.first_name} #{@owner.last_name} was created successfully"
      redirect_to owners_path
    else
      flash[:error] = "Owner with name #{@owner.first_name} #{@owner.last_name} was not created successfully"
      redirect_to owners_path
    end
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def destroy

    @owner = Owner.find(params[:id])
    if @owner.persisted? 
      @owner.cats.each do |cat|
        cat.destroy
      end
      if @owner.destroy

        flash[:success] = "Owner destroyed."
        redirect_to owners_path
      end
    else
      flash[:error] = "owner not destroyed because something happened with #{@owner.first_name}"
       redirect_to owners_path
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
