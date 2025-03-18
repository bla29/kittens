class KittensController < ApplicationController
  before_action :set_kitten, only: [:show, :edit, :update, :destroy]

  def index
    @kittens = Kitten.all

    if @kittens
      render json: @kittens  # Explicitly render as JSON
    else
      render json: { error: "User not found" }, status: 404
    end
  end
  
  # 2. Show a single user
  def show
    @kitten = Kitten.find(params[:id])

    if @kitten
      render json: @kitten  # Explicitly render as JSON
    else
      render json: { error: "User not found" }, status: 404
    end

  end

  # 3. Form to create a new user
  def new
    @kitten = Kitten.new
  end

  # 4. Create a new user in the database
  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to @kitten, notice: 'Kitten was successfully created.'
    else
      render :new  # Render the new page if the kitten creation fails
    end
  end

  # 5. Form to edit an existing user
  def edit
    # @kitten is set by the before_action
  end

  # 6. Update an existing user
  def update
    if @kitten.update(kitten_params)
      redirect_to @kitten, notice: 'Kitten was successfully updated.'
    else
      render :edit  # Render the edit page if update fails
    end
  end

  # 7. Delete a user
  def destroy
    @kitten.destroy
    redirect_to kittens_url, notice: 'Kitten was successfully deleted.'
  end
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kitten
    @kitten = Kitten.find(params[:id])  # Find kitten by ID
  end

  # Only allow a list of trusted parameters through.
  def kitten_params
    params.require(:kitten).permit(:name, :age, :color, :breed)  # Adjust the permitted parameters as needed
  end

end
