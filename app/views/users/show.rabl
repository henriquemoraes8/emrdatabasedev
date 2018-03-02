object @user
attributes :id, :name, :social, :email

child (:address) { extends('addresses/show') }
node (:clinics) do
    @user.clinics do |c|
        partial('clinics/show', :object => c)
    end
end