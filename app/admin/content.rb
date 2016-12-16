ActiveAdmin.register Content do
  columns = [:title, :price]

  form do |f|
    image_preview = -> {
      if f.object.contents_thumbnail.present?
        image_tag(f.object.contents_thumbnail.url)
      else
        content_tag(:span, "no thumbnail image yet")
      end
    }

    f.inputs "Content" do
      f.input :contents_thumbnail, as: :uploader, hint: image_preview.call(), removable: false
      columns.each { |i| f.send("input", i) }
      f.input :category_list, as: :check_boxes, multiple: :true, collection: ActsAsTaggableOn::Tag.pluck(:name)
    end

    f.actions
  end

  show do |item|
    attributes_table_for content do
      row :contents_thumbnail do
        img src: item.contents_thumbnail, height: 200
      end
      columns.each { |i| send("row", i) }
      row :category_list
    end
  end

  index do
    selectable_column
    id_column
    columns.each { |i| send("column", i) }
    column :category_list
    actions
  end
end
