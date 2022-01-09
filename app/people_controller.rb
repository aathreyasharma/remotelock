require_relative 'services/parse_service'
class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    arr = []
    @params.keys.each do |key|
      if key.to_s.include?('format') && !@params[key].nil?
        arr << ParseService.new(@params[key], key).call
      end
    end
    arr.flatten!
    arr.sort_by!{|elem| [elem.send(@params[:order]) ? 1 : 0, elem.send(@params[:order])] } unless @params[:order].nil?
    arr.map!(&:stringify) unless arr.empty?
    arr
  end

  private

  attr_reader :params
end
