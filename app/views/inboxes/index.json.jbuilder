# frozen_string_literal: true

json.array! @inboxes, partial: 'inboxes/inbox', as: :inbox
