'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "973d5db91d5e96e70c60829b384c5e15",
"/main.dart.js": "d467c411c5cbef714f48fa87b6050a46",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/manifest.json": "24bbfef877ea4cea023d632582eaa609",
"/assets/LICENSE": "b9d10cc075a7b803c1ebc05ad195be8d",
"/assets/AssetManifest.json": "338fd7a051a451126e46ca3c319fd03f",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/assets/images/movie_01.png": "c8397bb501fb4a5c8018a93cd2f4f2bb"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
