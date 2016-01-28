require_relative "../account"
# require 'csv'


describe Account do

  let(:subject) {Account.new(["John Smith", "3757", "$600.00"])}
  let(:subject_IntSym){Account.new(["John Smith", "3757", "$600"])}
  let(:subject_FloNoSym){Account.new(["John Smith", "3757", "600.00"])}
  let(:subject_IntNoSym){Account.new(["John Smith", "3757", "600"])}

  it "populates #name" do
    expect(subject.name).to eq("John Smith")
  end

  it "populates #number" do
    expect(subject.number).to eq("3757")
  end

  it "populates #avaliableBalance" do
    expect(subject.avaliableBalance).to eq(600.00)
  end

  it "converts balance to standard format" do
    expect(subject.avaliableBalance).to eq(600.00)
    expect(subject_IntSym.avaliableBalance).to eq(600)
    expect(subject_FloNoSym.avaliableBalance).to eq(600.00)
    expect(subject_IntNoSym.avaliableBalance).to eq(600.00)
  end

end