FactoryBot.define do
  factory :wallet do
    name { "MyString" }
    public { false }
    transactions { "" }
    dividends { "" }
  end
end
