$(document).ready(function($) {

      if (window.history && window.history.pushState) {

        $(window).on('popstate', function() {
          var hashLocation = location.hash;
          var hashSplit = hashLocation.split("#!/");
          var hashName = hashSplit[1];

          if (hashName !== '') {
            var hash = window.location.hash;
            if (hash === '') {
              alert('Warning! Do not press the back button! This can cause data duplication and errors.');
                //window.location='/orders/';
                return false;
            }
          }
        });

        window.history.pushState('forward', null, './#forward');
      }

    });