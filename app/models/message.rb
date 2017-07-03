class Message < ApplicationRecord
  belongs_to :restaurant

  enum message_type: [ :text_ready,:marketing]

end
