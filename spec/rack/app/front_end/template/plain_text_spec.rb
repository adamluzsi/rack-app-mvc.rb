require 'spec_helper'

describe Rack::App::FrontEnd::Template::PlainText do

  let(:file_path) { Rack::App::Utils.pwd('spec', 'fixtures', 'raw.txt') }
  let(:instance) { described_class.new(file_path) }

  describe '#each' do
    subject { instance.take(2) }

    it 'should iterate over the file content' do
      is_expected.to eq ["hello world!\n", 'how you doing?']
    end

    it 'should ensure to run file.close always' do
      expect { instance.each.map { |l|} }.to raise_error(IOError, 'closed stream')
    end

  end

  describe '#render' do
    subject { instance.render(nil) }

    it { is_expected.to eq "hello world!\nhow you doing?" }
  end

  describe '#to_a' do
    subject { instance.to_a }

    it { is_expected.to eq ["hello world!\n", 'how you doing?'] }
  end

end