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
  end
end

describe DPRB::Builder do
  it 'should work' do
    builder = DPRB::Builder::ComputerBuilder.new
    builder.turbo
    builder.add_cd(true)
    builder.add_dvd
    builder.add_hard_disk(100000)
  end
end

describe DPRB::Command do
  it 'should work' do
    save_button = DPRB::Command::SlickButton.new(DPRB::Command::SaveCommand.new)

    cmds = DPRB::Command::CompositeCommand.new
    cmds.add_command(DPRB::Command::CreateFile.new('file1.txt', "hello world\n"))
    cmds.add_command(DPRB::Command::CopyFile.new('file1.txt', 'file2.txt'))
    cmds.add_command(DPRB::Command::DeleteFile.new('file1.txt'))
  end
end

describe DPRB::Composite do
  it 'should work' do
    make_cake_task = DPRB::Composite::MakeCakeTask.new
    make_cake_task.get_time_required
  end
end

describe DPRB::Decorator do
  it 'should work' do
    File.stub(:open)
      .with('final.txt', 'w')
      .and_return(StringIO.new('', 'w'))

    writer = DPRB::Decorator::NumberingWriter.new(DPRB::Decorator::SimpleWriter.new('final.txt'))
    writer.write_line('Hello out there')
  end
end

describe DPRB::Factory do
  it 'should work' do
    pond = DPRB::Factory::FrogPond.new(3)
    pond.simulate_one_day
  end
end

describe DPRB::Interpreter do
  it 'should work' do
    # expr_all = DPRB::Interpreter::All.new
    # files = expr_all.evaluate('test_dir')

    # expr_not_writable = DPRB::Interpreter::Not.new(DPRB::Interpreter::Writable.new)
    # readonly_files = expr_not_writable.evaluate('test_dir')

    # big_or_mp3_expr = Or.new( Bigger.new(1024), FileName.new('*.mp3') )
    # big_or_mp3s = big_or_mp3_expr.evaluate('test_dir')
  end
end
