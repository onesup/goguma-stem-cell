ActiveAdmin.register User do
  columns = [:role, :name, :email, :provider, :uid, :created_at, :updated_at, :last_sign_in_at]
  permit_params :role

  scope :member
  scope :guest

  index do
    selectable_column
    id_column
    columns.each { |i| send("column", i) }
    actions
  end
end
