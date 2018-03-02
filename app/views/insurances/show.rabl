object @insurance
attributes :id, :name, :email, :phone

child (:address) { extends('addresses/show') }