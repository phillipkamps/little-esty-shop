require "./lib/holiday_api/holiday"
require "./lib/holiday_api/holiday_service"

class UpcomingHolidays
  def next_3_holidays
    service.holidays[0..2].map { |data| Holiday.new(data) }
  end

  private

  def service
    HolidayService.new
  end
end
