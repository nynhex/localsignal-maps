(( $ ) ->
  $.fn.localSignalMaps = ->
    @.each ->
      $map = $ @
      google.maps.event.addDomListener window, 'load', ->
        ls_map = new google.maps.LatLng $map.data("map-lat"), $map.data("map-lng")
        map_type = 'custom_style'
        invert_map = if $map.data("map-light") == true
          -1
        else
          1

        invert_water = if $map.data("map-light-water") == true
          -1
        else
          1

        simple_opts = [
          {
            stylers: [
              { hue: $map.data("map-color") },
              { visibility: 'simplified' },
              { weight: 2.0 }
            ]
          },
          {
            featureType: 'water',
            stylers: [
              { color: $map.data("map-water") }
            ]
          },
          {
            featureType: "administrative.province",
            elementType: "geometry.stroke",
            stylers: [
              { visibility: "on" },
              { color: "#222222" },
              { weight: 2.3 }
            ]
          },
          {
            featureType: "administrative.locality",
            elementType: "labels.text",
            stylers: [
              { visibility: "on" },
              { color: "#111111" },
              { weight: 0.7 }
            ]
          },
          {
            featureType: "administrative.country",
            elementType: "geometry.stroke",
            stylers: [
              { visibility: "on" },
              { color: "#000000" },
              { weight: 3 }
            ]
          }
        ]

        feature_opts = [
          {
            stylers: [
              { color: $map.data("map-color") },
              { visibility: 'simplified' },
              { weight: 2.0 }
            ]
          },
          {
            elementType: 'labels.text.fill',
            stylers: [{lightness: 90 * invert_map}]
          },
          {
            featureType: 'road',
            elementType: 'geometry',
            stylers: [{lightness: 25 * invert_map}]
          },
          {
            featureType: 'water',
            elementType: 'geometry.fill',
            stylers: [{color: $map.data("map-water")}]
          },
          {
            featureType: 'water',
            elementType: 'labels.text.fill',
            stylers: [
              {lightness: 75 * invert_water},
            ]
          },
          {
            featureType: "administrative",
            elementType: "geometry",
            stylers: [ { visibility: "off" } ]
          },
          { featureType: "administrative.land_parcel", stylers: [ { visibility: "off" } ] },
          { featureType: "administrative.neighborhood", stylers: [ { visibility: "off" } ] },
          { featureType: "poi", stylers: [ { visibility: "off" } ] },
          {
            featureType: "road",
            elementType: "labels",
            stylers: [ { visibility: "off" } ]
          },
          {
            featureType: "road",
            elementType: "labels.icon",
            stylers: [ { visibility: "off" } ]
          },
          { featureType: "transit", stylers: [ { visibility: "off" } ] }
        ]

        map_options =
          zoom: $map.data("map-zoom")
          center: ls_map
          scrollwheel: false
          mapTypeControlOptions:
            mapTypeIds: [google.maps.MapTypeId.ROADMAP, map_type]
          mapTypeId: map_type
        map = new google.maps.Map $map[0], map_options
        styledMapOptions = name: 'Custom Style'
        marker = $map.data("map-marker")

        if marker?
          myntMarker = new google.maps.Marker
            position: ls_map
            map: map
            icon: marker
            title: 'LocalSignal Maps'

        final_opts = if $map.data("map-simple") == true
          simple_opts
        else
          feature_opts

        custom_map_type = new google.maps.StyledMapType final_opts, styledMapOptions
        map.mapTypes.set map_type, custom_map_type

    @

  $ ->
    $("[data-map-lat]").localSignalMaps()
) window.jQuery