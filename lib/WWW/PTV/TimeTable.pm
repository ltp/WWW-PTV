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
	map { /$_[1]/ and return 
		WWW::PTV::TimeTable::Schedule->new( 
			$_[0]->{map}{ @{ $_[0]->{stop_ids} }[$c]}
		);
		$c++ 
	} @{ $_[0]->{stop_names} };
}

1;

__END__

my $route = $ptv->get_route_by_id( 1 );
my $schedule = $ptv->get_route_by_id( 1 )->get_outbound_tt;

