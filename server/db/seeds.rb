# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

users = [
  {
    name: 'Eric Cartman',
    email: 'eric@example.com',
    password: 'changeme$eric',
    products: [
      {
        name: 'Duckworth Dog Toy',
        description: 'Duckworth is a customer and dog favorite. Pups love playing with, fetching, and cuddling with this friendly duck that squeaks.',
        url: "https://www.amazon.com/dp/B000084E7Y"
      },
      {
        name: 'Nerf N-Strike Elite Delta Trooper',
        description: 'Nerf N-Strike Elite blasters from Hasbro deliver the ultimate in blaster performance for Nerf battles. Customize the Nerf N-Strike Elite Delta Trooper blaster for battle-ready action with its attachable stock and barrel extension!',
        url: "https://www.amazon.com/dp/B076JQP4X6"
      },
      {
        name: "Bose SoundLink Color Bluetooth Speaker II",
        description: "From the pool to the park to the patio, this speaker’s rugged, water-resistant design lets you enjoy the music you love in more places. Voice prompts make pairing easy, and up to 8 hours per charge keeps your playlists playing. Despite its size, it delivers big sound.",
        url: "https://www.amazon.com/dp/B01HETFQKS"
      }
    ]
  },
  {
    name: 'Kyle Brovlowski',
    email: 'kyle@example.com',
    password: 'changeme$kyle',
    products: [
      {
        name: "Nintendo Switch",
        description: "Play your way with the Nintendo Switch gaming system. Whether you’re at home or on the go, solo or with friends, the Nintendo Switch system is designed to fit your life.",
        url: "https://www.amazon.com/dp/B07VGRJDFY"
      }
    ]
  },
  {
    name: "Kenny McCormick",
    email: "kenny@example.com",
    password: 'changeme$kenny',
    products: [
      {
        name: "GraphQL Apollo Server with Node.js",
        description: "GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.",
        url: "https://www.udemy.com/course/graphql-apollo-server-api-nodejs-mongodb/"
      },
      {
        name: "Vue JS 2 - The Complete Guide",
        description: "Vue.js is an awesome JavaScript Framework for building Frontend Applications! VueJS mixes the Best of Angular + React!",
        url: "https://www.udemy.com/course/vuejs-2-the-complete-guide/"
      }
    ]
  }
]

users.each do |user_attributes|
  user = User.create!(user_attributes.slice(:name, :email, :password))
  user_attributes[:products]&.each do |product_attributes|
    product = user.products.create!(product_attributes)
    product.votes.create!(user: user)
  end
end
