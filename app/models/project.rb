class Project < ActiveRecord::Base
	belongs_to :owner, class_name: 'User'
	has_many :rewards
	has_many :comments
	# has_many :pledges, through: :rewards
	has_many :pledges

	accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true
	acts_as_taggable

	def pretty_start_date
		start_date.strftime("%b %d, %Y")
	end

	def pretty_end_date
		end_date.strftime("%b %d, %Y")
	end

	def amount_raised
		pledges.sum(:contribution)
	end

	def days_left
		end_date.day - DateTime.now.day
	end

	# def is_current_user_backer?
	# 	pledges.include?(pledges.where(backer_id: current_user.id).first)
	# end
end
