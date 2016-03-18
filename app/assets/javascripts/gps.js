new Rule({
    condition: function() {
        return window.loggedIn === true;
    },
    load: function() {
        var reportPosition = function(isNotification) {
            isNotification = isNotification || false
            navigator.geolocation.getCurrentPosition(function(position) {
                $.ajax({
                    url: '/locations',
                    type: 'POST',
                    data: {
                        'location': {
                            latitude: position.coords.latitude,
                            longitude: position.coords.longitude,
                            notification: isNotification
                        }
                    }
                });
            });
        };

        setInterval(reportPosition, 30000);

        var notify = function() {
            reportPosition(true);
        }

        $(document).on('click', '.notify-friends', notify);
    }
});
