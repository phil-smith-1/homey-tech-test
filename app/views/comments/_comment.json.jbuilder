json.extract! comment, :id, :user_id, :text, :project_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
