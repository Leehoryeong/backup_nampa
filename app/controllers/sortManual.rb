module SortManual
  def SortManual.sorting
    @us= Userspec.find(current_user.id)
    @manuals = Manual.all
    @manualArray = Array.new(Manual.all.count){Array.new(2)}
    keys = ['skintype', 'age', 'atopy', 'pimple', 'allergy', 'bb', 'lip', 'eyebrow', 'eyeline', 'color', 'skincolor']
    arrayIndex = 0

    # 매뉴얼스펙과 유저스펙 비교
    @manuals.each do |manual|
      @manualArray[arrayIndex][1] = manual.id
      @manualArray[arrayIndex][0] = 0

      for i in 0..10
        if @us[keys[i]]
          if @us[keys[i]] == manual[keys[i]]
            @manualArray[arrayIndex][0] += 1
          end
        end
      end
      arrayIndex += 1
    end
    @manualArray = @manualArray.sort.reverse

    # @manuals 재배열
    @manuals = []
    for i in 0..(@manualArray.length-1)
      @manuals << Manual.find(@manualArray[i][1])
    end
  end
end
