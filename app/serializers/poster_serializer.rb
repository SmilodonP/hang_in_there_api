class PosterSerializer
	def self.format_poster(poster)		
		{
			id: poster.id,
			name: poster.name,
			description: poster.description,
			price: poster.price,
			year: poster.year,
			vintage: poster.vintage,
			img_url: poster.img_url
		}
	end

	def self.format_posters(posters)
		posters.each do |poster|
			format_poster(poster)
		end
	end
end