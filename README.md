## NAME

WWW::PTV - Perl interface to Public Transport Victoria (PTV) Website.

## SYNOPSIS

    use WWW::PTV;

    my $ptv = WWW::PTV->new( cache => 1 );

    # Return a WWW::PTV::Route object for route ID 1
    my $route = $ptv->get_route_by_id(1);

    # Print the route name and outbound description
    print $route->name .":". $route->description ."\n";

    # Get the route outbound timetable as a WWW::PTV::TimeTable object
    my $tt = $route->get_outbound_tt;

    # Get the route stop names and IDs as a hash in the inbound direction
    my %stops = $route->get_stop_names_and_ids( 'in' );
    

## METHODS

### new ( cache => BOOLEAN )

Constructor method - creates a new WWW::PTV object.  This method accepts an
optional hashref specifying a single valid parameter; _cache_, which if
set to a true value will enable internal object caching.

The default behaviour is not to implement any caching, however it is strongly
recommended that you enable caching in most implementations.  Caching will
dramatically improve the performance of repeated method invocations and
reduce network utilisation, but will increase memory requirements.

You may also selectively enable or disable the cache after invoking the
constructor via the __cache__ and __nocache__ methods.

See the [CACHING](https://metacpan.org/pod/CACHING) section for more information.

### cache

Enables internal object caching.  See the [CACHING](https://metacpan.org/pod/CACHING) section for more details.

### nocache

Enables internal object caching.  See the [CACHING](https://metacpan.org/pod/CACHING) section for more details.

### get\_metropolitan\_bus\_routes

Returns a hash containing all metropolitan bus routes indexed by the bus route ID.

__Please note__ that the bus route ID is not the same as the bus route ID that may be
used to identify the service by the service operator - the ID used in this module refers
to the unique ID assigned to the route within the context of the PTV website.

	my %routes = $ptv->get_metropolitan_bus_routes;
	map { printf( "%-6s: %-50s\n", $_, $routes{ $_ } } sort keys %routes;

	# Prints a list of all metropolitan bus route IDs and names. e.g.
	# 1000  : 814 - Springvale South - Dandenong via Waverley Gardens Shopping Centre, Springvale
	# 1001  : 815 - Dandenong - Noble Park                      
	# 1003  : 821 - Southland - Clayton via Heatherton 
	# ... etc.

### get\_regional\_bus\_routes

Returns a hash containing all regional bus routes indexed by the bus route ID.

__Please note__ that the bus route ID is the PTV designated ID for the route and not
the service operator ID.

	my %routes = $ptv->get_regional_bus_routes;

	while (( $id, $desc ) = each %routes ) {
		print "$id : $desc\n" if ( $desc =~ /Echuca/ )
	}

	# Prints a list of regional bus routes containing 'Echuca' in the route name - e.g.
	# 1346 : Echuca - Moama (Route 3 - Circular)
	# 1345 : Echuca - Echuca East (Route 2 - Circular)
	# 6649 : Kerang - Echuca via Cohuna (Effective from 18/11/2012)
	# ... etc.

### get\_metropolitan\_tram\_routes

Returns a hash containing all metropolitan tram routes indexed by the route ID.

__Please note__ as per the method above, the route ID is the PTV designated route
and not the service operator ID.

### get\_metropolitan\_train\_routes

Returns a hash containing all metropolitan train routes indexed by the route ID.

__Please note__ as per the method above, the route ID is the PTV designated route
and not the service operator ID.

### get\_vline\_bus\_routes

Returns a hash containing all V/Line bus routes indexed by the route ID.

__Please note__ as per the method above, the route ID is the PTV designated route
and not the service operator ID.

### get\_vline\_train\_routes

Returns a hash containing all V/Line train routes indexed by the route ID.

__Please note__ as per the method above, the route ID is the PTV designated route
and not the service operator ID.

### get\_route\_by\_id

	my $route = $ptv->get_route_by_id( 1 );

	print $route->direction_out."\n".$route_description."\n";
	# Prints the outbound route direction ("To Alamein") and a 
	# description of the outbound route

Returns a [WWW::PTV::Route](https://metacpan.org/pod/WWW::PTV::Route) object for the given route ID representing a transit route.

__Note that__ the route ID is not the service operator route ID, but is the PTV route
ID as obtained from one of the other methods in this class.

See the [WWW::PTV::Route](https://metacpan.org/pod/WWW::PTV::Route) page for more detail.

### get\_stop\_by\_id ( $ID )

Returns the stop identified by the numerical parameter $ID as a [WWW::PTV::Stop](https://metacpan.org/pod/WWW::PTV::Stop)
object.  The numerical identifier of a stop is unique.

### get\_local\_areas

Returns a hash containing the defined "local areas" and a URI to the local area web page.
The hash is indexed by the local area name.

### get\_area\_by\_id ( $ID ) 

Returns the area identified by the numerical parameter $ID as a [WWW::PTV::Area](https://metacpan.org/pod/WWW::PTV::Area) object.

## CACHING

It is strongly recommended that you enable caching in the constructor invocation 
using the optional _cache_ argument.  Caching is not enabled by default to 
align with the principle of least surprise, however it is most likely that you 
will want to enable it to improve the performance of your program and to reduce 
the number ofrequests to the PTV website.

If you do not enable caching, then you may wish to consider storing any 
retrieved objects locally (e.g. in a database), or attempting to limit the 
frequency, or number, of methods invocations.

Note that you can also disable the cache for selective method invocations by
invoking the __no\_cache__ method prior to method invocation, and then re-enable
the cache (which will also restore the content of the cache prior to the 
invocation of the nocache method) with the __cache__ method.

	# Disable cache
	$ptv->nocache;

	$ptv->get_stop_by_id( $id );

	# Re-enable cache
	$ptv->cache;



## SEE ALSO

[WWW::PTV::Area](https://metacpan.org/pod/WWW::PTV::Area)
[WWW::PTV::Route](https://metacpan.org/pod/WWW::PTV::Route)
[WWW::PTV::Stop](https://metacpan.org/pod/WWW::PTV::Stop)
[WWW::PTV::TimeTable](https://metacpan.org/pod/WWW::PTV::TimeTable)
[WWW::PTV::TimeTable::Schedule](https://metacpan.org/pod/WWW::PTV::TimeTable::Schedule)

## AUTHOR

Luke Poskitt, `<ltp at cpan.org>`

## BUGS

Please report any bugs or feature requests to `bug-www-ptv at rt.cpan.org`, or 
through the web interface at [http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-PTV](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-PTV).  
I will be notified, and then you'll automatically be notified of progress on 
your bug as I make changes.



## SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::PTV



You can also look for information at:

- RT: CPAN's request tracker

    [http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-PTV](http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-PTV)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/WWW-PTV](http://annocpan.org/dist/WWW-PTV)

- CPAN Ratings

    [http://cpanratings.perl.org/d/WWW-PTV](http://cpanratings.perl.org/d/WWW-PTV)

- Search CPAN

    [http://search.cpan.org/dist/WWW-PTV/](http://search.cpan.org/dist/WWW-PTV/)


## LICENSE AND COPYRIGHT

Copyright 2012 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


