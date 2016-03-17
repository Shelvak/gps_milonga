new Rule({
    condition: function() {
        return $('#map').length;
    },
    load: function() {
        var helper = {},
            configs = {
                groupId: 1, // just to test
                locations: {},
            };

        helper.addPoint = function (map, mapPosition, draggable, title) {
            var optionsMarker = {
                    map: map,
                    position: mapPosition,
                    draggable: draggable,
                    title: title,
                    label: title
                },
                infoWindow = new google.maps.InfoWindow({
                    content: title
                }),
                marker = new google.maps.Marker(optionsMarker);

            marker.addListener('click', function() {
                infoWindow.open(map, marker);
            });

            return marker;
        };

        helper.populateWithNewPoints = function (response) {
            if (response.status === 200) {
                _.each(response.responseJSON, function(element) {
                    console.log("analizando...")
                    console.log(element)
                    position = [element.latitude, element.longitude]
                    if (element.id in configs.locations) {
                        if (!_.isEqual(configs.locations[element.id].lastPosition, position)) {
                            newPosition = new google.maps.LatLng(position[0], position[1]);
                            configs.locations[element.id].marker.setPosition(newPosition);
                            configs.locations[element.id].lastPosition = position;
                        }
                    } else {
                        mapPosition = new google.maps.LatLng(element.latitude, element.longitude)
                        marker = helper.addPoint(configs.map, mapPosition, false, element.title);

                        configs.locations[element.id] = {
                            lastPosition: position,
                            marker: marker
                        };
                    }
                });
            }
        }

        helper.askForNewFriends = function () {
            $.ajax({
                url: '/groups/' + configs.groupId + '/near_people',
                type: 'GET',
                dataType: 'JSON',
                complete: helper.populateWithNewPoints
            });
        };

        helper.setPointValues = function(point) {
            var lat = $('#group_latitude'),
                lon = $('#group_longitude');

            if (lat.length && lon.length) {
                lat.val(point.lat());
                lon.val(point.lng());
            }
        };

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
                    marker = helper.addPoint(map, mapPosition, true, 'MilongaPlace');

                configs.map = map;
                configs.mapPosition = mapPosition;
                google.maps.event.addListener(marker, 'dragend', function() {
                    // Get the Current position, where the pointer was dropped
                    var point = marker.getPosition();
                    // Center the map at given point
                    map.panTo(point);
                    // Update the textbox
                    helper.setPointValues(point);
                });
            });
        };

        $(document).on('ready', helper.getPosition);
        setInterval(helper.askForNewFriends, 10000);
    }
})
