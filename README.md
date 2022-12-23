# Foody

Using the San Francisco food truck data provided the idea is to calculate which trucks are closest to a specific location.

The application accepts a latitude and longitude (presumably in San Francisco) in decimal format
and calculates the distance and bearing from that point to each of the active food
trucks listed at the following url:

[Mobile Food Facility Permit](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data)

## Obtaining Latitude and Longitude

Latitude and longitude may be obtained by right clicking a location in Google
maps.

Ideally one would be chosen within San Francisco amonst the field of food trucks.

## Filtering

Input data is filtered by vendors whose status is approved.
It is assumed that other vendors are not actively operating.

## Sorting

Output is sorted by distance from the point that was input.
Some data does not have latitude and longitude and so those entries appear at the top of the list with distance and bearing of zero.

## Geo Calculations

The calculations for distance and bearing were obtainied using the following resources:

[Movable Type Scripts](http://www.movable-type.co.uk/scripts/latlong.html)

and

[Ed Williams Aviation Formulary](http://edwilliams.org/avform147.htm)

## Getting Started

Clone the repository as follows:

```bash
git clone https://github.com/LatitudeAdjustment/foody.git
```

From the base folder get and compile dependencies.

```bash
$ cd foody
$ mix deps.get
```

Compile dependencies

```bash
mix deps.compile
```

## Tests

Run mix test to execute the tests.

```bash
mix test
```

## Running the Program

Build the CLI executable.

From the base folder, type the following:

```bash
mix escript.build
```

Enter the name of the program and a point in latitude and longitude.

Here is an example of running the program with a point which is within the field of food trucks.

```bash
./foody --lat 37.7574 --lon -122.4377
```

## Conclusions

The data provided is based on permit assignment and is probably not very useful for determining the location of the food trucks.
A better solution would be to use real-time data from the trucks themselves.
<br/>
Getting the distance and bearing calculations to work properly took considerably more time than expected.
<br/>
I would have liked to write more tests and do some additional refactoring.