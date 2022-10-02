require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'db schema' do
    it 'columns' do
      User.attribute_names.each do |attribute_name|
        STRING = User.columns.select { |c| c.type == :string }.map(&:name)
        INTEGER = User.columns.select { |c| c.type == :integer }.map(&:name)
        BOOLEAN = User.columns.select { |c| c.type == :boolean }.map(&:name)
        DATE = User.columns.select { |c| c.type == :datetime }.map(&:name)
        TEXT = User.columns.select { |c| c.type == :text }.map(&:name)

        # Expect string type
        expect(STRING.count).to eql(25)
        expect(User.type_for_attribute(attribute_name).type).to eql(:string) if STRING.include?(attribute_name)

        # Expect integer type
        expect(INTEGER.count).to eql(2)
        expect(User.type_for_attribute(attribute_name).type).to eql(:integer) if INTEGER.include?(attribute_name)

        # Expect boolean type
        expect(BOOLEAN.count).to eql(3)
        expect(User.type_for_attribute(attribute_name).type).to eql(:boolean) if BOOLEAN.include?(attribute_name)

        # Expect datetime type
        expect(DATE.count).to eql(5)
        expect(User.type_for_attribute(attribute_name).type).to eql(:datetime) if DATE.include?(attribute_name)

        # Expect datetime type
        expect(TEXT.count).to eql(1)
        expect(User.type_for_attribute(attribute_name).type).to eql(:text) if TEXT.include?(attribute_name)
      end
    end
  end
  describe 'associations' do
    it { should have_many(:jobs).dependent(:destroy) }
  end
end
