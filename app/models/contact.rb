# frozen_string_literal: true

class Contact < ApplicationRecord
  enum gender: { male: "male", female: "female", other: "other" }
  belongs_to :panchayat, optional: :true
  belongs_to :user
  belongs_to :application

  def is_vulnerable
    has_diabetes || has_hyper_tension || has_heart_disease || has_heart_disease || has_kidney_disease || primary_contact || has_tested || was_positive
  end
end
