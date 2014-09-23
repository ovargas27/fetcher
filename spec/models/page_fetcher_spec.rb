require 'rails_helper'

RSpec.describe PageFetcher, :type => :model, :vcr => {:record => :new_episodes}do
  describe ".find" do
    context "page exists" do
      it do
        expect(PageFetcher.find("188091757763")).not_to be_nil
      end
    end

    context "page doesn't exist" do
      it do
        expect(PageFetcher.find("000000000000")).to be_nil
      end
    end
  end

end

