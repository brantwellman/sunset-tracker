class Seed
  def self.start
    new.generate
  end

  def generate
    create_locations
  end

  def create_locations
    Location.create([
      {
        address: "1510 Blake St",
        city: "Denver",
        state: "CO",
        zipcode: "80202",
        date: "2016-03-01",
        user_id: 1,
        favorite: 1
      },
      {
        address: "331 Richland Ave",
        city: "San Francisco",
        state: "CA",
        zipcode: "94110",
        date: "2016-03-01",
        user_id: 1,
        favorite: 1
      },
      {
        address: "1285 Glenn St",
        city: "Santa Rosa",
        state: "CA",
        zipcode: "95409",
        date: "2016-03-17",
        user_id: 1,
        favorite: 1
      },
      {
        address: "6561 Camino Del Parque",
        city: "Carlsbad",
        state: "CA",
        zipcode: "92011",
        date: "2016-03-14",
        user_id: 1,
        favorite: 1
      },
      {
        address: "1028 1st Avenue South",
        city: "Seattle",
        state: "WA",
        zipcode: "98134",
        date: "2016-03-18",
        user_id: 1
      },
      {
        address: "1339 NW Flanders St",
        city: "Portland",
        state: "OR",
        zipcode: "97209",
        date: "2016-03-05",
        user_id: 1
      },
      {
        address: "1510 Blake St",
        city: "Denver",
        state: "CO",
        zipcode: "80202",
        date: "2016-03-01",
        user_id: 1
      },
      {
        address: "411 Crescent Av",
        city: "Avalon",
        state: "CA",
        zipcode: "90704",
        date: "2016-03-24",
        user_id: 1
      }
    ])
  end
end
Seed.start
