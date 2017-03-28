json.extract! upload_report, :id, :created_at, :updated_at
json.url upload_report_url(upload_report, format: :json)