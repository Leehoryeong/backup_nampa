class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    
    @us= Userspec.find_by_user_id(current_user.id)#현재 유저의 userspec
    @products = Product.all #products 전체를 받는 변수
    productCount = Product.all.count # product가 총 몇개인지 알려주는 변수
    @productArray = Array.new(productCount){Array.new(2)}#[id번호][공통갯수]2차원 배열 형성
    @productNumber = 0 # 몇번째 메뉴얼인지 들어갈 곳을 알려주는 인덱스
    @insertNumber = 0 # 얼만큼 동일한 스펙을 가졌는지 들어갈 곳을 알려주는 인덱스

    @products.each do |product|
      @value = 1 #실제 얼만큼 동일 스펙을 가졌는지 넣는 값
      @productArray[@productNumber][1]= product.id #지금 비교하는 상품의 id 값을 2차원 배열 뒤쪽에 저장

      if (@us.skintype != false) && (@us.skintype == product.skintype)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.age!=false) && (@us.age == product.age)
        @productArray[@insertNumber][0]  = @value
        @value = @value +1
      end
      if (@us.atopy!=false) && (@us.atopy == product.atopy)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.bb!=false) && (@us.bb == product.bb)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.lip!=false) && (@us.lip == product.lip)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.eyebrow!=false) && (@us.eyebrow == prodcut.eyebrow)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.eyeline!=false) && (@us.eyeline == product.eyeline)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.color!=false) && (@us.color == product.color)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@us.skincolor!=false) && (@us.skincolor == product.skincolor)
        @productArray[@insertNumber][0] = @value
        @value = @value +1
      end
      if (@productArray[@insertNumber][0] == nil)
        @productArray[@insertNumber][0] = 0
      end
      
      @productNumber += 1
      @insertNumber += 1
    end

    @productArray = @productArray.sort.reverse # 얼마나 같은 값을 갖는지(2차원 배열의 앞부분) 을 기준으로 소팅
    products = [] # 새로운 products 배열을 생성
    for i in 0..(@productArray.length-1) # 전체 프로덕트 모델에 대한 반복분
      products << Product.find_by_id(@productArray[i][1]) #어레이에 소팅되어 저장된 순서대로 모델을 재배열
    end
    @products = products #재 배열된 모델을 출력하기 위하여 전역변수에 저장

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:category, :name, :brand, :contents, :skintype, :age, :atopy, :pimple, :allergy, :bb, :lip, :eyebrow, :eyeline, :color, :skincolor)
    end
end
