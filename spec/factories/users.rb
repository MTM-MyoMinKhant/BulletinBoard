FactoryBot.define do
  factory :user , aliases:[:create_user_id]  do
    name {"testing4"}
    email {"testing4@gmail.com"}
    password {"1234qwer"}
    role {0}
    phone {1234567}
    address {"Kan Daw Lay"}
    dob {"1999-09-09"}
    create_user_id {1}
    updated_user_id {1}
  end

  factory :post do
    association :create_user_id, factory: :user
    title {"Rspec"}
    description {"rspec@gmail.com"}
    status {1}
    updated_user_id {3}
  end
end
