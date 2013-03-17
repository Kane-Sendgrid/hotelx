if (navigator.geolocation)
  navigator.geolocation.getCurrentPosition(success, error)
else
  error('not supported')

success(position) ->
  s = document.querySelector('#status')

  if (s.className == 'success')
	return

  s.innerHTML = "found you!"
  s.className = 'success'

  mapcanvas = document.createElement('div')
  mapcanvas.id = 'mapcanvas'
  mapcanvas.style.height = '400px'
  mapcanvas.style.width = '560px'

  document.querySelector('article').appendChild(mapcanvas)

  latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)

  myOptions = {
    zoom: 15,
    center: latlng,
    mapTypeControl: false,
    navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  map = new google.maps.Map(document.getElementById("mapcanvas"), myOptions)

  marker = new google.maps.Marker({
      position: latlng,
      map: map,
      title:"You are here! (at least within a "+position.coords.accuracy+" meter radius)"
  })

error(msg) ->
  s = document.querySelector('#status')
  s.innerHTML = typeof msg == 'string' ? msg : "failed"
  s.className = 'fail'