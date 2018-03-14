object @user
attributes :id, :name, :social, :email, :status

child (:address) { extends('addresses/show') }