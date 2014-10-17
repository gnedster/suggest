class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.order(sort_column + " desc")

    if params[:tag]
      @suggestions = @suggestions.tagged_with(params[:tag])
    end

    @suggestions
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
  end

  # GET /suggestions/1/edit
  def edit
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(suggestion_params)

    respond_to do |format|
      if @suggestion.save
        cookies[@suggestion.id] = "true"
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /suggestions/1/endorse.json
  def endorse
    @suggestion = Suggestion.find(params[:id]);
    @suggestion.score += 1

    respond_to do |format|
      if @suggestion.save
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end

    end
  end

  # # DELETE /suggestions/1
  # # DELETE /suggestions/1.json
  # def destroy
  #   @suggestion.destroy
  #   respond_to do |format|
  #     format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      params.require(:suggestion).permit(:suggestion_id, :name, :description, :tag_list)
    end

    def sort_column
      Suggestion.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
    end
end
