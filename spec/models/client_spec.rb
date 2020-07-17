require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { build(:client) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :security_token }

  it { should have_many :offers }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
