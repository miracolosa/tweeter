require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe "validations" do
    describe 'body' do
      it 'must be present' do
        tweet = described_class.new
        expect(tweet).to_not be_valid
      end

      it "mustn't have more than 140 characters" do
        tweet = described_class.new(body: "This is a very long string of characters that at some point will reach more
          than 140 characters and should then not be valid as a tweet if the validations are correct.")
        expect(tweet).to_not be_valid
      end
    end

    describe 'user' do
      it 'must be attached' do
        tweet = described_class.new(body: "This is a tweet")
        expect { tweet.save! }.to raise_error("Validation failed: User must exist")
      end
    end
  end

end
