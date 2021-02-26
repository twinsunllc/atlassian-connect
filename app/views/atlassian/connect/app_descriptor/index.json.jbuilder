json.apiVersion @config.api_version if @config.api_version.present?

json.authentication do
  json.type 'jwt'
end

json.baseUrl request.base_url
json.description @config.description if @config.description.present?
json.enableLicensing @config.enable_licensing
json.key @config.key

json.lifecycle do
  json.disabled atlassian_connect.disabled_lifecycle_index_path
  json.enabled atlassian_connect.enabled_lifecycle_index_path
  json.installed atlassian_connect.installed_lifecycle_index_path
  json.uninstalled atlassian_connect.uninstalled_lifecycle_index_path
end

json.links @config.links if @config.links.present?
json.name @config.name
json.modules @config.modules
json.scopes @config.scopes

json.vendor do
  json.name @config.vendor_name if @config.vendor_name.present?
  json.url @config.vendor_url if @config.vendor_url.present?
end
