require 'rails_helper'

RSpec.describe MailerBox, type: :model do
  subject { build(:offer_product, :mailer_box ) }

  it { should validate_presence_of :width }
  it { should validate_numericality_of(:width)
                .is_greater_than(0)
                .less_than_or_equal_to(200) }

  it { should validate_presence_of :height }
  it { should validate_numericality_of(:height)
                .is_greater_than(0)
                .less_than_or_equal_to(200) }

  it { should validate_presence_of :length }
  it { should validate_numericality_of(:length)
                .is_greater_than(0)
                .less_than_or_equal_to(200) }

  it { should validate_presence_of :quantity }
  it { should validate_numericality_of(:quantity)
                .is_greater_than_or_equal_to(200)
                .less_than_or_equal_to(1000) }


  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it "can calculate the price" do
    product = described_class.new(width: 100, height: 100, length: 50, quantity: 300)
    expect(described_class.calculate_price(product)).to eq(7_500)
  end
end
