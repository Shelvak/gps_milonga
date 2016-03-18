new Rule({
    load: function() {
        var arriveNotification = function(e) {
            e.preventDefault();
            $.ajax({
                url: '/groups/' + window.mapConfigs.groupId + '/arrive',
                type: 'PUT'
            });

        }

        $(document).on('click', '.arrive-button', arriveNotification)

        $(document).on('ready', function() {
            if ('serviceWorker' in navigator) {
                console.log('Service Worker is supported');
                navigator.serviceWorker.register('/serviceworker.js').then(function(reg) {
                    console.log('Service Worker is ready :^)', reg);
                    reg.pushManager.subscribe({userVisibleOnly: true}).then(function(sub) {
                        $.ajax({
                            url: '/api/subscription',
                            type: 'POST',
                            data: {
                                'subscription': {
                                    endpoint: sub.endpoint
                                }
                            }
                        });
                    });
                }).catch(function(error) {
                    console.log('Service Worker error :^(', error);
                });
            }
        });
    }
})
