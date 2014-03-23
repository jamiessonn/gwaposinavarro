json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :category, :due_date, :is_completed
  json.url task_url(task, format: :json)
end
