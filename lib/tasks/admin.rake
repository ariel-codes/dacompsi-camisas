namespace :admin do
  task :remove_empty_carts do
    Cart.open.where("created_at < ?", 1.week.ago).destroy_all
  end
end
