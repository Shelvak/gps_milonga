console.log('llamada a worker service')
console.log('Started', self);

self.addEventListener('install', function(event) {
  self.skipWaiting();
  console.log('Installed', event);
});

self.addEventListener('activate', function(event) {
  console.log('Activated', event);
});

self.addEventListener('push', function(event) {
    console.log('Received a push message', event);

    var title = 'Someone arrived.';
    var body = 'One of your friends is already in the meeting point.';
    var icon = '/images/icon-192x192.png';
    var tag = 'simple-push-demo-notification-tag';

    event.waitUntil(
            this.registration.showNotification(title, {
                body: body,
                icon: icon,
                tag: tag
            })
            );
});
console.log('saliendo a worker service')
