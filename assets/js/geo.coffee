# check for online or offline?
# setInterval(function () {
#   statusElem.className = navigator.onLine ? 'online' : 'offline';
#   statusElem.innerHTML = navigator.onLine ? 'online' : 'offline';
# }, 250);

#navigator.onLine ? on : off
success = (position) ->

  #var s = document.querySelector('#status');

  # if (s.className == 'success') {
  #   // not sure why we're hitting this twice in FF, I think it's to do with a cached result coming back
  #   return;
  # }

  # s.innerHTML = "found you!";
  # s.className = 'success';
  mapcanvas = document.createElement("div")
  mapcanvas.id = "mapcanvas"
  mapcanvas.style.height = "310px"
  mapcanvas.style.width = "300px"
  document.querySelector("article").appendChild mapcanvas

  lat = position.coords.latitude
  long = position.coords.longitude
  accuracy = position.coords.accuracy

  geo_info = "lat: " + lat + ", long: " + long + ", accuracy:" + accuracy
  $("#geo_location").html geo_info
  latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
  myOptions =
    zoom: 15
    center: latlng
    mapTypeControl: false
    navigationControlOptions:
      style: google.maps.NavigationControlStyle.SMALL

    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("mapcanvas"), myOptions)
  marker = new google.maps.Marker(
    position: latlng
    map: map
    title: "You are here! (at least within a " + position.coords.accuracy + " meter radius)"
  )
error = (msg) ->
  console.log 'error: ', msg

if navigator.geolocation
  navigator.geolocation.watchPosition success, error, {
    enableHighAccuracy: true,
    maximumAge: 5000
  }
else
  error "not supported"

# var s = document.querySelector('#status');
# s.innerHTML = typeof msg == 'string' ? msg : "failed";
# s.className = 'fail';

# console.log(arguments);