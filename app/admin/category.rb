ActiveAdmin.register ActsAsTaggableOn::Tag, as: 'Category' do
  permit_params :name
end
