class Mystery < ApplicationRecord
  has_one_attached :question_image
  has_one_attached :answer_image
  
  has_many :comments,dependent: :destroy
end
