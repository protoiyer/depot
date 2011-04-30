i = 0
Order.all.each do |order| 
  order.name = "Customer #{i}"
  i += 1
  order.save!
end
