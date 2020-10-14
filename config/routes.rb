Rails.application.routes.draw do
  post "/load_xml" => "home#load_xml"
  root to: "home#index"
end
