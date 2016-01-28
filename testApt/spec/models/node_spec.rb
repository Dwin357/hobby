require 'rails_helper'

# RSpec.describe Node, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Node, type: :model do
	before(:all) do
		@node = Node.new(value: "V", pointer: 1)
	end

	it "has a value of 'V'" do
		expect(@node.value).to eq("V")
	end
end

scenario " creation of a node" do

	node = create(:node)

	visit node_path(node)

	expect()