require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:content) }
    it { should belong_to(:post) }
  end
end
