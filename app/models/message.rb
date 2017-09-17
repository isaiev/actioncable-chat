# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  user_id      :integer          indexed
#  chat_room_id :integer          indexed
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_messages_on_chat_room_id  (chat_room_id)
#  index_messages_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_room_id => chat_rooms.id)
#  fk_rails_...  (user_id => users.id)
#

class Message < ApplicationRecord

  belongs_to :user
  belongs_to :chat_room

  after_create_commit :broadcast_message

  validates :body, presence: true, length: { minimum: 2, maximum: 500 }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

  private

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end

end
