package WWW::PTV::Stop;

use strict;
use warnings;

use Carp qw(croak);

our @ATTR = qw(		address bicycle_cage bicycle_lockers bicycle_racks car_parking 
			escalator hearing_loop id latitude lift lighting lines 
			locality lockers longitude map_ref municipiality municipiality_id 
			myki_checks myki_machines phone_feedback phone_station postcode 
			public_phone public_toilet routes seating staff_hours stairs
			street tactile_paths taxi_rank transport_type vline_bookings 
			waiting_area_indoor waiting_area_sheltered wheelchair_accessible 
			zone );

foreach my $attr ( @ATTR ) {
	{
		no strict 'refs';
		*{ __PACKAGE__ .'::'. $attr } = sub {
			my( $self, $val ) = @_;
			$self->{$attr} = $val if $val;
			return $self->{$attr}
		}
	}
}

sub new {
	my( $class, %args ) = @_;
	my $self = bless {}, $class;
	$args{id} or croak 'Constructor failed: mandatory id argument not supplied';

	foreach my $attr ( @ATTR ) { $self->{$attr} = $args{$attr} }

	return $self
}

1;
