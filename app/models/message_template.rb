class MessageTemplate < ApplicationRecord
  belongs_to :restaurant
  validates :name,:template,presence: true
  default_scope { order(sort_order: :asc) }
  
  after_create :set_sort_order


  private
    def set_sort_order
      order = restaurant.message_templates.count
      self.update(sort_order: order)
    end
end
