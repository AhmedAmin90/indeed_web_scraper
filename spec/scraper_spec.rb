# spec/scraper_spec.rb
require_relative '../lib/scraper'
require 'rainbow'

describe Scraper do
  let(:start) { Scraper.new }

  describe 'scraper' do
    it 'Returns argument error if not 3 arguments' do
      expect { start.scraper(2, 3) }.to raise_error(ArgumentError)
    end

    it 'Takes 3 arguments and return an array' do
      expect(start.scraper(2, 3, 3)).to be_kind_of(Array)
    end
  end

  describe '#page_result' do
    it 'Returns the links of the result page' do
      expect(start.page_result).to eql("\e[1m\e[4m\nThe link of the page: \n\e[0m\e[38;5;129m\n\e[0m")
    end
  end
end
