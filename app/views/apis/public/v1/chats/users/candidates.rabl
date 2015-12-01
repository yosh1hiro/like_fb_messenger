object false
child(@candidate_users, root: :users, object_root: false) do
  collection @candidate_users
  attributes :id, :last_name, :first_name, :name, :image
end
node(:page){ @page }
node(:next_page){ @next_page }
node(:end_flag){ @end_flag }
