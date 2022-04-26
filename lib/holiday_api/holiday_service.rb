require "json"
require "pry"
require "httparty"

class HolidayService
  def holidays
    get_url("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end

  private

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
