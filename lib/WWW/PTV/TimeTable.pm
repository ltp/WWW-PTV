package WWW::PTV::TimeTable;

use strict;
use warnings;

use Carp qw(croak);

our $VERSION = '0.01';

our @ATTR = qw( route_id direction direction_desc name );

sub new {
	my($class, $stop_names, $stop_ids, $stop_times) = @_;
	my $self = bless {}, $class;
	$self->{stop_names} 	= $stop_names;
	$self->{stop_ids}	= $stop_ids;
	$self->{stop_times}	= $stop_times;
	return $self
}

sub stop_ids {
	return @{ $_[0]->{stop_ids} }
}

sub stop_names {
	return @{ $_[0]->{stop_names} }
}

sub get_schedule_by_stop_id {
	my($self, $id) = @_;

	return @{ $self->{stop_times} }[
}

1;

__END__

