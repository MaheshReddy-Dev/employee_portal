ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :email, :password, :password_confirmation,:username

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :username
      f.input :password      
      f.input :password_confirmation
    end
    f.actions
  end

  
end
