require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:tag) }

  it { should validate_presence_of :title }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it { should have_many :taggables }
  it { should have_many :taggings }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
