# frozen_string_literal: true

class Inbox < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: true
end
