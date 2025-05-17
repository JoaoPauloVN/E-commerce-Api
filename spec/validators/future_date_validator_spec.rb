require "rails_helper"

class Validator
    include ActiveModel::Validations
    attr_accessor :date
    validates :date, future_date: true
end

describe FutureDateValidator do
    subject { Validator.new }

    context "when the date is before the current date" do
      before { subject.date = 1.day.ago }
      
      it "is invalid" do
        expect(subject).not_to be_valid
      end

      it "adds an error to the model" do
        subject.valid?
        expect(subject.errors).to have_key(:date)
      end
    end

    context "when the date is equal to the current date" do
      before { subject.date = Time.zone.today }
        
        it "is invalid" do
          expect(subject).not_to be_valid
        end

      it "adds an error to the model" do
        subject.valid?
        expect(subject.errors).to have_key(:date)
      end
    end

    context "when the date is before the current date" do
      before { subject.date = 1.day.from_now }
      
      it "is valid" do
        expect(subject).to be_valid
      end
    end
end