class ShoppingController < ApplicationController
  def index
    # Except => params[:ranking, :action]
    if params.length > 2
      # 사용자로부터 params 값 받아오기
      get_user_params
    else
      # params값이 없으면 모든 제품 받아오기
      @products = Product.all.order('created_at DESC')
    end

    # 제품 필터링하기 <= 받아온 params 값을 이용해서..
    get_filtered_products
  end
  def get_filtered_products
    @products = Product.all
    if (@data != nil) && (@products != nil)
      # 제품아이디와 params와의 관련도 저장 => 2차원 배열
      @products_data = Array.new(@products.length){Array.new(2)}
      index = 0

      # 제품 필터링
      @products.each do |product|
        @products_data[index][1] = product.id
        @products_data[index][0] = 0

        # 각 Product마다 params값 비교 / params => @data
        @data.each do |data|
          i = data[0]
          # 0~5 => Ages, 6~10 => SkinTypes, 11~13 => Specials, 14~18 => Cosmestics
          if i <= 5
            if product.age == data[1]
              @products_data[index][0] += 1
            end
          elsif i <= 10
            if product.skintype == data[1]
              @products_data[index][0] += 1
            end
          else
            if product[data[1]] == true
              @products_data[index][0] += 1
            end
          end
        end
        index += 1
      end

      # 제품 정렬 & 관련도 0인 제품 걸러내기
      @products_data = @products_data.sort.reverse
      products = []
      @products_data.each do |p|
        if p[0] != 0
          products << Product.find_by_id(p[1])
        end
      end
      @products = products
    end
  end

  def get_user_params
    @data = Array.new(params.length-2){Array.new(2)}
    @values = ['10대후반', '20대초반', '20대후반', '30대초반', '30대후반', '40대이상',
              '건성', '지성', '복합성', '중성', '민감성',
              'atopy', 'pimple', 'allergy',
              'bb', 'lip', 'eyebrow', 'eyeline', 'color']
    count = 0
    for i in 0..18
      if params[i.to_s] == @values[i]
        @data[count][0] = i
        @data[count][1] = params[i.to_s]
        count += 1
      end
    end
  end
end
