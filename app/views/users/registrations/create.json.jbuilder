json.message "Signed up successfully."
json.user do
  json.extract! resource, :id, :email, :name, :created_at, :updated_at
end
