class ManualsController < ApplicationController
  before_action :set_manual, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # @manuals = Manual.all

    @us= Userspec.find_by_user_id(current_user.id)#현재 유저의 userspec
    @manuals = Manual.all#manual 전체를 받는 변수
    manualCount = Manual.all.count # 메뉴얼이 총 몇개인지 알려주는 변수
    @manualArray = Array.new(manualCount){Array.new(2)}#[id번호][공통갯수]2차원 배열 형성
    @manualNumber = 0 # 몇번째 메뉴얼인지 들어갈 곳을 알려주는 인덱스
    @insertNumber = 0 # 얼만큼 동일한 스펙을 가졌는지 들어갈 곳을 알려주는 인덱스

    @manuals.each do |manual|
      @value = 1 #실제 얼만큼 동일 스펙을 가졌는지 넣는 값
      @manualArray[@manualNumber][1]= manual.id

      if (@us.skintype != false) && (@us.skintype == manual.skintype)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.age!=false) && (@us.age == manual.age)
        @manualArray[@insertNumber][0]  = @value
        @value = @value +1
      end
      if (@us.atopy!=false) && (@us.atopy == manual.atopy)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.bb!=false) && (@us.bb == manual.bb)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.lip!=false) && (@us.lip == manual.lip)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.eyebrow!=false) && (@us.eyebrow == manual.eyebrow)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.eyeline!=false) && (@us.eyeline == manual.eyeline)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.color!=false) && (@us.color == manual.color)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.skincolor!=false) && (@us.skincolor == manual.skincolor)
        @manualArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@manualArray[@insertNumber][0] == nil)
        @manualArray[@insertNumber][0] = 0
      end
      
      @manualNumber += 1
      @insertNumber += 1
    end

    @manualArray = @manualArray.sort.reverse
    manuals = []
    for i in 0..(@manualArray.length-1)
      manuals << Manual.find_by_id(@manualArray[i][1])
    end
    @manuals = manuals

    
  end

  def show

  end

  def new
    @manual = current_user.manuals.build
  end

  def edit
  end

  def create
    @manual = current_user.manuals.build(manual_params)

    respond_to do |format|
      if @manual.save
        format.html { redirect_to @manual, notice: 'Manual was successfully created.' }
        format.json { render :show, status: :created, location: @manual }
      else
        format.html { render :new }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manual.update(manual_params)
        format.html { redirect_to @manual, notice: 'Manual was successfully updated.' }
        format.json { render :show, status: :ok, location: @manual }
      else
        format.html { render :edit }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @manual.destroy
    respond_to do |format|
      format.html { redirect_to manuals_url, notice: 'Manual was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_manual
      @manual = Manual.find(params[:id])
    end

    def manual_params
      params.require(:manual).permit(:category, :title, :content, :skintype, :age, :atopy, :pimple, :allergy, :bb, :lip, :eyebrow, :eyeline, :color, :skincolor)
    end
end
