# frozen_string_literal: true

class Port < ApplicationRecord
  has_many :applications
end
