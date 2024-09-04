# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Poster.create(name: "REGRAT",
description: "No Ragerts",
price: 69.00,
year: 1999,
vintage: true,
img_url:  "https://motorillustrated.com/wp-content/uploads/2020/07/Glacer-View-Car-Launch-04.jpg")

Poster.create(name: "Take A Chance",
description: "Let 'er rip!",
price: 69.00,
year: 2018,
vintage: false,
img_url:  "https://st4.depositphotos.com/1049680/26641/i/450/depositphotos_266418484-stock-photo-handsome-senior-man-wearing-glasses.jpg")

Poster.create(name: "Take A Bite",
description: "One bite shouldn't kill you. Probably.",
price: 69.00,
year: 2020,
vintage: false,
img_url:  "https://psychedelichealth.co.uk/wp-content/uploads/2021/10/amanita.jpeg")

Poster.create(name: "Patience",
description: "Too much of a good thing is never a good thing.",
price: 69.00,
year: 2021,
vintage: false,
img_url:  "https://motionarray.imgix.net/igor-fon-20-mov-2680769-high_0006.jpg?w=660&q=60&fit=max&auto=format")

Poster.create(name: "Regalia",
description: "Why is she palatialing? Where is the poker table?",
price: 69.00,
year: 2021,
vintage: false,
img_url:  "https://i0.wp.com/www.thewrap.com/wp-content/uploads/2021/12/Simon-Rex.jpg?fit=1200%2C675&ssl=1")

Poster.create(name: "DMT",
description: "Because sometimes things need to make less sense in order to make more sense.",
price: 69.00,
year: 2003,
vintage: true,
img_url:  "https://preview.redd.it/alex-gray-like-ai-v0-qbi5xwq1f1gc1.jpg?width=640&crop=smart&auto=webp&s=5151886c4c32fde635f53ad88fc1b2bc73b79ae3")

