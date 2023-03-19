class RemoveThumbAndCarouselPathsFromProduct < ActiveRecord::Migration[7.0]
  def change
    remove_columns :products, :thumb_path, :carousel_paths
  end
end
