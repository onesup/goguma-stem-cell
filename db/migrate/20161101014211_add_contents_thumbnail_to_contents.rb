class AddContentsThumbnailToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :contents_thumbnail, :string
  end
end
