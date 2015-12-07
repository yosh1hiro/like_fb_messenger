object false
if @users
  child(@users, root: :users, object_root: false) do
    attributes :id, :last_name, :first_name, :name, :image
  end
else
  node(:users) { [] }
end
