# Foody

The idea is to identify food trucks in San Francisco which are closest to your location.

The application accepts a latitude and longitude (presumably in San Francisco) in decimal format
and calculates the distance and bearing from that point to each of the food
trucks listed at the following url:

"https://data.sfgov.org/resource/rqzj-sfat.json"

## Obtaining Latitude and Longitude

Latitude and longitude may be obtained by right clicking a location in Google
maps.

## Filtering

Data is filtered by vendors whos status is approved.
It is assumed that other vendors are not actively operating.

