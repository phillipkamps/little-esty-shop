class Holiday
  attr_reader :date,
    :local_name,
    :name,
    :country_code,
    :fixed,
    :global,
    :counties,
    :launch_year,
    :types

  def initialize(data)
    @date = data[:date]
    @local_name = data[:localName]
    @name = data[:name]
    @country_code = data[:countryCode]
    @fixed = data[:fixed]
    @global = data[:global]
    @counties = data[:counties]
    @launch_year = data[:launchYear]
    @types = data[:types]
  end
end
