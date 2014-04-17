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
	return $_[0]->{map}{$_[1]}
}

1;

