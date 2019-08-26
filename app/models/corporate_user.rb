class CorporateUser < User
  has_one :corporate_information, foreign_key: :user_id
end
