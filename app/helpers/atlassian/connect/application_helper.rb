module Atlassian
  module Connect
    module ApplicationHelper
      def atlassian_connect_scripts
        scripts = <<-SCRIPTS
          <script src="https://connect-cdn.atl-paas.net/all.js" data-options="sizeToParent:true;resize:false"></script>
          <script type="text/javascript">
              function navigateToModule(moduleKey, context) {
                  AP.navigator.go('addonModule', {
                      addonKey: '<%= Atlassian::Connect.configuration.key %>',
                      moduleKey: moduleKey,
                      context: context || {}
                  });
        
                  return false;
              }
        
              (function() {
                  $('form').attr('action', function(index, action) {
                      return action + '?&request_identifier=APP_INSTALL_ID';
                  });
              })();
          </script>
        SCRIPTS
        return scripts.sub('APP_INSTALL_ID', @app_install.present? ? @app_install.id.to_s : '').html_safe
      end
    end
  end
end
