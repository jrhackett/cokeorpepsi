json.extract! place, :id, :latitude, :longitude, :address, :description, :title, :created_at, :updated_at
json.url place_url(place, format: :json)