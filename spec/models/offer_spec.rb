require 'rails_helper'

RSpec.describe Offer, type: :model do
  subject { build(:offer) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :security_token }

  it { should have_many :offer_products }
  it { should belong_to :client }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
