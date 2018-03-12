object @share_request
attributes :id, :status, :created_at

child (:user) { extends('users/show') }
child (:clinic) { extends('clinics/show') }