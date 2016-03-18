new Rule({
    condition: function() {
        return window.loggedIn === true;
    },
    load: function() {
        var reportPosition = function() {
            navigator.geolocation.getCurrentPosition(function(position) {
                $.ajax({
                    url: '/locations',
                    type: 'POST',
                    data: {
                        'location': {
                            latitude: position.coords.latitude,
                            longitude: position.coords.longitude,
                        }
                    }
                });
            });
        };

        setInterval(reportPosition, 30000);
    }
});
