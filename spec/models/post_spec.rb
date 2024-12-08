require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should belong_to(:user) }
  end
end
