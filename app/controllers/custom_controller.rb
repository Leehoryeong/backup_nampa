class CustomController < ApplicationController
  before_action :authenticate_user!

  def info
    if current_user.userspec
      @userspec = current_user.userspec
      redirect_to '/custom'
    end
  end

  def index
    if current_user.userspec
      ######################### 맞춤제품 알고리즘 #########################
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
        if (@us.eyebrow!=false) && (@us.eyebrow == product.eyebrow)
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
      ######################### 맞춤제품 알고리즘 end #########################
    elsif
      @products = Product.all
    end
  end

  def category
    @p = params[:category]
  end
end
