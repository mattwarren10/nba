class AddWikiLinkImageLinkFromCityToStaticPlayer < ActiveRecord::Migration[5.1]
  def change
  	add_column :static_players, :wiki_link, :string
  	add_column :static_players, :image_link, :string
  	add_column :static_players, :from_city, :string
  end
end
