FactoryBot.define do
  factory :wallet do
    name { 'Auto' }
  end

  factory :fail_wallet do
    name { nil }
    public { false }
  end
end
