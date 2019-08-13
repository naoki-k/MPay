FactoryBot.define do
  factory :bank do
    initialize_with do
      Bank.find_or_initialize_by(
        code: "MHCBJPJT",
        name: "みずほ銀行")
    end
  end
end
