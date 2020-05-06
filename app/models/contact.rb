# frozen_string_literal: true

class Contact < ApplicationRecord
  enum gender: { male: "male", female: "female", other: "other" }
  enum status: { red: "red", green: "green" }
  belongs_to :panchayat, optional: :true
  belongs_to :user
  belongs_to :application

  has_many :contact_symptoms
  has_many :symptoms, through: :contact_symptoms

  def is_vulnerable
    has_diabetes || has_hyper_tension || has_heart_disease || has_heart_disease || has_kidney_disease || primary_contact || has_tested || was_positive
  end

  def is_red_flagged
    status == 'red' || symptoms.any?
  end
end
