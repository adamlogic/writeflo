FactoryGirl.define do

  factory :doc do
    content "# This my title\n\nThis is my content."
  end

  factory :version do
    doc
  end

  factory :review do
    version
    content "# This a new title\n\nThis is my updated content."
  end

end
