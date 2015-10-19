module RatesHelper
  def ratings_to_stars(rates)
    raw rates.map { |r| link_to (raw visualize_stars(r.stars)), rate_path(id: r.id), class: 'text-muted'}.join(' ')
  end

  def visualize_stars(num_stars)
    print_stars = ""
    case num_stars
      when "five"
        5.times do 
          print_stars += "<i class='fa fa-star'></i>"
        end
      when "four"
        4.times do 
          print_stars += "<i class='fa fa-star'></i>"
        end
        1.times do 
          print_stars += "<i class='fa fa-star-o'></i>"
        end
      when "three"
        3.times do 
          print_stars += "<i class='fa fa-star'></i>"
        end
        2.times do 
          print_stars += "<i class='fa fa-star-o'></i>"
        end        
      when "two"
        2.times do 
          print_stars += "<i class='fa fa-star'></i>"
        end
        3.times do 
          print_stars += "<i class='fa fa-star-o'></i>"
        end        
      when "one"
        1.times do 
          print_stars += "<i class='fa fa-star'></i>"
        end
        4.times do 
          print_stars += "<i class='fa fa-star-o'></i>"
        end        
      else
        5.times do 
          print_stars += "<i class='fa fa-star-o'></i>"
        end        
    end
    print_stars
  end
end