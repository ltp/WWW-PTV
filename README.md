NAME
----
WWW::PTV - Perl interface to Public Transport Victoria (PTV) Website

VERSION
-------
Version 0.01

SYNOPSIS
--------
        use WWW::PTV;

        my $ptv = WWW::PTV->new;
    
METHODS
-------
*  new

Constructor method - creates a new WWW::PTV object.

*  get_metropolitan_bus_routes

Returns a hash containing all metropolitan bus routes indexed by the bus
route ID.

Please note that the bus route ID is not the same as the bus route ID
that may be used to identify the service by the service operator - the
ID used in this module refers to the unique ID assigned to the route
within the context of the PTV website.

	my %routes = $ptv->get_metropolitan_bus_routes;
	map { printf( "%-6s: %-50s\n", $_, $routes{ $_ } } sort keys %routes;

	# Prints a list of all metropolitan bus route IDs and names. e.g.
	# 1000  : 814 - Springvale South - Dandenong via Waverley Gardens Shopping Centre, Springvale
	# 1001  : 815 - Dandenong - Noble Park                      
	# 1003  : 821 - Southland - Clayton via Heatherton 
	# ... etc.

*  get_regional_bus_routes

Returns a hash containing all regional bus routes indexed by the bus
route ID.

Please note that the bus route ID is the PTV designated ID for the route
and not the service operator ID.

	my %routes = $ptv->get_regional_bus_routes;

	while (( $id, $desc ) = each %routes ) {
	    print "$id : $desc\n" if ( $desc =~ /Echuca/ )
	}

	# Prints a list of regional bus routes containing 'Echuca' in the route name - e.g.
	# 1346 : Echuca - Moama (Route 3 - Circular)
	# 1345 : Echuca - Echuca East (Route 2 - Circular)
	# 6649 : Kerang - Echuca via Cohuna (Effective from 18/11/2012)
	# ... etc.

*  get_metropolitan_tram_routes

Returns a hash containing all metropolitan tram routes indexed by the
route ID.

PLease note as per the method above, the route ID is the PTV designated
route and not the service operator ID.

*  get_metropolitan_train_routes

Returns a hash containing all metropolitan train routes indexed by the
route ID.

Please note as per the method above, the route ID is the PTV designated
route and not the service operator ID.

*  get_route_by_id
 
	my $route = $ptv->get_route_by_id( 1 );

	print $route->direction_out."\n".$route_description."\n";
	# Prints the outbound route direction ("To Alamein") and a 
	# description of the outbound route

Returns a WWW::Route object for the given route ID representing a
transit route.

Note that the route ID is not the service operator route ID, but is the
PTV route ID as obtained from one of the other methods in this class.

See the WWW::Route page for more detail.

AUTHOR
------
Luke Poskitt, <ltp at cpan.org>

BUGS
----
Please report any bugs or feature requests to "bug-www-ptv at
rt.cpan.org", or through the web interface at
http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-PTV.  I will be
notified, and then you'll automatically be notified of progress on your
bug as I make changes.

SUPPORT
-------
You can find documentation for this module with the perldoc command.

        perldoc WWW::PTV

You can also look for information at:

* RT: CPAN's request tracker
	http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-PTV

* AnnoCPAN: Annotated CPAN documentation
	http://annocpan.org/dist/WWW-PTV

* CPAN Ratings
	http://cpanratings.perl.org/d/WWW-PTV

* Search CPAN
	http://search.cpan.org/dist/WWW-PTV/

LICENSE AND COPYRIGHT
---------------------
Copyright 2014 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

