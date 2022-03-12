# frozen_string_literal: true

json.extract! inbox, :id, :name, :created_at, :updated_at
json.url inbox_url(inbox, format: :json)
