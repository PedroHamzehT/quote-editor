class Quote < ApplicationRecord
  validates :name, presence: true

  belongs_to :company

  scope :ordered, -> { order(created_at: :desc) }

  # after_create_commit { broadcast_append_to 'quotes', target: 'quotes', partial: 'quotes/quote', locals: { quote: self } }
  # after_update_commit { broadcast_replace_to 'quotes', target: self, partial: 'quotes/quote', locals: { quote: self } }
  # after_destroy_commit { broadcast_remove_to 'quotes', target: self }

  # All the code above can be replaced by the following line
  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
end
