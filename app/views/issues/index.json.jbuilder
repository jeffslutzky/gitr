json.array!(@issues) do |issue|
  json.extract! issue, :id, :title, :body, :milestone_id, :created_at, :closed_at
  json.url issue_url(issue, format: :json)
end
