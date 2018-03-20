object @user
attributes :id, :name, :social, :email, :status, :phone

child (:address) { extends('addresses/show') }