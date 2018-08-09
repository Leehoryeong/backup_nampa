class UserSpecsController < ApplicationController
  before_action :set_user_spec, only: [:show, :edit, :update, :destroy]

  # GET /user_specs
  # GET /user_specs.json
  def index
    @user_specs = UserSpec.all
  end

  # GET /user_specs/1
  # GET /user_specs/1.json
  def show
  end

  # GET /user_specs/new
  def new
    @user_spec = current_user.user_specs.build
  end

  # GET /user_specs/1/edit
  def edit
  end

  # POST /user_specs
  # POST /user_specs.json
  def create
    @user_spec = current_user.user_specs.build(user_spec_params)

    respond_to do |format|
      if @user_spec.save
        format.html { redirect_to @user_spec, notice: 'User spec was successfully created.' }
        format.json { render :show, status: :created, location: @user_spec }
      else
        format.html { render :new }
        format.json { render json: @user_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_specs/1
  # PATCH/PUT /user_specs/1.json
  def update
    respond_to do |format|
      if @user_spec.update(user_spec_params)
        format.html { redirect_to @user_spec, notice: 'User spec was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_spec }
      else
        format.html { render :edit }
        format.json { render json: @user_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_specs/1
  # DELETE /user_specs/1.json
  def destroy
    @user_spec.destroy
    respond_to do |format|
      format.html { redirect_to user_specs_url, notice: 'User spec was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_spec
      @user_spec = UserSpec.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_spec_params
      params.require(:user_spec).permit(:skintype, :age, :atopy, :pimple, :allergy, :bb, :lip, :eyebrow, :eyeline, :color, :skincolor)
    end
end
