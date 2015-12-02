json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :uid, :provider
  json.url user_url(user, format: :json)
end
