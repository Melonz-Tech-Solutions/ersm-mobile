'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "4f610bd91dfe7aef77ea678c4ae99390",
"index.html": "034eb19498b883e5a66f9fd6f648c562",
"/": "034eb19498b883e5a66f9fd6f648c562",
"main.dart.js": "95039f1c5525693e259ddd2bffd7633c",
"sqlite3.wasm": "49588e095d647b075618511da0168b2b",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "e708e0290b513ccf44b1315c823e8756",
"assets/AssetManifest.json": "8be9bf49a5367534aa3c739f35c515d6",
"assets/NOTICES": "c9d625a16a81b46cfb4fa44ee0308361",
"assets/FontManifest.json": "1b1e7812d9eb9f666db8444d7dde1b20",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "e9f2f143310604845f8aa26c42ad5f55",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "d6a1c21e3b387860fa41cd125f0fc690",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/disaster_preparedness/fire2.jpg": "820686c57b6db707bee0cb0d579403ee",
"assets/assets/images/disaster_preparedness/fire1.jpg": "6af195d4dd1e91452783cf8d93adffb3",
"assets/assets/images/disaster_preparedness/shooting1.jpg": "01140a535cf15f34af1400e74e8533d0",
"assets/assets/images/disaster_preparedness/shooting2.jpg": "2f0b332becc11c9e41cb97fa76a38efa",
"assets/assets/images/disaster_preparedness/shooting3.jpg": "8386a161c9520103e3a38a9dd6057554",
"assets/assets/images/disaster_preparedness/terrorism.jpg": "0825c1086199aa4047278f64de0deb38",
"assets/assets/images/disaster_preparedness/emergency.jpg": "ec18e498a242ea60703071e8e7cec6ab",
"assets/assets/images/disaster_preparedness/typhoon1.jpg": "792c9909d524ff678d7073d34af578bc",
"assets/assets/images/disaster_preparedness/earthquake1.jpg": "ce1ce44763288c5465505f64359bcf11",
"assets/assets/images/disaster_preparedness/typhoon2.jpg": "c48b288b3661ebccb121ff6dff881d14",
"assets/assets/images/disaster_preparedness/earthquake2.jpg": "4688cdf9e08a5a8dd8df204fac98f80f",
"assets/assets/images/disaster_preparedness/earthquake3.jpg": "689e67c813e5866c655e566f0cfb0906",
"assets/assets/images/disaster_preparedness/typhoon3.jpg": "073d63e818c5b14bd5091fb93b0c03aa",
"assets/assets/images/disaster_preparedness/storm3.jpg": "234d9eb12861ac410bce002cb085505e",
"assets/assets/images/disaster_preparedness/storm2.jpg": "4322dd8968f1cd8faf0ae22b55549e38",
"assets/assets/images/disaster_preparedness/storm1.jpg": "404e00d59c1c33bc72255ae66ad77b96",
"assets/assets/images/disaster_preparedness/flood3.jpg": "11946a3a050d98fc88200dc85510ee3c",
"assets/assets/images/disaster_preparedness/tsunami1.jpg": "d5e49ea768d2cd91bfddbd2ed014f600",
"assets/assets/images/disaster_preparedness/flood2.jpg": "54aebd138af81552c5a420a0217cc479",
"assets/assets/images/disaster_preparedness/tsunami2.jpg": "71693a12b801ff0bd80179b42f3ae294",
"assets/assets/images/disaster_preparedness/tsunami3.jpg": "d6b8e212669094d2f6a08ca6b444bf8c",
"assets/assets/images/disaster_preparedness/flood1.jpg": "b47d565767346e0d47c968a752c782ed",
"assets/assets/images/disaster_preparedness/landslide2.jpg": "f5f0d44e7c736f51b37681bfba76823b",
"assets/assets/images/disaster_preparedness/landslide3.jpg": "2d096c85227fc5f258b4b492d05e64b7",
"assets/assets/images/disaster_preparedness/landslide1.jpg": "73053d52079c212473c910af217308f9",
"assets/assets/images/first_aid/choking.jpg": "bcc897a6fdc81ecc2edc43e6f0bc1a56",
"assets/assets/images/first_aid/heatstroke.jpg": "62eda4918e021f50c2a65876dd79c4e1",
"assets/assets/images/first_aid/broken1.jpg": "bb5abdfb4e3c373c259147be3616ff29",
"assets/assets/images/first_aid/stroke2.jpg": "f2d0d2459a4f541c037bc87f56588075",
"assets/assets/images/first_aid/broken2.jpg": "3b1ba47fc258401e31f5606b4f600e55",
"assets/assets/images/first_aid/broken3.jpg": "19c70c5f9a21a7eca830163ee60121da",
"assets/assets/images/first_aid/stroke1.jpg": "a8476ae508b2ae919d53a0d30b835f72",
"assets/assets/images/first_aid/drowning.jpg": "3ae0d7d91984ae787f3ab2c0db17fc8b",
"assets/assets/images/first_aid/bleeding4.jpg": "ba2e0514b0d6dba091dbc58265934978",
"assets/assets/images/first_aid/bleeding1.jpg": "7e99ab4e8e17e74be2a51d72a1e14a26",
"assets/assets/images/first_aid/bleeding3.jpg": "c58aaf2473f14072febb2a2973b040cb",
"assets/assets/images/first_aid/bleeding2.jpg": "6e1ee175738fb60b2e3d75d67d377621",
"assets/assets/images/first_aid/cpr1.jpg": "d863e844773918ca3461551120ebbfde",
"assets/assets/images/first_aid/kit.jpg": "ec18e498a242ea60703071e8e7cec6ab",
"assets/assets/images/first_aid/cpr2.jpg": "e688c816cfad0219e0351fe512645b37",
"assets/assets/images/first_aid/burn1.jpg": "f5184a4f251cd819855bfd9252e9e324",
"assets/assets/images/first_aid/burn2.jpg": "2e997f0d6abc21adc2a83f554f93c2a6",
"assets/assets/images/first_aid/snake.jpg": "c46b167e4e4852019ea454ba67619034",
"assets/assets/images/first_aid/burn3.jpg": "6cad81941503004815f5c7e51e1a3137",
"assets/assets/images/logo.png": "a19a1d7092e36cb28769a0e2ad67d8ef",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
