function getMaps() {
    var api = "AIzaSyDiPv6sSKzmOR1INjC_9kHxUY6bpwKOXHc";
    var map;
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        zoom: 15
    };
    var image = 'icon.png';
    var locations = [
        ["Campus GKG", "Graaf Karel de Goedelaan 5", "8500", "Kortrijk", "Belgium", "1"],
        ["Campus RDR", "Renaat de Rudderlaan 6", "8500", "Kortrijk", "Belgium", "2"],
        ["Campus The Level", "Botenkopersstraat 2", "8500", "Kortrijk", "Belgium", '2'],
        ["Campus Rijselstraat", "Rijselstraat 5", "8200", "Brugge", "Belgium", "1"],
        ["Campus Sint-Jorisstraat", "Sint-Jorisstraat 71", "8000", "Brugge", "Belgium", "2"]
    ];
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    function getJSONData() {
        for (var i = 0; i < locations.length; i++) {
            var urlForLatAndLong = "https://maps.googleapis.com/maps/api/geocode/json?address=" + locations[i][1] + "+" + locations[i][3] + "+" + locations[i][4] + "&key=" + api;
            $.ajax({
                url: urlForLatAndLong,
                dataType: 'json',
                async: false,
                success: function (data) {
                    var lat = data["results"][0]["geometry"]["location"]["lat"];
                    var long = data["results"][0]["geometry"]["location"]["lng"];
                    showOnMap(lat, long, i);
                }
            });
        }
    }

    function showOnMap(lat, long, i) {
        var myLatLng = new google.maps.LatLng(lat, long);
        bounds.extend(myLatLng);
        /*if (locations[i][5] == 1) {
         image = "icon.png";
         } else {
         image = "icon2.png";
         }*/
        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            //icon: image
        });
        var infoWindow = new google.maps.InfoWindow(), marker, i;
        google.maps.event.addListener(marker, 'click', (function (marker, i) {
            return function () {
                var content = "<div id='content'>" +
                    "<h1>" + locations[i][0] + "</h1>" +
                    "<p><i>" + locations[i][1] + "<br />" +
                    locations[i][2] + " " + locations[i][3] + "</i></p>" +
                    "</div>";
                infoWindow.setContent(content);
                infoWindow.open(map, marker);
            }
        })(marker, i));
        map.fitBounds(bounds);


        /*google.maps.event.addListener(marker, "click", function () {
         infoField.open(map, marker);
         });*/
    }

    google.maps.event.addDomListener(window, 'load', getJSONData);
};