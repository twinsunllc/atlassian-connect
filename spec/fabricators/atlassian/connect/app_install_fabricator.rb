Fabricator(:app_install, from: 'Atlassian::Connect::AppInstall') do
  base_url                   "https://suspect.atlassian.net"
  client_key                 "75cb2b5a-b7cb-3e86-90c2-0f24630ab75f"
  description                "Atlassian JIRA at https://suspect.atlassian.net"
  installed_user_key         "admin"
  plugins_version            "1.223.0"
  server_version             "100095"
  shared_secret              "NC8Ff5DPm/P02xunJAeAxt0mUvGaUO4cqgOM9gkTAOsyvzdjGgv8M46Re91ty8hocOGHcm0gmKzFqgrOG9ie5Q"
end