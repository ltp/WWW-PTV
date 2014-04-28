package WWW::PTV::TimeTable;

use strict;
use warnings;

use WWW::PTV::TimeTable::Schedule;
use Carp qw(croak);

our $VERSION = '0.01';

our @ATTR = qw( route_id direction direction_desc name );

sub new {
	my($class, $stop_names, $stop_ids, $stop_times) = @_;
	my $self = bless {}, $class;
	$self->{stop_names} 	= $stop_names;
	$self->{stop_ids}	= $stop_ids;
	$self->{stop_times}	= $stop_times;
	@{ $self->{map} }{ @{ $self->{stop_ids} } } = @{ $self->{stop_times} };
	return $self
}

sub stop_ids {
	return @{ $_[0]->{stop_ids} }
}

sub stop_names {
	return @{ $_[0]->{stop_names} }
}

sub get_schedule_by_stop_id {
	return WWW::PTV::TimeTable::Schedule->new( $_[0]->{map}{$_[1]} )
}

sub get_schedule_by_stop_name {
	my $c = 0;
	# This is really ugly - but we need to use the index of the matching
	# stop name as a hash key to retrieve the stop times from the map
	map { /$_[1]/i and return 
		WWW::PTV::TimeTable::Schedule->new( 
			$_[0]->{map}{ @{ $_[0]->{stop_ids} }[$c]}
		);
		$c++ 
	} @{ $_[0]->{stop_names} };
}

1;

__END__

=head1 NAME

WWW::PTV::TimeTable - Class for operations with PTV timetables.

=head1 SYNOPSIS

	use WWW::PTV;
	my $ptv = WWW::PTV->new;
	
	# Get the next outbound departure time for route 1 from stop ID 19849
	my $next = $ptv->get_route_by_id(1)
		       ->get_outbound_tt;
	
	print "The next service is scheduled at @$next\n";
	
	# Get the next five services for route 1 from the same stop.
	my $next = $ptv->get_route_by_id(1)
		       ->get_outbound_tt
		       ->get_schedule_by_stop_id(19849)
		       ->next_five;

=head1 DESCRIPTION

This module implements a utility class providing operations for PTV timetables.

Please note the terminology used for the naming of this module should not imply
relationships between routes, timetables, schedules and other objects.  In brief, 
the relationships between objects defined in the WWW::PTV namespace are:

	       1       *
	route --- has ---> timetables

	           1       *
	timetable --- has ---> schedules

	          1       *
	schedule --- has ---> stops (service times)

That is to say; a route may have one or more timetables (inbound, outbound,
weekend, public holiday, etc.), each of which is composed of one or more
schedules where a schedules is defined as the list of service times for a 
particular stop on that route.

=head2 METHODS

=head3 stop_ids ()

	my @stop_ids = $timetable->stop_ids;
	print "Stops on this route: " . join ",", @stop_ids . "\n";

Returns a list of in order stop IDs for this route in the selected direction.
=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-ptv-timetable-schedule at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-PTV-TimeTable-Schedule>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::PTV::TimeTable::Schedule


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-PTV-TimeTable-Schedule>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-PTV-TimeTable-Schedule>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-PTV-TimeTable-Schedule>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-PTV-TimeTable-Schedule/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
