Rails.application.routes.draw do
  get 'sale_details/index', to:'sale_details#index'
  root :to => "sale_details#index"
  get 'sale_details/monthily_report', :to => "sale_details#monthily_report"
  get 'api/v1/sales_details/index' , to: 'api/v1/sales_details#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
