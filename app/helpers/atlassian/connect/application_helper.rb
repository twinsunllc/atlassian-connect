module Atlassian
  module Connect
    module ApplicationHelper
      def atlassian_connect_scripts
        scripts = <<-SCRIPTS
          <script src="https://connect-cdn.atl-paas.net/all.js" data-options="sizeToParent:true;resize:false"></script>
          <script type="text/javascript">
            function navigateToModule(moduleKey, context) {
              AP.navigator.go('addonModule', {
                addonKey: 'APP_KEY',
                moduleKey: moduleKey,
                context: context || {}
              });
    
              return false;
            }
            
            var callback = function(){
              var forms = document.querySelectorAll('form'), i;
              for (i = 0; i < forms.length; ++i) {
                forms[i].setAttribute('action', forms[i].getAttribute('action') + '?&request_identifier=REQUEST_ID');
              }
            };
            
            // https://www.sitepoint.com/jquery-document-ready-plain-javascript/
            if (
              document.readyState === "complete" ||
              (document.readyState !== "loading" && !document.documentElement.doScroll)
            ) {
              callback();
            } else {
              document.addEventListener("DOMContentLoaded", callback);
            }
          </script>
        SCRIPTS

        scripts = scripts.sub('APP_KEY', Atlassian::Connect.configuration.key)
        scripts = scripts.sub('REQUEST_ID', @app_install.present? ? @app_install.generate_request_id : '')

        return scripts.html_safe
      end
    end
  end
end
