class UserspecsController < ApplicationController
  before_action :set_userspec, only: [:show, :edit, :update, :destroy]

  # GET /userspecs
  # GET /userspecs.json
  def index
    @userspecs = Userspec.all
  end

  # GET /userspecs/1
  # GET /userspecs/1.json
  def show
  end

  # GET /userspecs/new
  def new
    @userspec = Userspec.new
  end

  # GET /userspecs/1/edit
  def edit

  end

  # POST /userspecs
  # POST /userspecs.json
  def create

    @userspec = Userspec.new(userspec_params)
    @userspec.user_id = current_user.id

    respond_to do |format|
      if @userspec.save
        format.html { redirect_to @userspec, notice: 'Userspec was successfully created.' }
        format.json { render :show, status: :created, location: @userspec }
      else
        format.html { render :new }
        format.json { render json: @userspec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userspecs/1
  # PATCH/PUT /userspecs/1.json
  def update
    respond_to do |format|
      if @userspec.update(userspec_params)
        format.html { redirect_to @userspec, notice: 'Userspec was successfully updated.' }
        format.json { render :show, status: :ok, location: @userspec }
      else
        format.html { render :edit }
        format.json { render json: @userspec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userspecs/1
  # DELETE /userspecs/1.json
  def destroy
    @userspec.destroy
    respond_to do |format|
      format.html { redirect_to userspecs_url, notice: 'Userspec was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userspec
      if !current_user.userspec
        redirect_to new_userspec_path
      elsif
        @userspec = Userspec.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userspec_params
      params.require(:userspec).permit(:skintype, :age, :atopy, :pimple, :allergy, :bb, :lip, :eyebrow, :eyeline, :color, :skincolor)
    end
end
