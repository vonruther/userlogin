class Post < ApplicationRecord
	# relationships
	belongs_to :user
	has_many :comments
	has_many :members

	#Named scopes
	#Public posts
	scope :display_public, -> { where(display_public: true) }

	def self.search(search)
		if search
			key = "%#{search}%"
			columns = %w{title body}
			@posts = Post.where(
				columns
				.map {|c| "#{c} like :search" }
				.join(' OR '),
				search: key
			)
		else
			Post.all
		end
	end
end
