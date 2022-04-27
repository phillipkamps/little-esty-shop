require "./lib/holiday_api/holiday_service"
require "./lib/holiday_api/upcoming_holidays"

RSpec.describe UpcomingHolidays do
  describe "#next_3_holidays" do
    it "gets next 3 holidays", :vcr do
      expect(
        UpcomingHolidays.new
        .next_3_holidays
        .map { |e| [e.name, e.date] }
      ).to eq([
        ["Memorial Day", "2022-05-30"],
        ["Juneteenth", "2022-06-20"],
        ["Independence Day", "2022-07-04"]
      ])
    end
  end
end
