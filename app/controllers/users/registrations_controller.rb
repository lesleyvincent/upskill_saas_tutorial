class Users::RegistrationsController < Devise::RegistrationsController
  
  # Extend default Devise gem behavior so that
  # users signing up with Pro account (Plan ID 2)
  # save with a special Stripe subscription founction 
  #(resource.save_with_subcription). 
  # Otherwise Devise signs up user as usual using the Basic account. 
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end


