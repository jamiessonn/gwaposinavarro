class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments
	scope :completed, -> { where is_completed: true }
	scope :incomplete, -> { where is_completed: false }
	scope :search_name, ->(name) { where ["name LIKE ?", "%#{name}%"] }
	scope :ids, ->(ids) { where id: ids }
	scope :due_today, -> { where due_date: Date.today }
	scope :owner, ->(user_id) { where user_id: user_id }
	validates :name, :due_date, :category, presence: true

end
