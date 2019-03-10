json.extract! upload, :id, :user_id, :info, :course, :activity, :iframe, :description, :created_at, :updated_at
json.url upload_url(upload, format: :json)
