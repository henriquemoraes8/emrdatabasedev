object @user
attributes :id, :name, :social, :email, :status, :phone, :birth_date

child (:address) { extends('addresses/show') }