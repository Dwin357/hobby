require_relative "hacknight-21-alt"

describe Deck do
  let(:subject) { Deck.new }
  let(:number_hand) { ["2", "5"]}
  let(:face_hand) { ["J", "9"]}
  let(:ace_high) { ["10", "A"]}
  let(:ace_low) { ["A", "10", "9"]}
  let(:three_aces) {["A", "A", "A", "5", "2"]}

  it "initializes with 52 cards" do
    expect(subject.cards.count).to eq(52)
  end

  # it "shuffles the cards when initializes"
  # no idea

  it "#deal_one removes and returns the last card" do
    last = subject.cards.last
    expect(subject.deal_one).to eq(last)
  end

  it ".score_hand returns the number value of hand" do
    expect(Deck.score_hand(number_hand)).to eq(7)
    expect(Deck.score_hand(face_hand)).to eq(19)
    expect(Deck.score_hand(ace_high)).to eq(21)
    expect(Deck.score_hand(ace_low)).to eq(20)
    expect(Deck.score_hand(three_aces)).to eq(20)
  end
end

describe TwentyOneGame do
  let(:subject) { TwentyOneGame.new(1) }


end