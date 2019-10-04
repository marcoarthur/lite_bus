package Lite::Bus::Model::Queue;
use Moose;
use 5.014;
use experimental qw(signatures);

has log => (
	is => 'ro',
	required => 1,
);

with qw(Lite::Bus::Role::Queue);

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

=head1 SYNOPSYS

=cut

