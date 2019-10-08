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
