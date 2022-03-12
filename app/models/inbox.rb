# frozen_string_literal: true

class Inbox < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
end
