new Rule({
    condition: function() {
        return $('#map').length;
    },
    load: function() {
        var helper = {};

        helper.getPosition = function() {
            navigator.geolocation.getCurrentPosition(function(position) {
                var mapPosition = new google.maps.LatLng(position.coords.latitude, position.coords.longitude),
                    map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 16,
                        center: mapPosition,
                        panControl: true,
                        zoomControl: true,
                        scaleControl: true,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    }),
                    optionsMarker = {
                        map: map,
                        position: mapPosition,
                        draggable: true,
                        title: 'Milonga'
                    },
                    marker = new google.maps.Marker(optionsMarker);

                google.maps.event.addListener(marker, 'dragend', function() {
                    // Get the Current position, where the pointer was dropped
                    var point = marker.getPosition();
                    // Center the map at given point
                    map.panTo(point);
                    // Update the textbox
                    console.log("movido a:")
                    console.log(point.lat())
                    console.log(point.lng())
                });
            });
        };

        $(document).on('ready', helper.getPosition);
    }
})