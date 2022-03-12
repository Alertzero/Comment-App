# frozen_string_literal: true

class Inbox < ApplicationRecord
  belongs_to :user, class_name: "user", foreign_key: "user_id"
  validates :name, presence: true
  validates :name, uniqueness: true
end
