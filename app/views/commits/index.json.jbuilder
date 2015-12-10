json.array!(@commits) do |commit|
  json.extract! commit, :id
  json.url commit_url(commit, format: :json)
end
