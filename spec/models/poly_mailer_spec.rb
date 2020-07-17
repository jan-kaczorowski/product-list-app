require 'rails_helper'

RSpec.describe PolyMailer, type: :model do
  subject { build(:offer_product, :poly_mailer ) }

  it { should validate_presence_of :width }
  it { should validate_numericality_of(:width)
                .is_greater_than(0)
                .less_than_or_equal_to(200) }

  it { should validate_presence_of :height }
  it { should validate_numericality_of(:height)
                .is_greater_than(0)
                .less_than_or_equal_to(200) }

  it { should validate_presence_of :quantity }
  it { should validate_numericality_of(:quantity)
                .is_greater_than_or_equal_to(50)
                .less_than_or_equal_to(2000) }

  it { should validate_presence_of :material }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it "can calculate the price" do
    product = described_class.new(width: 100, height: 100, material: "transparent", quantity: 300)
    expect(described_class.calculate_price(product)).to eq(15_000)
  end
end


