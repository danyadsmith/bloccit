require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do
  
  let(:topic) { create(:topic) }

  it { should have_many(:posts) }
  it { should have_many(:sponsored_posts) }
  
  it { should have_many(:labelings) }
  it { should have_many(:labels).through(:labelings) }

  it { should have_many(:ratings) }
  it { should have_many(:rates).through(:ratings) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(5)}
  
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_least(15)}

  describe "attributes" do
    it "should respond to name" do
      expect(topic).to respond_to(:name)
    end
    
    it "should respond to description" do
      expect(topic).to respond_to(:description)
    end

    it "should respond to public" do
      expect(topic).to respond_to(:public)
    end

    it "should be public by default" do
      expect(topic.public).to be (true)
    end
  end

  describe "scopes" do
    before do
      @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = User.new
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end

      it "returns only public topics if user is nil" do
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end

    describe "publicly_viewable" do
      it "returns all public topics" do
        public_topics = Topic.publicly_viewable
        get_public_topics = Topic.where(public: true)
        get_private_topics = Topic.where(public: false)
        all_topics = Topic.all
        expect(public_topics.count).to eq(all_topics.count - get_private_topics.count)
      end
    end

    describe "privately_viewable" do
      it "returns all private topics" do
        private_topics = Topic.privately_viewable
        get_public_topics = Topic.where(public: true)
        get_private_topics = Topic.where(public: false)
        all_topics = Topic.all
        expect(private_topics.count).to eq(all_topics.count - get_public_topics.count)
      end
    end    
  end  
end
