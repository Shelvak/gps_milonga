new Rule({
    load: function() {
        var isPushEnabled = false;

        if ('serviceWorker' in navigator) {
            console.log('Service Worker is supported');
            navigator.serviceWorker.register('/serviceworker.js').then(function(reg) {
                console.log('Service Worker is ready :^)', reg);
                reg.pushManager.subscribe({userVisibleOnly: true}).then(function(sub) {
                    console.log('endpoint:')
                    console.log(sub);
                    console.log(sub.endpoint);
                });
            }).catch(function(error) {
    console.log('Service Worker error :^(', error);
            });
        }
    }
})
