class AddEmbedUrlToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :embed_url, :string
  end
end
