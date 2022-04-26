require "./lib/holiday_api/holiday_service"

RSpec.describe HolidayService do
  describe "#holidays" do
    it "gets list of holidays for next year", :vcr do
      holiday_service = HolidayService.new
      expect(holiday_service.holidays).to eq([
        {
          date: "2022-05-30",
          localName: "Memorial Day",
          name: "Memorial Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-06-20",
          localName: "Juneteenth",
          name: "Juneteenth",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: 2021,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-07-04",
          localName: "Independence Day",
          name: "Independence Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-09-05",
          localName: "Labor Day",
          name: "Labour Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-10-10",
          localName: "Columbus Day",
          name: "Columbus Day",
          countryCode: "US",
          fixed: false,
          global: false,
          counties: [
            "US-AL",
            "US-AZ",
            "US-CO",
            "US-CT",
            "US-DC",
            "US-GA",
            "US-ID",
            "US-IL",
            "US-IN",
            "US-IA",
            "US-KS",
            "US-KY",
            "US-LA",
            "US-ME",
            "US-MD",
            "US-MA",
            "US-MS",
            "US-MO",
            "US-MT",
            "US-NE",
            "US-NH",
            "US-NJ",
            "US-NM",
            "US-NY",
            "US-NC",
            "US-OH",
            "US-OK",
            "US-PA",
            "US-RI",
            "US-SC",
            "US-TN",
            "US-UT",
            "US-VA",
            "US-WV"
          ],
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-11-11",
          localName: "Veterans Day",
          name: "Veterans Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-11-24",
          localName: "Thanksgiving Day",
          name: "Thanksgiving Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: 1863,
          types: [
            "Public"
          ]
        },
        {
          date: "2022-12-26",
          localName: "Christmas Day",
          name: "Christmas Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2023-01-02",
          localName: "New Year's Day",
          name: "New Year's Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2023-01-16",
          localName: "Martin Luther King, Jr. Day",
          name: "Martin Luther King, Jr. Day",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2023-02-20",
          localName: "Presidents Day",
          name: "Washington's Birthday",
          countryCode: "US",
          fixed: false,
          global: true,
          counties: nil,
          launchYear: nil,
          types: [
            "Public"
          ]
        },
        {
          date: "2023-04-07",
          localName: "Good Friday",
          name: "Good Friday",
          countryCode: "US",
          fixed: false,
          global: false,
          counties: [
            "US-CT",
            "US-DE",
            "US-HI",
            "US-IN",
            "US-KY",
            "US-LA",
            "US-NC",
            "US-ND",
            "US-NJ",
            "US-TN"
          ],
          launchYear: nil,
          types: [
            "Public"
          ]
        }
      ])
    end
  end
end
