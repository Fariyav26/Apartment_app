// including our own location on map
function placeMakers(dataFromServer, markers) {
  markers = handler.addMarkers(dataFromServer);
  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
}
// a marker identifies a lcoation on a map(red dot)
// we added markers as an agument because markers was undefined in the method.
function showLocations(dataFromServer, markers) {
  // we are setting our location to the end of the array of markers
  if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
      // Add our position to the collection of markers
      // dataFromServer is an array-->calling .length finds the end of the array and adds users location to the end so it wont replace already set locations
      dataFromServer[dataFromServer.length] = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        infowindow: "You!"
      };
      // takes the data from the server (locations of apartments) and users lcoation and sets markers on the map
      placeMakers(dataFromServer, markers);
    });
  } else {
      alert("Geolocation is not available.");
      placeMakers(dataFromServer, markers)
  }
}

function createGmap(dataFromServer, idOfMap) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: idOfMap}
    },
    function() {
      showLocations(dataFromServer);
    }
  );
};

// function createGmap(dataFromServer, idOfMap) {
//   handler = Gmaps.build('Google');
//   handler.buildMap({
//       provider: {},
//       // Tell Google in which element (div) to put the map
//       internal: {id: idOfMap}
//     },
//     function() {
//       markers = handler.addMarkers(dataFromServer);
//       handler.bounds.extendWith(markers);
//       handler.fitMapToBounds();
//     }
//   );
// };

function loadAndCreateGmap() {
  // Only load map data if we have a map on the page
  if ($('#apartment_map').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var apartmentId = $('#apartment_map').attr('data-apartment-id');

    $.ajax({
      dataType: 'json',
      url: '/apartments/' + apartmentId + '/map_location',
      method: 'GET',
      success: function(dataFromServer) {
        createGmap(dataFromServer, "apartment_map");
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

// Create the map when the page loads the first time
$(document).on('ready', loadAndCreateGmap);
// Create the map when the contents is loaded using turbolinks
// To be 'turbolinks:load' in Rails 5
$(document).on('page:load', loadAndCreateGmap);
// To be 'turbolinks:load' in Rails 4
$(document).on('turbolinks:load', loadAndCreateGmap);

// below is where we add the map to the homepage
function createGmapAll(dataFromServer) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: 'map_location_all'}
    },
    function() {
      markers = handler.addMarkers(dataFromServer);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
    }
  );
};

function loadAndCreateGmapAll() {
  // Only load map data if we have a map on the page
  if ($('#map_location_all').length > 0) {

    $.ajax({
      dataType: 'json',
      //took out apartment id because we want to view all of the locations listed
      url: '/apartments/map_location_all',
      method: 'GET',
      success: function(dataFromServer) {
        createGmap(dataFromServer, "map_location_all");
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

// Create the map when the page loads the first time
$(document).on('ready', loadAndCreateGmapAll);
// Create the map when the contents is loaded using turbolinks
// To be 'turbolinks:load' in Rails 5
$(document).on('page:load', loadAndCreateGmapAll);
// To be 'turbolinks:load' in Rails 4
$(document).on('turbolinks:load', loadAndCreateGmapAll);
