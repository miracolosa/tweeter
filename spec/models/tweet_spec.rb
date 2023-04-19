require 'rails_helper'

RSpec.describe Tweet, type: :model do
  user = User.create(email: "test@gmail.com", password: "topsecret", password_confirmation: "topsecret")
  subject do
    described_class.new(body: "This is a tweet", user:)
  end

  describe "validations" do
    describe 'body' do
      it 'must be present' do
        subject.body = nil
        expect(subject).to_not be_valid
      end

      it "mustn't have more than 140 characters" do
        subject.body = "This is a very long string of characters that at some point will reach more
          than 140 characters and should then not be valid as a tweet if the validations are correct."
        expect(subject).to_not be_valid
      end
    end

    describe 'user' do
      it 'must be attached' do
        subject.user = nil
        expect { subject.save! }.to raise_error("Validation failed: User must exist")
      end
    end
  end
end
