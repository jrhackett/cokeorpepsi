# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder

  #override create_marker method
  #create_marker: ->
    #options = _.extend @marker_options(), @rich_marker_options()
    #@serviceObject = new RichMarker options #assign marker to @serviceObject

  #rich_marker_options: ->
   # marker = document.createElement("div")
    #marker.setAttribute 'class', 'marker_container'
    #marker.innerHTML = @args.title
    #{ content: marker }

  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute('class', 'marker_container') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

    # add @bind_infowindow() for < 2.1

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, 0)
    boxStyle:
      width: "280px"

@buildMap = (markers) ->
	handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} } #dependency injection

	mapStyle = [{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2f2f2"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#eaebe1"},{"saturation":"-8"}]},{"featureType":"landscape","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"landscape.natural.landcover","elementType":"geometry.fill","stylers":[{"gamma":"0.00"},{"weight":"5.96"},{"visibility":"simplified"}]},{"featureType":"landscape.natural.landcover","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"landscape.natural.terrain","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry","stylers":[{"visibility":"simplified"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry.fill","stylers":[{"visibility":"simplified"}]},{"featureType":"landscape.natural.terrain","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#0c3853"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#1e4f6e"},{"visibility":"on"},{"lightness":"0"},{"saturation":"0"},{"gamma":"1"}]}];

	#then standard use
	handler.buildMap { provider: {styles: mapStyle}, internal: {id: 'map'} }, ->
	  markers = handler.addMarkers(markers)
	  handler.bounds.extendWith(markers)
	  handler.fitMapToBounds()


