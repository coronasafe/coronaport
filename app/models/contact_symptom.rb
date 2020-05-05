class ContactSymptom < ApplicationRecord
  belongs_to :contact
  belongs_to :symptom
end
