json.message "Signed in successfully."
json.user do
  json.extract! resource, :id, :email, :name, :created_at, :updated_at
end
