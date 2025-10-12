class TomatoesController < ApplicationController
  before_action :set_tomato, only: %i[ show edit update destroy ]

  # GET /tomatoes or /tomatoes.json
  def index
    @tomatoes = Tomato.all
  end

  # GET /tomatoes/1 or /tomatoes/1.json
  def show
  end

  # GET /tomatoes/new
  def new
    @tomato = Tomato.new
  end

  # GET /tomatoes/1/edit
  def edit
  end

  # POST /tomatoes or /tomatoes.json
  def create
    @tomato = Tomato.new(tomato_params)

    respond_to do |format|
      if @tomato.save
        flash[:just_created] = true
        format.html { redirect_to @tomato, notice: "Tomato was successfully created." }
        format.json { render :show, status: :created, location: @tomato }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tomato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tomatoes/1 or /tomatoes/1.json
  def update
    respond_to do |format|
      if @tomato.update(tomato_params)
        format.html { redirect_to @tomato, notice: "Tomato was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tomato }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tomato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tomatoes/1 or /tomatoes/1.json
  def destroy
    @tomato.destroy!

    respond_to do |format|
      format.html { redirect_to tomatoes_path, notice: "Tomato was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tomato
      @tomato = Tomato.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tomato_params
      params.expect(tomato: [ :note ])
    end
end
