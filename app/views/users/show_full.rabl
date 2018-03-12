object @user
extends('users/show')

child (:clinics) do
    extends('clinics/show')
end