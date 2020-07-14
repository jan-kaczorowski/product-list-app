require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should validate_presence_of :description }

  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than(0) }

  it { should have_many :tags }
  it { should have_many :taggings }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "returns tag titles" do
    expect(subject.tag_titles).to eq(subject.tags.map(&:title).sort)
  end
end
