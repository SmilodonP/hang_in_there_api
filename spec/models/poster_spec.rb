require "rails_helper"

RSpec.describe Poster, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
    it { should validate_presence_of(:year) }
    it { should validate_numericality_of(:year).only_integer }
    it { should validate_presence_of(:img_url) }
  end

  describe "The 'filter_by_params' Class Method:" do
    before(:each) do
      @poster1 = Poster.create!(
          name: "REGRAT",
          description: "No Ragerts",
          price: 420.00,
          year: 1999,
          vintage: true,
          img_url:  "https://motorillustrated.com/wp-content/uploads/2020/07/Glacer-View-Car-Launch-04.jpg",
          created_at: 2.days.ago
        )
  
        @poster2 = Poster.create!(
          name: "Take A Chance",
          description: "Let 'er rip!",
          price: 69.00,
          year: 2018,
          vintage: false,
          img_url:  "https://st4.depositphotos.com/1049680/26641/i/450/depositphotos_266418484-stock-photo-handsome-senior-man-wearing-glasses.jpg",
          created_at: 4.day.ago
        )
  
        @poster3 = Poster.create!(
          name: "Take A Bite",
          description: "One bite shouldn't kill you. Probably.",
          price: 101.00,
          year: 2020,
          vintage: false,
          img_url:  "https://psychedelichealth.co.uk/wp-content/uploads/2021/10/amanita.jpeg",
          created_at: 1.day.ago
        )
    end
    
    context "when filtering by name" do
      it "returns posters matching the name (case-insensitive)" do
        result1 = Poster.filter_by_params(name: 'ReGrAT')
        expect(result1).to include(@poster1)
        expect(result1).not_to include(@poster2, @poster3)
        
        result2 = Poster.filter_by_params(name: 'bItE')
        expect(result2).to include(@poster3)
        expect(result2).not_to include(@poster1, @poster2)
      end
    end

    context "when filtering by minimum price" do
      it "returns posters with a price greater than the 'min_price' query param" do
        result1 = Poster.filter_by_params(min_price: 70)
        expect(result1).to include(@poster1, @poster3)
        expect(result1).not_to include(@poster2)

        result2 = Poster.filter_by_params(min_price: 102)
        expect(result2).to include(@poster1)
        expect(result2).not_to include(@poster2, @poster3)
      end
    end

    context "when filtering by maximum price" do
      it "returns posters with a price less than the 'max_price' query param" do
        result1 = Poster.filter_by_params(max_price: 100)
        expect(result1).to include(@poster2)
        expect(result1).not_to include(@poster1, @poster3)

        result2 = Poster.filter_by_params(max_price: 333)
        expect(result2).to include(@poster2, @poster3)
        expect(result2).not_to include(@poster1)
      end
    end

    context 'when sorting by created_at' do
      it 'returns posters in ascending order by default' do
        result = Poster.filter_by_params(sort: 'asc')
        expect(result).to eq([@poster2, @poster1, @poster3])
      end

      it 'returns posters in descending order when specified' do
        result = Poster.filter_by_params(sort: 'desc')
        expect(result).to eq([@poster3, @poster1, @poster2])
      end
    end
  end
end