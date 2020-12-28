# spec/scraper_spec.rb
require_relative '../lib/scraper'
require 'rainbow'

describe Scraper do
  let(:start) { Scraper.new }

  describe 'scraper' do
    it 'Returns argument error if not 3 arguments' do
      expect { start.scraper(2, 3) }.to raise_error(ArgumentError)
    end

    it 'Returns a link to the indeed website' do
      expect(start.scraper(2, 3, 1)).to eql('https://www.indeed.com/jobs?q=back+end+developer&&l=Remote&fromage=7')
    end
  end

  describe 'make_array' do
    it 'Returns an array' do
      expect((start.make_array if start.scraper(2, 3, 1))).to be_kind_of(Array)
    end

    it 'Reruns an argument error if no declared arguments in scraper method' do
      expect { start.make_array if start.scraper(2, 3) }.to raise_error(ArgumentError)
    end
  end

  describe '#page_result' do
    it 'Returns the links of the result page' do
      expect(start.page_result).to eql("\e[1m\e[4m\nThe link of the page: \n\e[0m\e[38;5;129m\n\e[0m")
    end

    it 'Returns ' do
    end
  end
end
