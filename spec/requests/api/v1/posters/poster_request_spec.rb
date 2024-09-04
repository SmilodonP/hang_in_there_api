require "rails_helper"

describe "posters API" do
	before(:each) do
		@poster1 = Poster.create(
			name: "REGRAT",
      description: "No Ragerts",
			price: 69.00,
			year: 1999,
			vintage: true,
			img_url:  "https://motorillustrated.com/wp-content/uploads/2020/07/Glacer-View-Car-Launch-04.jpg")

		@poster2 = Poster.create(
			name: "Take A Chance",
			description: "Let 'er rip!",
			price: 69.00,
			year: 2018,
			vintage: false,
			img_url:  "https://st4.depositphotos.com/1049680/26641/i/450/depositphotos_266418484-stock-photo-handsome-senior-man-wearing-glasses.jpg")

		@poster3 = Poster.create(
			name: "Take A Bite",
			description: "One bite shouldn't kill you. Probably.",
			price: 69.00,
			year: 2020,
			vintage: false,
			img_url:  "https://psychedelichealth.co.uk/wp-content/uploads/2021/10/amanita.jpeg")
	end

  it "render a JSON representation of the corresponding record" do
    
		get "/api/v1/posters"

		expect(response).to be_successful

		posters = JSON.parse(response.body, symbolize_names: true)

		expect(posters.count).to eq(3)

		posters.each do |poster|
			expect(poster).to have_key(:id)
			expect(poster[:id]).to be_an(Integer)

			expect(poster).to have_key(:name)
			expect(poster[:name]).to be_a(String)

			expect(poster).to have_key(:description)
			expect(poster[:description]).to be_a(String)

			expect(poster).to have_key(:price)
			expect(poster[:price]).to be_a(Float)

			expect(poster).to have_key(:year)
			expect(poster[:year]).to be_a(Integer)

			expect(poster).to have_key(:vintage)
			expect(poster[:vintage]).to be_in([true, false])

			expect(poster).to have_key(:img_url)
			expect(poster[:img_url]).to be_a(String)
		end
	end

	it "can get one poster" do
	
		get "/api/v1/posters/#{@poster1.id}"

		expect(response).to be_successful

		poster_response = JSON.parse(response.body, symbolize_names: true)
		
		expect(poster_response).to have_key(:id)
		expect(poster_response[:id]).to eq(@poster1.id)
		
		expect(poster_response).to have_key(:description)
		expect(poster_response[:description]).to eq(@poster1.description)

		expect(poster_response).to have_key(:price)
		expect(poster_response[:price]).to eq(@poster1.price)
		expect(poster_response).to have_key(:year)
		expect(poster_response[:year]).to eq(@poster1.year)

		expect(poster_response).to have_key(:vintage)
		expect(poster_response[:vintage]).to be(true)

		expect(poster_response).to have_key(:img_url)
		expect(poster_response[:img_url]).to eq(@poster1.img_url)
	end
end