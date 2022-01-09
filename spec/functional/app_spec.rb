require 'spec_helper'

#######################################################
# DO NOT CHANGE THIS FILE - WRITE YOUR OWN SPEC FILES #
#######################################################
RSpec.describe 'App Functional Test' do
  describe 'dollar and percent formats sorted by first_name' do
    let(:params) do
      {
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        percent_format: File.read('spec/fixtures/people_by_percent.txt'),
        order: :first_name,
      }
    end
    let(:people_controller) { PeopleController.new(params) }

    it 'parses input files and outputs normalized data' do
      normalized_people = people_controller.normalize

      # Expected format of each entry: `<first_name>, <city>, <birthdate M/D/YYYY>`
      expect(normalized_people).to eq [
        'Elliot, New York City, 5/4/1947',
        'Mckayla, Atlanta, 5/29/1986',
        'Rhiannon, Los Angeles, 4/30/1974',
        'Rigoberto, New York City, 1/5/1962',
      ]
    end

    it 'returns empty array if no input is passed' do
      people_controller = PeopleController.new({
        dollar_format: nil,
        percent_format: nil,
        order: nil
      })
      normalized_people = people_controller.normalize
      expect(normalized_people).to eq []
    end

    it 'parses input files are return unordered normalized data' do
      people_controller = PeopleController.new({
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        percent_format: File.read('spec/fixtures/people_by_percent.txt'),
        order: nil
      })
      normalized_people = people_controller.normalize
      expect(normalized_people).to eq [
        "Rhiannon, Los Angeles, 4/30/1974",
        "Rigoberto, New York City, 1/5/1962",
        "Mckayla, Atlanta, 5/29/1986",
        "Elliot, New York City, 5/4/1947"
        ]
    end

    it 'parses input files are return normalized data ordered by birthdate' do
      people_controller = PeopleController.new({
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        percent_format: File.read('spec/fixtures/people_by_percent.txt'),
        order: :birthdate
      })
      normalized_people = people_controller.normalize
      expect(normalized_people).to eq [
        "Elliot, New York City, 5/4/1947",
        "Rigoberto, New York City, 1/5/1962",
        "Rhiannon, Los Angeles, 4/30/1974",
        "Mckayla, Atlanta, 5/29/1986"
        ]
    end

    it 'parses input files are return normalized data ordered by last_name' do
      people_controller = PeopleController.new({
        dollar_format: File.read('spec/fixtures/people_by_dollar.txt'),
        percent_format: File.read('spec/fixtures/people_by_percent.txt'),
        order: :last_name
      })
      normalized_people = people_controller.normalize
      expect(normalized_people).to eq [
        "Mckayla, Atlanta, 5/29/1986",
        "Elliot, New York City, 5/4/1947",
        "Rigoberto, New York City, 1/5/1962",
        "Rhiannon, Los Angeles, 4/30/1974"
        ]
    end


  end
end
