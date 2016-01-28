require 'rails_helper'

RSpec.describe Post, type: :model do
	before(:all) do
		@post = create(:post)
	end

  it " has a title attribute" do
    expect(@post.title).to eq("This is a factory built post")
  end

  it " has a body attribute" do
    expect(@post.body).to eq("This is some text that comprimises what I think")
  end

 #  let(:subject){create(:post)}

	# it " populates #title attribute" do
	# 	expect(subject.title).to eq("This is a factory built post")
	# end

	# it " populates #body attribute" do
	# 	expect(subject.body).to eq("This is some text that comprimises what I think")
	# end

end
