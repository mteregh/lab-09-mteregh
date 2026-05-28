Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Vet.destroy_all
Owner.destroy_all
User.destroy_all

admin_user = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@vetclinic.com",
  password: "password123",
  role: :admin
)

vet_user = User.create!(
  first_name: "Vet",
  last_name: "User",
  email: "vet@vetclinic.com",
  password: "password123",
  role: :vet
)

owner_user = User.create!(
  first_name: "Owner",
  last_name: "User",
  email: "owner@vetclinic.com",
  password: "password123",
  role: :owner
)

owners = [
  Owner.create!(
    user: owner_user,
    first_name: "Maria",
    last_name: "Guerra",
    email: "maria.guerra@example.com",
    phone: "+56911111111",
    address: "Cerro el Paico 9886, Santiago"
  ),
  Owner.create!(
    first_name: "Antonio",
    last_name: "Ossa",
    email: "antonio.ossa@example.com",
    phone: "+56922222222",
    address: "Camino la Tagua 3627, Valparaiso"
  ),
  Owner.create!(
    first_name: "Sofia",
    last_name: "Martinez",
    email: "sofia.martinez@example.com",
    phone: "+56933333333",
    address: "Camino las hermitas 2431, Concepcion"
  )
]

pets = [
  owners[0].pets.create!(
    name: "Luna",
    species: "dog",
    breed: "Labrador",
    date_of_birth: Date.new(2020, 5, 10),
    weight: 24.5
  ),
  owners[0].pets.create!(
    name: "Milo",
    species: "cat",
    breed: "Siamese",
    date_of_birth: Date.new(2021, 8, 15),
    weight: 4.2
  ),
  owners[1].pets.create!(
    name: "Bella",
    species: "rabbit",
    breed: "Mini Lop",
    date_of_birth: Date.new(2022, 3, 20),
    weight: 2.1
  ),
  owners[1].pets.create!(
    name: "Rocky",
    species: "dog",
    breed: "Beagle",
    date_of_birth: Date.new(2019, 11, 2),
    weight: 12.8
  ),
  owners[2].pets.create!(
    name: "Nala",
    species: "cat",
    breed: "Persian",
    date_of_birth: Date.new(2018, 7, 1),
    weight: 5.0
  )
]

seed_photos = [
  [pets[0], "dog.jpg"],
  [pets[1], "cat.jpg"],
  [pets[2], "rabbit.jpg"],
  [pets[3], "dog.jpg"],
  [pets[4], "cat.jpg"]
]

seed_photos.each do |pet, filename|
  path = Rails.root.join("db/seeds/pets/#{filename}")

  if File.exist?(path)
    pet.photo.attach(
      io: File.open(path),
      filename: filename,
      content_type: "image/jpeg"
    )
  else
    puts "Missing seed image: #{path}"
  end
end

vets = [
  Vet.create!(
    user: vet_user,
    first_name: "Ana",
    last_name: "Rojas",
    email: "ana.rojas@vetclinic.com",
    phone: "+56944444444",
    specialization: "General Practice"
  ),
  Vet.create!(
    first_name: "Carlos",
    last_name: "Fernandez",
    email: "carlos.fernandez@vetclinic.com",
    phone: "+56955555555",
    specialization: "Surgery"
  )
]

appointments = [
  Appointment.create!(
    pet: pets[0],
    vet: vets[0],
    date: DateTime.new(2026, 4, 10, 10, 0, 0),
    reason: "Annual checkup",
    status: :scheduled
  ),
  Appointment.create!(
    pet: pets[1],
    vet: vets[1],
    date: DateTime.new(2026, 4, 11, 11, 30, 0),
    reason: "Skin irritation",
    status: :in_progress
  ),
  Appointment.create!(
    pet: pets[2],
    vet: vets[0],
    date: DateTime.new(2026, 4, 12, 9, 15, 0),
    reason: "Dental revision",
    status: :completed
  ),
  Appointment.create!(
    pet: pets[3],
    vet: vets[1],
    date: DateTime.new(2026, 4, 13, 14, 0, 0),
    reason: "Leg injury",
    status: :completed
  ),
  Appointment.create!(
    pet: pets[4],
    vet: vets[0],
    date: DateTime.new(2026, 4, 14, 16, 45, 0),
    reason: "Vaccination follow-up",
    status: :cancelled
  )
]

Treatment.create!(
  appointment: appointments[1],
  name: "Skin Cream Application",
  medication: "Hydrocortisone Cream",
  dosage: "Apply twice daily",
  clinical_notes: "<h3>Skin irritation follow-up</h3><ul><li>Monitor redness and itching.</li><li>Apply cream twice daily.</li></ul><p><strong>Return if symptoms worsen.</strong></p>",
  administered_at: DateTime.new(2026, 4, 11, 11, 45, 0)
)

Treatment.create!(
  appointment: appointments[2],
  name: "Teeth Cleaning",
  medication: "Dental Rinse",
  dosage: "5 ml after cleaning",
  clinical_notes: "<h3>Dental procedure</h3><ul><li>Cleaning completed successfully.</li><li>No major complications observed.</li></ul><p><strong>Continue dental care at home.</strong></p>",
  administered_at: DateTime.new(2026, 4, 12, 9, 45, 0)
)

Treatment.create!(
  appointment: appointments[2],
  name: "Pain Relief",
  medication: "Meloxicam",
  dosage: "0.2 mg/kg once daily",
  clinical_notes: "<h3>Pain control</h3><ul><li>Medication given after dental procedure.</li><li>Monitor appetite and behavior.</li></ul><p><strong>Use only as prescribed.</strong></p>",
  administered_at: DateTime.new(2026, 4, 12, 10, 0, 0)
)

Treatment.create!(
  appointment: appointments[3],
  name: "Bandage Placement",
  medication: "Antiseptic Solution",
  dosage: "Clean area before bandage",
  clinical_notes: "<h3>Leg injury care</h3><ul><li>Area cleaned before bandage placement.</li><li>Bandage should be changed in 3 days.</li></ul><p><strong>Keep bandage dry.</strong></p>",
  administered_at: DateTime.new(2026, 4, 13, 14, 30, 0)
)

Treatment.create!(
  appointment: appointments[3],
  name: "Anti-inflammatory Injection",
  medication: "Carprofen",
  dosage: "1 injection",
  clinical_notes: "<h3>Injection notes</h3><ul><li>Pet responded well.</li><li>No immediate adverse reaction observed.</li></ul><p><strong>Monitor during the next 24 hours.</strong></p>",
  administered_at: DateTime.new(2026, 4, 13, 14, 40, 0)
)

puts "Seed data created successfully!"
puts "#{User.count} users"
puts "#{Owner.count} owners"
puts "#{Pet.count} pets"
puts "#{Vet.count} vets"
puts "#{Appointment.count} appointments"
puts "#{Treatment.count} treatments"