Rails.application.routes.draw do
  mount Atlassian::Connect::Engine => "/atlassian-connect"
end
