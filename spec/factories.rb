FactoryGirl.define do

  factory :doc do
    content "# This my my title\n\nThis is my content."
  end

  factory :version do
    doc
  end

end
