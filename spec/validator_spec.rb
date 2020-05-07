require 'spec_helper'

RSpec.describe "CipValidator::Validator"  do
  let(:status) { 'Final' }
  let(:category) { 'Core' }
  let(:type) { 'Standards Track' }

  let(:cip){
    {
      cip: 1,
      title: 'Test CVM',
      author: 'Raisty',
      type: type,
      category: category,
      status:   status,
      created: '2020-01-01'
    }
  }
  subject(:validator){ CipValidator::Validator.new(cip)}

  describe "valid" do
    it "should have required fields" do
      expect(validator.valid?).to eq true
    end
  end

  describe "missing fields" do
    it "raise error if required fields are missing" do
      expect(CipValidator::Validator.new().valid?).to eq false
    end
  end

  describe "wrong status" do
    let(:status) { 'Foo'}
    it "raise error if required fields are missing" do
      expect(validator.valid?).to eq false
      expect(validator.errors[:status].first).to eq 'is not included in the list'
    end
  end

  describe "type" do
    ['Standard Track'].each do |value|
      describe "category '#{value}' is not valid" do | value |
        let(:type) { value }
        it{ expect(validator.valid?).to eq false }
      end
    end

    ['Standards Track', 'Informational', 'Meta'].each do | value |
      describe "type value '#{value}'' is valid" do
        let(:type) { value }
        it{ expect(validator.valid?).to eq true }
      end
    end
  end

  describe "attribute with -" do
    it "is valid if specified" do
      CipValidator::Validator.new(cip.merge({'discussions-to':'something'}))
    end

    it "not valid if not specified" do
      expect{
        CipValidator::Validator.new(cip.merge({'how-to':'something'}))
      }.to raise_error(/unknown attribute/)
    end
  end

  describe "attribute with _" do
    it "not valid" do
      expect{
        CipValidator::Validator.new(cip.merge({'discussions_to':'something'}))
      }.to raise_error("discussions_to incude _ which is not allowed")
    end
  end

  describe "type is Standards Track" do
    let(:type) { 'Standards Track' }

    [nil, 'Something else'].each do |value|
      describe "category '#{value}' is not valid" do
        let(:category) { value }
        it{ expect(validator.valid?).to eq false }
      end
    end

    %w(Core Networking Interface ).each do |value|
      describe "category value '#{value}'' is valid" do
        let(:category) { value }
        it{ expect(validator.valid?).to eq true }
      end
    end
  end

  describe "type is not Standards Track" do
    let(:type) { 'Meta' }

    [nil, 'Something else'].each do |value|
      describe "category '#{value}' is valid" do
        let(:category) { value }
        it{ expect(validator.valid?).to eq true }
      end
    end
  end
end
