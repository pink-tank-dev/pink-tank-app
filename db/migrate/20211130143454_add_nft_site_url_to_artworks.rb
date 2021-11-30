class AddNftSiteUrlToArtworks < ActiveRecord::Migration[6.1]
  def change
    add_column :artworks, :nft_site_url, :string
  end
end
