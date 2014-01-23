module RatingAverage
  def average_rating
    sum = 0
    if ratings.empty?
      return 0
    end
    ratings.each do |r|
        sum += r.score 
    end
    return sum.to_f/ratings.count
  end
  def pri
    "ivanivanivan"
  end  
end