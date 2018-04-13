# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Clinic.destroy_all
Insurance.destroy_all
ShareRequest.destroy_all
Record.destroy_all
Address.destroy_all

User.create(name: 'Ricardo', last_name: 'Alberto', email: 'r@gmail.com', password: 'A12344321', social: '12341234', phone: '8921470142738', insurance_unique_id: "A83209381", birth_date: Date.new(1990, 3, 2))
User.create(name: 'Roberto', last_name: 'Genime', email: 'rob@gmail.com', password: 'A12344321', social: '09128375', phone: '234562321', insurance_unique_id: "B83209381", birth_date: Date.new(1989, 3, 2))
User.create(name: 'Amanda', last_name: 'Bortner', email: 'amanda@gmail.com', password: 'A12344321', social: '23914876', phone: '7855262346', insurance_unique_id: "C83209381", birth_date: Date.new(1988, 3, 2))
User.create(name: 'Kenny', last_name: 'Segall', email: 'kenn@gmail.com', password: 'A12344321', social: '4271864968', phone: '7347246', insurance_unique_id: "D83209381", birth_date: Date.new(1987, 3, 2))
User.create(name: 'Rafa', last_name: 'Assis', email: 'rafazassis@gmail.com', password: 'A12344321', social: '466671864968', phone: '+5511970877399', insurance_unique_id: "D8320dsd9381", birth_date: Date.new(1927, 3, 2))
User.create(name: 'Henrique', last_name: 'Rusca', email: 'henrique.rusca@gmail.com', password: 'A12344321', social: '46643671864968', phone: '3053638773', insurance_unique_id: "D8320d44sd9381", birth_date: Date.new(1927, 3, 2))


Clinic.create(name: 'Miami Cardiology', phone: '42987132', email: 'miami@cardiology.com', password: 'A12344321')
Clinic.create(name: 'Orthopedists Heaven', phone: '4214323441', email: 'miami@ortho.com', password: 'A12344321')
Clinic.create(name: 'Brawling Brain', phone: '43212551', email: 'miami@brain.com', password: 'A12344321')

Insurance.create(name: 'Progressive', phone: '4298557132', email: 'miami@prog.com', password: 'A12344321')
Insurance.create(name: 'Blue Cross', phone: '421436623441', email: 'blue@cross.com', password: 'A12344321')

User.all.each do |u|
  Address.create(zip: '33130')
  u.insurance = Insurance.offset(rand(Insurance.count)).first
  u.save
end
Clinic.all.each do |u|
  Address.create(street: '1310 S Miami Ave', zip: '33130', state: 'FL', city: 'Miami', apt:"#{u.id + 300}", clinic_id: u.id)
end
Insurance.all.each do |u|
  Address.create(street: '1320 S Miami Ave', zip: '33130', state: 'FL', city: 'Miami', apt:"#{u.id + 500}", insurance_id: u.id)
end

(1..50).each do |i|
  r = Record.new(url: "https://www.ghs.org/wp-content/uploads/2015/11/medical-record.jpg", name: "record #{i}", mime_type: "image/jpeg", file_size: i * 50)
  r.user = User.offset(rand(User.count)).first
  r.owner_clinic = Clinic.offset(rand(Clinic.count)).first
  r.record_types << RecordType.offset(rand(RecordType.count)).first
  r.record_types << RecordType.offset(rand(RecordType.count)).first
  r.save
end

Clinic.all.each do |c|
  (1..5).each do
    c.records.push(Record.offset(rand(Record.count)).first)
  end

  User.all.each do |u|
    unless c.users.include?(u)
      ShareRequest.create(user_id: u.id, clinic_id: c.id)
    end
  end
end

