'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "2a9eb902ba4d37ba866b6ea973d6b6da",
"assets/AssetManifest.bin.json": "ff65a5aa47dabd5d6c9390e702fb903a",
"assets/AssetManifest.json": "7d0d4d9c82b8296b3cdf21c9ed40d6e2",
"assets/assets/animation/home/Solid_DarkCyan.json": "9ff4ccf2d637d0fd0ff98a18da5e9b01",
"assets/assets/animation/home/Solid_DarkOrange.json": "0683b5e56083ba4c91006243c4404268",
"assets/assets/animation/home/Solid_DarkOrchid.json": "b9886ecedcf14009c2f129c747bda8f1",
"assets/assets/animation/home/Solid_defult.json": "048766d5e819817dbaffab0a2d375888",
"assets/assets/animation/home/Solid_Gold.json": "3854763768e1e755c0ce51d747e63066",
"assets/assets/animation/home/Solid_Grey.json": "813997d7afd044c2b2c600a4c9930ea0",
"assets/assets/animation/home/Solid_HotPink.json": "85e43410f83bc5dd0c6ab3e6a9a96892",
"assets/assets/animation/home/Solid_Red.json": "c3cd616aa481854a71280acd2c1b8fe6",
"assets/assets/animation/home/Solid_SlateBlue.json": "6da67cf277881d065b42b794bfb849ef",
"assets/assets/animation/home/Solid_Teal.json": "e1e82a984e905c49c78907bd7b3828b5",
"assets/assets/animation/splash/animation.json": "8d76b5be3d29a4b5503684fe54c0c52a",
"assets/assets/fonts/iranYekan/IRANYekanMobileBlack.ttf": "c11210adb359d1c7c430801d155e78e4",
"assets/assets/fonts/iranYekan/IRANYekanMobileBold.ttf": "686e6fe71aee810f04034bd9e5a65a71",
"assets/assets/fonts/iranYekan/IRANYekanMobileExtraBold.ttf": "94416ca9d72d010295d524f4c1d697d7",
"assets/assets/fonts/iranYekan/IRANYekanMobileLight.ttf": "a93ddbc3f848e74ceddd9534693c13aa",
"assets/assets/fonts/iranYekan/IRANYekanMobileMedium.ttf": "563e0c749bca9ecc57596712d5483c8a",
"assets/assets/fonts/iranYekan/IRANYekanMobileRegular.ttf": "2c58293edeb64bdb41bcc8fa6353515e",
"assets/assets/fonts/iranYekan/IRANYekanMobileThin.ttf": "c31d2fff0d8951a331a1775b4e1b02fc",
"assets/assets/img/icon/icon.png": "6186c9b08853ae55d743e1e68953a6ad",
"assets/assets/img/splash/splash.png": "964e276e23c6931dc888b17156f50b1f",
"assets/assets/img/theme/theme-1.jpg": "5e6230248fc8605fae1b1a8d51a34ca4",
"assets/assets/img/theme/theme-2.jpg": "30aeeb07f5916a75e03e4b6b626518da",
"assets/assets/img/theme/theme-3.jpg": "9dc04467d268fec5b2c569cf452ecf29",
"assets/assets/img/theme/theme-4.jpg": "ad37bec7e6a8879b072b79a536202ea0",
"assets/assets/img/theme/theme-5.jpg": "cadba1f92ecc82d6289558c33ca3f0dd",
"assets/assets/img/theme/theme-6.jpg": "2278d905654fb7c66b5e448dcd25476d",
"assets/FontManifest.json": "5cb1ef2398b59ad101b3f5b97b1f0dda",
"assets/fonts/MaterialIcons-Regular.otf": "24857f0e7d45dbad5cc11edab20d38fb",
"assets/NOTICES": "c0c912a049db08c164ac5888eb6ac665",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "75325622b0a6b6e83c3d1c23e0e25732",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "407ceb85ab1044b3b4b4a4f6c6766192",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "154bd0d5e39fe9bc0b3814eb8bc02697",
"/": "154bd0d5e39fe9bc0b3814eb8bc02697",
"main.dart.js": "ffe9ce530fbe35f957ad63fb81ba8529",
"manifest.json": "ef8d9014d9d1eb96ba763732f7f33450",
"splash/img/dark-1x.png": "b80c7ee714a0506e0430dcf1c1f02ca3",
"splash/img/dark-2x.png": "a34f3e8f71c3557600e8297a6fea0cad",
"splash/img/dark-3x.png": "e56006ca607bd53b133e11efbe985905",
"splash/img/dark-4x.png": "ad5790cc04e8b3e033ad5d3bd3a92b8b",
"splash/img/light-1x.png": "b80c7ee714a0506e0430dcf1c1f02ca3",
"splash/img/light-2x.png": "a34f3e8f71c3557600e8297a6fea0cad",
"splash/img/light-3x.png": "e56006ca607bd53b133e11efbe985905",
"splash/img/light-4x.png": "ad5790cc04e8b3e033ad5d3bd3a92b8b",
"version.json": "db3cdb49cf9bf4f788808b10a1524f08"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
