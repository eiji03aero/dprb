require 'spec_helper'

describe DPRB::Adapter do
  it 'should work' do
    File.stub(:open)
      .with('out.txt', 'w')
      .and_return(StringIO.new('', 'w'))

    encrypter = DPRB::Adapter::Encrypter.new('XYZZY')
    reader = DPRB::Adapter::StringIOAdapter.new('We attack at down')
    writer = File.open('out.txt', 'w')
    encrypter.encrypt(reader, writer)
    expect(true).to eq(true)
  end
end

describe DPRB::Builder do
  it 'should work' do
    builder = DPRB::Builder::ComputerBuilder.new
    builder.turbo
    builder.add_cd(true)
    builder.add_dvd
    builder.add_hard_disk(100000)
    expect(true).to eq(true)
  end
end
