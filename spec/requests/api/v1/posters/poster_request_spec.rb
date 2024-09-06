require "rails_helper"

describe "posters API" do
	before(:each) do
		@poster1 = Poster.create(
			name: "REGRAT",
      description: "No Ragerts",
			price: 69.00,
			year: 1999,
			vintage: true,
			img_url:  "https://motorillustrated.com/wp-content/uploads/2020/07/Glacer-View-Car-Launch-04.jpg",
			created_at: 2.days.ago
		)

		@poster2 = Poster.create(
			name: "Take A Chance",
			description: "Let 'er rip!",
			price: 69.00,
			year: 2018,
			vintage: false,
			img_url:  "https://st4.depositphotos.com/1049680/26641/i/450/depositphotos_266418484-stock-photo-handsome-senior-man-wearing-glasses.jpg",
			created_at: 1.day.ago
		)

		@poster3 = Poster.create(
			name: "Take A Bite",
			description: "One bite shouldn't kill you. Probably.",
			price: 69.00,
			year: 2020,
			vintage: false,
			img_url:  "https://psychedelichealth.co.uk/wp-content/uploads/2021/10/amanita.jpeg",
			created_at: Time.now
		)
	end

  it "render a JSON representation of the corresponding record" do
    
		get "/api/v1/posters"

		expect(response).to be_successful

		posters = JSON.parse(response.body, symbolize_names: true)

		expect(posters[:data].count).to eq(3)

		expect(posters[:meta]).to be_present
		expect(posters[:meta][:count]).to eq(3)

		posters[:data].each do |poster|
			expect(poster[:id].to_i).to be_an(Integer)

			expect(poster[:attributes]).to have_key(:name)
			expect(poster[:attributes][:name]).to be_a(String)

			expect(poster[:attributes]).to have_key(:description)
			expect(poster[:attributes][:description]).to be_a(String)

			expect(poster[:attributes]).to have_key(:price)
  		expect(poster[:attributes][:price]).to be_a(Float)

  		expect(poster[:attributes]).to have_key(:year)
  		expect(poster[:attributes][:year]).to be_a(Integer)

  		expect(poster[:attributes]).to have_key(:vintage)
  		expect(poster[:attributes][:vintage]).to be_in([true, false])

  		expect(poster[:attributes]).to have_key(:img_url)
  		expect(poster[:attributes][:img_url]).to be_a(String)
		end
	end

	it "can get one poster" do
	
		get "/api/v1/posters/#{@poster1.id}"

		expect(response).to be_successful

		poster_response = JSON.parse(response.body, symbolize_names: true)
		
		expect(poster_response[:data]).to have_key(:id)
		expect(poster_response[:data][:id].to_i).to eq(@poster1.id)
		
		expect(poster_response[:data][:attributes]).to have_key(:description)
		expect(poster_response[:data][:attributes][:description]).to eq(@poster1.description)

		expect(poster_response[:data][:attributes]).to have_key(:price)
		expect(poster_response[:data][:attributes][:price]).to eq(@poster1.price)

		expect(poster_response[:data][:attributes]).to have_key(:year)
		expect(poster_response[:data][:attributes][:year]).to eq(@poster1.year)

		expect(poster_response[:data][:attributes]).to have_key(:vintage)
		expect(poster_response[:data][:attributes][:vintage]).to be(true)

		expect(poster_response[:data][:attributes]).to have_key(:img_url)
		expect(poster_response[:data][:attributes][:img_url]).to eq(@poster1.img_url)
	end

	it "can create a new poster" do
		poster_params = {
  	name: "Dragon Reborn",
  	description: "The Wheel Weaves",
  	price: 69.00,
  	year: 2013,
  	vintage: false,
  	img_url: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.thegreatblight.com%2Fmajor-character%2Frand-althor&psig=AOvVaw2mEU7gb_WgjxRqQ1-B-xSl&ust=1725573628841000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNjr-eqkqogDFQAAAAAdAAAAABAE"
		}

		post api_v1_posters_path, params: poster_params, as: :json
		created_poster = Poster.last

		expect(response).to be_successful
		expect(response.code).to eq("201")

		expect(created_poster.name).to eq(poster_params[:name])
		expect(created_poster.description).to eq(poster_params[:description])
		expect(created_poster.price).to eq(poster_params[:price])
		expect(created_poster.year).to eq(poster_params[:year])
		expect(created_poster.vintage?).to eq(poster_params[:vintage])
		expect(created_poster.img_url).to eq(poster_params[:img_url])
	end

  it "can update an existing poster" do

    id = Poster.create(name: "New Updated Poster").id

    previous_name = Poster.name

    poster_params = { name: "New Updated Poster"}
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/posters/#{id}", headers: headers, params: JSON.generate({poster: poster_params})

    poster = Poster.find_by(id: id)
  
    expect(response).to be_successful
    expect(poster.name).to_not eq(previous_name)
    expect(poster.name).to eq("New Updated Poster")
  end

	it "can delete posters" do

		expect(Poster.find_by(id: @poster1.id)).not_to be_nil

		
		delete "/api/v1/posters/#{@poster1.id}"
		expect(response).to be_successful
	
		expect(Poster.find_by(id: @poster1.id)).to be_nil
		expect { Poster.find(@poster1.id) }.to raise_error(ActiveRecord::RecordNotFound)
	end

	it "can return posters sorted in ascending order by created_at" do

    get "/api/v1/posters?sort=asc"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(posters[0][:id].to_i).to eq(@poster1.id)
    expect(posters[1][:id].to_i).to eq(@poster2.id)
    expect(posters[2][:id].to_i).to eq(@poster3.id)
  end

	it "can return posters sorted in descending order by created_at" do

    get "/api/v1/posters?sort=desc"

    expect(response).to be_successful

    posters = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(posters[0][:id].to_i).to eq(@poster3.id)
    expect(posters[1][:id].to_i).to eq(@poster2.id)
    expect(posters[2][:id].to_i).to eq(@poster1.id)
  end
end

