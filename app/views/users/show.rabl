object @user
attributes :id, :name, :social, :email

child (:address) { extends('addresses/show') }
child (:clinics) do
    extends('clinics/show')
end